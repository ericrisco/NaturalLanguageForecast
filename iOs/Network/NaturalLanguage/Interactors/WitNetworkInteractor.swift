//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 04/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public class NaturalLanguageInteractor{
    
    var manager: WitNetworkManager
    
    public init(manager: WitNetworkManager, urlString: String){
        self.manager = manager
        self.manager.urlString = urlString
    }
    
    public convenience init(){
        self.init(manager: WitNetworkAlamofire(), urlString: ReadConfig.value(keyname: ConfigKeys.WIT_AI_URL.rawValue))
    }
    
}

