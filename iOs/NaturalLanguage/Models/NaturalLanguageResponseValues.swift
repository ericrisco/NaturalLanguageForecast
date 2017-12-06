//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public enum NaturalLanguageResponseValues: String {
    case temperatures = "temperatures"
    case weather = "weather"
    case wind = "wind"
    case training = "training"
    case precipitation = "precipitation"
    case hourly = "hourly"
    case daily = "daily"
    
    static func enumFromString(string:String) -> NaturalLanguageResponseValues? {
        if let item = NaturalLanguageResponseValues(rawValue: string) {
            if String(describing: item) == string {
                return item
            }
        }
        return nil
    }
}
