//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import ObjectMapper

extension WitEntityInterval: Mappable {
    
    public func mapping(map: Map) {
        value <- map["value"]
        grain <- map["grain"]
    }
    
}
