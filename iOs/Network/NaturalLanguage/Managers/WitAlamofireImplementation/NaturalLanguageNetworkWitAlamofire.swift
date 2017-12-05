//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 04/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public class NaturalLanguageNetworkWitAlamofire: NaturalLanguageNetworkManager {
    
    public var urlString: String!
    
    public func message(query: String, onSuccess: @escaping ([WitEntity]) -> Void, onError: ErrorClosure?) {
        
        DispatchQueue.global().async {
            
            let task = BackgroundTask.init()
            
            var queryStrings = QueryStrings()
            queryStrings["v"] = ReadConfig.value(keyname: ConfigKeys.WIT_AI_VERSION.rawValue)
            queryStrings["q"] = query
            
            var headers = Headers()
            headers["Authorization"] = ReadConfig.value(keyname: ConfigKeys.WIT_AI_TOKEN.rawValue)
            
            let request = NetworkRequest.init(endpoint: self.urlString, params: nil, queryStrings: queryStrings, headers: headers)
           
            Alamofire.request(
                request.request.url,
                method: .get,
                parameters: nil,
                encoding: JSONEncoding.default,
                headers: request.request.headers)
                .responseJSON(completionHandler: { response in
                    DispatchQueue.main.async {
                        
                        let alamofireResponse = NetworkResponseAlamofire.init(response: response)
                        if alamofireResponse.response.isSuccess {
                            
                            var entities = [WitEntity]()
                            
                            if let value = response.result.value as? JSONDictonary, let jsonEntities = value["entities"] as? JSONDictonary {
                                jsonEntities.forEach {
                                    if let objects = $0.value as? JSONArray {
                                        let array = Mapper<WitEntity>().mapArray(JSONArray: objects)
                                        entities.append(contentsOf: array)
                                    }
                                }
                            }
                            
                            onSuccess(entities)
                            
                        }else{
                            if let onError = onError {
                                onError(Errors.resourcePointedByUrlNotReachable)
                            }
                        }
                        
                    }
            })
            
            task.end()
            
        }
        
    }

}
