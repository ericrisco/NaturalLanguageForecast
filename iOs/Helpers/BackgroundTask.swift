//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 04/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import UIKit

public class BackgroundTask {
    
    //Background Task Identifier
    var backgroundUpdateTask: UIBackgroundTaskIdentifier!
    
    //Begin the background task
    init() {
        backgroundUpdateTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            self.end()
        })
    }
    
    //End the background task
    func end() {
        UIApplication.shared.endBackgroundTask(backgroundUpdateTask)
        backgroundUpdateTask = UIBackgroundTaskInvalid
    }
}
