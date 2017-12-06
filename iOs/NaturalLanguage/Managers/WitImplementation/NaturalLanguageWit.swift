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
        
        let dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSXXX"
        
        //Filter entities by a trusted confidence !
        let trusting_confidence = Double(ReadConfig.value(keyname: ConfigKeys.TRUSTING_CONFIDENCE.rawValue))!
        let filtered = entities.filter({ entity in
            return entity.confidence >= trusting_confidence
        })
        
        filtered.forEach { (entity: WitEntity) in
            switch entity.type.rawValue {
            case WitEntityType.interval.rawValue:
                
                //Wit Response has interval datetime
                response.has_datetime_interval = true
                
                //Parsing interval Datetime
                if let from = entity.from, Date.isValidDate(dateString: from.value, dateFormat: dateFormat) {
                    response.datetime_from = Date.toDate(s: from.value, dateFormat: dateFormat)
                }
                
                if let to = entity.to, Date.isValidDate(dateString: to.value, dateFormat: dateFormat) {
                    response.datetime_to = Date.toDate(s: to.value, dateFormat: dateFormat)
                }
                
                //Time of interval -- Hourly or daily
                if let from = entity.from {
                    switch from.grain.rawValue {
                    case WitEntityGrain.hour.rawValue, WitEntityGrain.minute.rawValue, WitEntityGrain.second.rawValue:
                        //The app will show an hourly view
                        response.values.append(NaturalLanguageResponseValues.hourly)
                    default:
                        //The app will show a daily view
                        response.values.append(NaturalLanguageResponseValues.daily)
                    }
                }
                
            default:
                //Wit Response value type
                if let value = entity.value, let item = NaturalLanguageResponseValues.enumFromString(string: value) {
                    response.values.append(item)
                }else{
                    //If now mapped correctly --> Maybe It's a date
                    if let grain = entity.grain {
                        
                        if let date = entity.value, Date.isValidDate(dateString: date, dateFormat: dateFormat){
                            
                            response.has_datetime = true
                            response.datetime = Date.toDate(s: date, dateFormat: dateFormat)
                            
                            switch grain.rawValue {
                            case WitEntityGrain.hour.rawValue, WitEntityGrain.minute.rawValue, WitEntityGrain.second.rawValue:
                                //The app will show an hourly view
                                response.values.append(NaturalLanguageResponseValues.hourly)
                            default:
                                //The app will show a daily view
                                response.values.append(NaturalLanguageResponseValues.daily)
                            }
                            
                        }
                        
                    }
                }
                
                
            }
        }
        
        return response
        
    }
        
    
}
