//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 04/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
    
    func appNavigationBar(){
        self.barTintColor = UIColor.black
        self.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.isTranslucent = false
    }
    
}

extension UINavigationItem {
    
    func setLogo(){
        self.title = "Adidas"
        self.titleView?.alpha = 1
    }
    
}
