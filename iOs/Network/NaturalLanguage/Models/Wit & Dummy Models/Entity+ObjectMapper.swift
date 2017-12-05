//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import ObjectMapper

extension WitEntity: Mappable {
    
    public func mapping(map: Map) {
        confidence <- map["confidence"]
        type <- map["type"]
        grain <- map["grain"]
        value <- map["value"]
        from <- map["from"]
        to <- map["to"]
    }
    
}
