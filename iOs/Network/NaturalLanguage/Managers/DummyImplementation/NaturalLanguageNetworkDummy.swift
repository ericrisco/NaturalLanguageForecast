//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 04/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public class NaturalLanguageNetworkDummy: NaturalLanguageNetworkManager {
    
    public var urlString: String!
    
    public func message(query: String, onSuccess: @escaping ([WitEntity]) -> Void, onError: ErrorClosure?) {
        
        var entities = [WitEntity]()
        
        var entity = WitEntity.init(confidence: 1.0, type: WitEntityType.value, grain: nil, value: "forecast", from: nil, to: nil)
        entities.append(entity)
        
        entity = WitEntity.init(confidence: 0.7, type: WitEntityType.value, grain: nil, value: "running", from: nil, to: nil)
        entities.append(entity)
        
        onSuccess(entities)        
        
    }

}
