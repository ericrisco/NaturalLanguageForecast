//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public class Forecast {
    
    // MARK: - Properties
    var time: Date!
    var summary: String!
    var icon: String!
    var precipitation_probability: Double!
    var precipitation_type: String!
    
    var temperature: Double!
    var temperature_high: Double!
    var temperature_low: Double!
    
    var temperature_aparent: Double!
    var temperature_aparent_high: Double!
    var temperature_aparent_low: Double!
    
    var wind_speed: Double!
    
    // MARK: - Init
    init(time: Date,
         summary: String,
         icon: String,
         precipitation_probability: Double,
         precipitation_type: String,
         temperature: Double,
         temperature_aparent: Double,
         wind_speed: Double){
        
        self.time = time
        self.summary = summary
        self.icon = icon
        self.precipitation_type = precipitation_type
        self.precipitation_probability = precipitation_probability
        self.temperature = temperature
        self.temperature_aparent = temperature_aparent
        self.wind_speed = wind_speed
        
    }
    
    convenience init(){
        self.init(time: Date(), summary: "", icon: "", precipitation_probability: 0, precipitation_type: "", temperature: 0, temperature_aparent: 0, wind_speed: 0)
    }
    
    // MARK: - View Getters
    var timeConverted : String {
        get {
            guard let time = self.time else {
                return ""
            }
            
            return Date.toString(date: time, dateFormat: "dd/MM/YYYY HH:mm")
        }
    }
    
    var temperatureCelsius : String{
        get {
            guard let _ = self.temperature else {
                guard let _ = self.temperature_high else {
                    return ""
                }
                return "\(Double(self.temperature_high).toInt()!)ºC"
            }
            return "\(Double(self.temperature).toInt()!)ºC"
        }
    }
    
    var apparentTemperatureCelsius : String{
        get {
            guard let _ = self.temperature_aparent else {
                guard let _ = self.temperature_low else {
                    return ""
                }
                return "Lowest: \(Double(self.temperature_low).toInt()!)ºC"
            }
            
            return "Apparent: \(Double(self.temperature_aparent).toInt()!)ºC"
        }
    }
    
    var precipitationPhrase : String{
        get {
            guard let type = precipitation_type, let probability = self.precipitation_probability else {
                return ""
            }
            
            let perc = Double(probability * 100).rounded(toPlaces: 2)
            return "Probability to \(type): \(perc)%"
        }
    }
    
    var windSpeedInternational: String {
        get {
            guard let wind_speed = self.wind_speed else {
                return ""
            }
            
            return "Wind speed: \(Double(wind_speed).rounded(toPlaces: 2))km/h"
        }
    }
    
    var imageUrl: String {
        get {
            guard let _ = self.icon else {
                return ""
            }
            
            let absoluteUrl = ReadConfig.value(keyname: ConfigKeys.ICONS_URL.rawValue)
            return absoluteUrl.replacingOccurrences(of: "<<ICON_NAME>>", with: icon!)
        }
    }
    
}
