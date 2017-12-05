//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public struct ForecastQuery {
    
    var gps_lat: Double
    var gps_lon: Double
    var date: Date
    var units: String
    
    init(gps_lat: Double, gps_lon: Double, date: Date, units: String){
        self.gps_lat = gps_lat
        self.gps_lon = gps_lon
        self.date = date
        self.units = units
    }
    
}
