//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public protocol ForecastManager {
    
    var urlString: String! { get set }
    
    func forecast(query: ForecastQuery, onSuccess: @escaping (ResultForecast) -> Void, onError: ErrorClosure?)
    
}
