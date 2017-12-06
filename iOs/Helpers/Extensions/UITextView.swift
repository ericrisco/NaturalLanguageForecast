//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 06/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

import UIKit

extension UITextView {
    func setTextAnimated(newText: String){
        self.fadeTransition(0.5)
        self.text = newText
    }
}
