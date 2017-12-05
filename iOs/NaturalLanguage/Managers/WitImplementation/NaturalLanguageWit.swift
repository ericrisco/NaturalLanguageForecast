//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public class NaturalLanguageWit: NaturalLanguageManager {
    
    public func execute(query: String, onSuccess: @escaping (NaturalLanguageResponse) -> Void, onError: ErrorClosure?) {
        
        let networkManager = NaturalLanguageNetworkInteractor.init(manager: NaturalLanguageNetworkWitAlamofire(),
                                                                   urlString: ReadConfig.value(keyname: ConfigKeys.WIT_AI_URL.rawValue)).manager
        
        networkManager.message(query: query, onSuccess: { (entities) in
            
            onSuccess(self.mapResults(entities: entities))
            
        }) { (error) in
            if let onError = onError {
                onError(error)
            }
        }
    }
    
    public func mapResults(entities: [WitEntity]) -> NaturalLanguageResponse {
        
        let response = NaturalLanguageResponse()
        
        entities.forEach { (entity: WitEntity) in
            switch entity.type.rawValue {
            case WitEntityType.interval.rawValue:
                break
            default:
                if let value = entity.value, let item = NaturalLanguageResponseValues.enumFromString(string: value) {
                    response.values.append(item)
                }
            }
        }
        
        return response
        
    }
        
    
}
