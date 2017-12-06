//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 06/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public class ResultForecast {
    
    // MARK: - Properties
    var currently: Forecast
    var hourly: [Forecast]
    var daily: [Forecast]
    
    // MARK: - Init
    init(currently: Forecast, hourly: [Forecast], daily: [Forecast]){
        self.currently = currently
        self.hourly = hourly
        self.daily = daily
    }
    
}
