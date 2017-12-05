//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public class ForecastDummy: ForecastManager {
    
    public var urlString: String!
    
    public func forecast(query: ForecastQuery, onSuccess: @escaping ([Forecast]) -> Void, onError: ErrorClosure?) {
        
        var forecasts = [Forecast]()
        
        var forecast = Forecast.init(time: Date(), summary: "Dummy sun", icon: "blank", precipitation_probability: 0, precipitation_type: "snow", temperature: 30, temperature_aparent: 28, wind_speed: 20)
        forecasts.append(forecast)        
        
        onSuccess(forecasts)
    
    }
    
}

