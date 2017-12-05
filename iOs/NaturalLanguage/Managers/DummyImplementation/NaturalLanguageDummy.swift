//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public class NaturalLanguageWitDummy: NaturalLanguageManager {
    
    public func execute(query: String, onSuccess: @escaping (NaturalLanguageResponse) -> Void, onError: ErrorClosure?) {
        
        let networkManager = NaturalLanguageNetworkInteractor.init(manager: NaturalLanguageNetworkDummy(), urlString: "").manager
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
        
        //Example query: "Can I go running right now?" The decisions might be like this
        response.has_datetime = true
        response.datetime = Date.dateFormat(s: Date.actualDate())
        response.values.append(.running)
        response.values.append(.outside)
        
        return response
    }
    
}
