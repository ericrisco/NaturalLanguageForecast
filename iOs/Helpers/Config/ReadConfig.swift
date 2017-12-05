//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 04/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

public class ReadConfig {
    class func value(keyname:String) -> String {
        let filePath = Bundle.main.path(forResource: "config", ofType: "plist")
        let plist = NSDictionary(contentsOfFile: filePath!)
        let value:String = plist?.object(forKey: keyname) as! String
        return value
    }
}
