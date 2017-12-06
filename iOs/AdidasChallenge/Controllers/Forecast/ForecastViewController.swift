//
//  ListForecastViewController.swift
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 06/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import UIKit
import CRNotifications

class ForecastViewController: UIViewController {

    // MARK: - UI attributes
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var currentlyDateLabel: UILabel!
    @IBOutlet weak var currentlyTemperatureLabel: UILabel!
    @IBOutlet weak var currentlyApparentTemperatureLabel: UILabel!
    @IBOutlet weak var currentlySummaryLabel: UILabel!
    @IBOutlet weak var currentlyWindLabel: UILabel!
    @IBOutlet weak var currentlyPrecipitationLabel: UILabel!
    @IBOutlet weak var currentlyIconImage: UIImageView!
    
    // MARK: - Table attributes
    @IBOutlet weak var tableTopConstrain: NSLayoutConstraint!
    @IBOutlet weak var forecastTable: UITableView!
    var tableValues: [Forecast]!
    
    // MARK: - Values
    var currently: Forecast!
    var result: ResultForecast!
    var isInterval: Bool!
    var showTrainingMessage: Bool!
    var from: Date!
    var to: Date!
    var naturalLanguageValues: [NaturalLanguageResponseValues]!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastTable.dataSource = self
        forecastTable.delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadUI()
        initTable()
        showMessages()
        backgroundView?.backgroundColor = UIColor(patternImage: UIImage(named: "Portrait")!)
    }
    
    // MARK: - UI
    func reloadUI(){
        
        isInterval = to != nil
        tableTopConstrain.constant = isInterval ? 15 : 250
        
        if result.daily.count >= 1 {
            currently = result.daily[0]
        }else{
            currently = result.currently
        }
        
        currentlyDateLabel.setTextAnimated(newText: currently.timeConverted)
        currentlyTemperatureLabel.setTextAnimated(newText: currently.temperatureCelsius)
        currentlyApparentTemperatureLabel.setTextAnimated(newText: currently.apparentTemperatureCelsius)
        currentlySummaryLabel.setTextAnimated(newText: currently.summary)
        currentlyWindLabel.setTextAnimated(newText: currently.windSpeedInternational)
        currentlyPrecipitationLabel.setTextAnimated(newText: currently.precipitationPhrase)
        currentlyIconImage.imageFromServerURL(urlString: currently.imageUrl)
        
    }
    
    func showMessages(){
        //Shows one message for every entity found
        
        var message = ""
        
        if naturalLanguageValues.contains(NaturalLanguageResponseValues.training) {
            // CASE 1 - User requested if he can train outside
            
            var probability = 0.0
            
            if isInterval && tableValues.count > 0 {
                probability = tableValues.map({ $0.precipitation_probability }).reduce(0, { x,y in x + y}) / Double(tableValues.count)
            }else{
                probability = currently.precipitation_probability
            }
            
            switch probability { //TODO: Make this a little bit more dynamic
            case 0.01...0.499:
                message = "You can train outside but there is a \(Double(probability * 100).toInt()!)% of precipitations ☂️. "
            case 0.5...1:
                message = "Don't you prefer going to the gym today? \(Double(probability * 100).toInt()!)% of precipitations ☂️. "
            default:
                message = "You can train outside normally 💪. "
            }
            
        }
        
        if naturalLanguageValues.contains(NaturalLanguageResponseValues.temperatures) {
            // CASE 2 - User requested temperatures
            if !isInterval {
                message = "\(message)The temperature for this day is \(currently.temperatureCelsius)"
            }
        }
        
        if naturalLanguageValues.contains(NaturalLanguageResponseValues.weather) {
            // CASE 3 - User requested weather
            if !isInterval {
                message = "\(message)The weather for this day is \(currently.summary!)"
            }
        }
        
        if naturalLanguageValues.contains(NaturalLanguageResponseValues.wind) {
            // CASE 4 - User requested wind
            if !isInterval {
                message = "\(message)The wind speed for this day is \(currently.windSpeedInternational)"
            }
        }
        
        if naturalLanguageValues.contains(NaturalLanguageResponseValues.precipitation) {
            // CASE 5 - User requested precipitations
            var probability = 0.0
            
            if isInterval && tableValues.count > 0 {
                probability = tableValues.map({ $0.precipitation_probability }).reduce(0, { x,y in x + y}) / Double(tableValues.count)
            }else{
                probability = currently.precipitation_probability
            }
            
            if probability >= 0 {  //TODO: Make this probabilities dynamic
                message = "Probability \(Double(probability).toInt()!)% of precipitations ☂️. "
            }else{
                message = "No precipitations for this day. "
            }
        }
        
        if message != "" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                CRNotifications.showNotification(type: .info, title: "Information", message: message, dismissDelay: 15)
            }
        }
        
    }
    
    func showSingleMessage(title: String, message: String){
    }
    
}
