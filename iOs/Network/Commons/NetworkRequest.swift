//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 04/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public typealias ResponseType = (isSuccess: Bool, message: String?)
public typealias Params = [String]
public typealias QueryStrings = [String: String]
public typealias Headers = [String: String]

class NetworkRequest {
    
    var endpoint: String
    var params: Params?
    var queryStrings: QueryStrings?
    var addedHeaders: Headers?
    
    init(endpoint: String, params: Params? = nil, queryStrings: QueryStrings? = nil, headers: Headers? = nil){
        self.endpoint = endpoint
        self.params = params
        self.queryStrings = queryStrings
        self.addedHeaders = headers
    }
    
    var request: (url: URL, headers: Headers)  {
        
        var urlString = self.endpoint
        var headers = Headers()
        self.addedHeaders?.forEach({ (key, value) in
            headers[key] = value
        })

        if self.params != nil {
            urlString = "\(urlString)/"
            self.params?.forEach({ (value) in
                urlString = "\(urlString)\(value)/"
            })
        }
        
        if self.queryStrings != nil {
            urlString = "\(urlString)?"
            self.queryStrings?.forEach({ (key, value) in
                urlString = "\(urlString)\(key)=\(value)&"
            })
        }
        
        guard let encodeString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed), let url = URL(string: encodeString) else {
            fatalError("Error with URL...")
        }
        return (url, headers)
        
    }
}
