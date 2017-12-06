//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public class ForecastDarkskyAlamofire: ForecastManager {
    
    public var urlString: String!
    
    public func forecast(query: ForecastQuery, onSuccess: @escaping (ResultForecast) -> Void, onError: ErrorClosure?) {
        
        DispatchQueue.global().async {
            
            let task = BackgroundTask.init()
            
            var params = Params()
            params.append(ReadConfig.value(keyname: ConfigKeys.DARKSKY_TOKEN.rawValue))
            params.append("\(query.gps_lat),\(query.gps_lon),\(Int(query.date.timeIntervalSince1970))")
            
            var queryStrings = QueryStrings()
            queryStrings["units"] = query.units
            
            let request = NetworkRequest.init(endpoint: self.urlString, params: params, queryStrings: queryStrings, headers: nil)
            
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
                            
                            var currently = Forecast()
                            var hourly = [Forecast]()
                            var daily = [Forecast]()
                            
                            if let value = response.result.value as? JSONDictonary, let jsonCurrently = value["currently"] {
                                let forecast = Mapper<DarkskyForecast>().map(JSONObject: jsonCurrently)
                                currently = forecast!.toForecast()
                            }
                            
                            if let value = response.result.value as? JSONDictonary,
                                let jsonHourly = value["hourly"] as? JSONDictonary,
                                let data = jsonHourly["data"] as? JSONArray {
                                
                                hourly = Mapper<DarkskyForecast>().mapArray(JSONArray: data).map({ forecast in
                                    return forecast.toForecast()
                                })
                            }
                            
                            if let value = response.result.value as? JSONDictonary,
                                let jsonHourly = value["daily"] as? JSONDictonary,
                                let data = jsonHourly["data"] as? JSONArray {
                                
                                daily = Mapper<DarkskyForecast>().mapArray(JSONArray: data).map({ forecast in
                                    return forecast.toForecast()
                                })
                            }
                            
                            let result = ResultForecast(currently: currently, hourly: hourly, daily: daily)
                            onSuccess(result)
                            
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
