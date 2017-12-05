//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setTextAnimated(newText: String){
        self.fadeTransition(0.5)
        self.text = newText
    }
}
