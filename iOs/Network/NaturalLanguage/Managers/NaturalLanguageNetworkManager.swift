//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 04/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public protocol NaturalLanguageNetworkManager {
    
    var urlString: String! { get set }
    
    func message(query: String, onSuccess: @escaping ([WitEntity]) -> Void, onError: ErrorClosure?)

}
