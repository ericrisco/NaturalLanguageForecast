//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import ObjectMapper

public class WitEntityInterval {
    
    var value: String!
    var grain: WitEntityGrain!
    
    init(value: String, grain: WitEntityGrain){
        self.value = value
        self.grain = grain
    }
    
    //Required by ObjectMapper
    required public init?(map: Map) {}
}

