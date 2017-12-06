//
//  ListForecastViewController.swift
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 06/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import UIKit

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
        backgroundView?.backgroundColor = UIColor(patternImage: UIImage(named: "Portrait")!)
    }
    
    // MARK: - UI
    func reloadUI(){
        
        isInterval = to != nil
        tableTopConstrain.constant = isInterval ? 15 : 250
        
        currentlyDateLabel.setTextAnimated(newText: result.currently.timeConverted)
        currentlyTemperatureLabel.setTextAnimated(newText: result.currently.temperatureCelsius)
        currentlyApparentTemperatureLabel.setTextAnimated(newText: result.currently.apparentTemperatureCelsius)
        currentlySummaryLabel.setTextAnimated(newText: result.currently.summary)
        currentlyWindLabel.setTextAnimated(newText: result.currently.windSpeedInternational)
        currentlyPrecipitationLabel.setTextAnimated(newText: result.currently.precipitationPhrase)
        currentlyIconImage.imageFromServerURL(urlString: result.currently.imageUrl)
        
    }
    
}
