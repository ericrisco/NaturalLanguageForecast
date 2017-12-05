//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public class NaturalLanguageInteractor{
    
    var manager: NaturalLanguageManager
    
    public init(manager: NaturalLanguageManager){
        self.manager = manager
    }
    
    public convenience init(){
        self.init(manager: NaturalLanguageWit())
    }
    
}
