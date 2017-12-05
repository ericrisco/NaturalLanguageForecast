//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

public class NaturalLanguageNetworkInteractor{
    
    var manager: NaturalLanguageNetworkManager
    
    public init(manager: NaturalLanguageNetworkManager, urlString: String){
        self.manager = manager
        self.manager.urlString = urlString
    }
    
    public convenience init(){
        self.init(manager: NaturalLanguageNetworkWitAlamofire(), urlString: ReadConfig.value(keyname: ConfigKeys.WIT_AI_URL.rawValue))
    }
    
}
