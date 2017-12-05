//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import ObjectMapper

public class WitEntity {
    
    var confidence: Double!
    var type: WitEntityType!
    var grain: WitEntityGrain?
    var value: String?
    var from: WitEntityInterval?
    var to: WitEntityInterval?
    
    init(confidence: Double, type: WitEntityType, grain: WitEntityGrain?, value: String?, from: WitEntityInterval?, to: WitEntityInterval?){
        self.confidence = confidence
        self.type = type
        self.grain = grain
        self.value = value
        self.from = from
        self.to = to
    }
    
    //Required by ObjectMapper
    required public init?(map: Map) {}
}

