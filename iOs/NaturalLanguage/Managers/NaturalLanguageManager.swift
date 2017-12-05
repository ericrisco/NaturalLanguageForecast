//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public protocol NaturalLanguageManager {
    
    func execute(query: String, onSuccess: @escaping (NaturalLanguageResponse) -> Void, onError: ErrorClosure?)
    
}
