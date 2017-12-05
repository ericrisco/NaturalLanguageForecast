//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 04/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public protocol NetworkResponseProtocol {
    
    var status: Int { get set }
    var response: ResponseType { get set }
    var error: Error? { get set }
    
}
