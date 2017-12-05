//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public class ForecastInteractor{
    
    var manager: ForecastManager
    
    public init(manager: ForecastManager, urlString: String){
        self.manager = manager
        self.manager.urlString = urlString
    }
    
    public convenience init(){
        self.init(manager: ForecastDarkskyAlamofire(), urlString: ReadConfig.value(keyname: ConfigKeys.DARKSKY_URL.rawValue))
    }
    
}
