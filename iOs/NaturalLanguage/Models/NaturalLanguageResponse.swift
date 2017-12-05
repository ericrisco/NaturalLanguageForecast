//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public class NaturalLanguageResponse {
    
    var has_datetime_interval: Bool?
    var datetime_from: Date?
    var datetime_to: Date?
    
    var has_datetime: Bool?
    var datetime: Date?
    
    var values: [NaturalLanguageResponseValues]
    
    init(){
        self.has_datetime_interval = false
        self.datetime_from = Date()
        self.datetime_to = Date()
        
        self.has_datetime = false
        self.datetime = Date()
        
        self.values = [NaturalLanguageResponseValues]()
    }
    
}
