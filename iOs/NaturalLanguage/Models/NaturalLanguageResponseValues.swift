//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public enum NaturalLanguageResponseValues: String {
    case temperatures = "temperatures"
    case current = "current"
    case weather = "weather"
    case running = "running"
    case forecast = "forecast"
    case wind = "wind"
    case training = "training"
    case outside = "outside"
    case precipitation = "precipitation"
    case cycling = "cycling"
    case ride = "ride"
    
    static func enumFromString(string:String) -> NaturalLanguageResponseValues? {
        if let item = NaturalLanguageResponseValues(rawValue: string) {
            if String(describing: item) == string {
                return item
            }
        }
        return nil
    }
}
