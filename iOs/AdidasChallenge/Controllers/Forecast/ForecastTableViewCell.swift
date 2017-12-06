//
//  ForecastTableViewCell.swift
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 06/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import UIKit

// TableViewCell
class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var apparentTemperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    private var _forecast = Forecast.init()
    var forecast: Forecast{
        get{
            return _forecast
        }
        set{
            _forecast = newValue
            
            dateLabel.setTextAnimated(newText: _forecast.timeConverted)
            temperatureLabel.setTextAnimated(newText: _forecast.temperatureCelsius)
            apparentTemperatureLabel.setTextAnimated(newText: _forecast.apparentTemperatureCelsius)
            summaryLabel.setTextAnimated(newText: _forecast.summary)
            windLabel.setTextAnimated(newText: _forecast.windSpeedInternational)
            precipitationLabel.setTextAnimated(newText: _forecast.precipitationPhrase)
            iconImage.imageFromServerURL(urlString: _forecast.imageUrl)
            
        }
    }

    
    
}
