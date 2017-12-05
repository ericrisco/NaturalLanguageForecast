//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import Alamofire

class NetworkResponseAlamofire: NetworkResponseProtocol {
    
    var status: Int
    var error: Error?
    var response: ResponseType
    
    init(response: DataResponse<Any>){
        self.status = 200
        
        if let res = response.response {
            self.status = res.statusCode
        }
        if let error = response.result.error {
            self.error = error
        }
        
        if self.status == 200 {
            self.response = (true, "")
            return
        }
        
        var message = "Server error..."
        if let error = self.error {
            message = error.localizedDescription
        }
        
        
        self.error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : message])
        
        self.response = (false, message)
        
        
    }
    
}
