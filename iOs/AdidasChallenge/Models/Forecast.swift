//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public class Forecast {
    
    var time: Date!
    var summary: String!
    var icon: String!
    var precipitation_probability: Double!
    var precipitation_type: String!
    var temperature: Double!
    var temperature_aparent: Double!
    var wind_speed: Double!
    
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
    
    var timeConverted : String {
        get {
            return Date.toString(date: self.time, dateFormat: "dd/MM/YYYY HH:mm:ss")
        }
    }
    
    var temperatureCelsius : String{
        get {
            return "\(Double(self.temperature).toInt()!)ºC"
        }
    }
    
    var apparentTemperatureCelsius : String{
        get {
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
            return "Wind speed: \(Double(self.wind_speed).rounded(toPlaces: 2))km/h"
        }
    }
    
    var imageUrl: String {
        get {
            let absoluteUrl = ReadConfig.value(keyname: ConfigKeys.ICONS_URL.rawValue)
            return absoluteUrl.replacingOccurrences(of: "<<ICON_NAME>>", with: icon!)
        }
    }
    
    convenience init(){
        self.init(time: Date(), summary: "", icon: "", precipitation_probability: 0, precipitation_type: "", temperature: 0, temperature_aparent: 0, wind_speed: 0)
    }
    
}
