//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import ObjectMapper

public class DarkskyForecast {
    
    var time: Double!
    var summary: String!
    var icon: String!
    var precipProbability: Double!
    var precipType: String!
    var temperature: Double!
    var temperatureHigh: Double!
    var temperatureLow: Double!
    var apparentTemperature: Double!
    var windSpeed: Double!
    
    init(time: Double,
         summary: String,
         icon: String,
         precipProbability: Double,
         precipType: String,
         temperature: Double,
         temperatureHigh: Double,
         temperatureLow: Double,
         apparentTemperature: Double,
         windSpeed: Double){
        
        self.time = time
        self.summary = summary
        self.icon = icon
        self.precipProbability = precipProbability
        self.precipType = precipType
        self.temperature = temperature
        self.temperatureHigh = temperatureHigh
        self.temperatureLow = temperatureLow
        self.apparentTemperature = apparentTemperature
        self.windSpeed = windSpeed
        
    }
    
    func toForecast() -> Forecast {
        let forecast = Forecast()
        forecast.time = Date(timeIntervalSince1970: self.time)
        forecast.summary = self.summary
        forecast.icon = self.icon
        forecast.precipitation_probability = self.precipProbability
        forecast.precipitation_type = self.precipType
        forecast.temperature = self.temperature
        forecast.temperature_low = self.temperatureLow
        forecast.temperature_high = self.temperatureHigh
        forecast.temperature = self.temperature
        forecast.temperature_aparent = self.apparentTemperature
        forecast.wind_speed = self.windSpeed
        return forecast
    }
    
    //Required by ObjectMapper
    required public init?(map: Map) {}
    
}

extension DarkskyForecast: Mappable{
    
    public func mapping(map: Map) {
        time <- map["time"]
        summary <- map["summary"]
        icon <- map["icon"]
        precipProbability <- map["precipProbability"]
        precipType <- map["precipType"]
        temperature <- map["temperature"]
        temperatureLow <- map["temperatureLow"]
        temperatureHigh <- map["temperatureHigh"]
        apparentTemperature <- map["apparentTemperature"]
        windSpeed <- map["windSpeed"]
    }
    
}



