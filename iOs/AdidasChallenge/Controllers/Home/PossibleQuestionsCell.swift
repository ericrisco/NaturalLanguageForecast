//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import UIKit

class PossibleQuestionsCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    
    var _question = ""
    var question: String{
        get{
            return _question
        }
        set{
            _question = newValue
            questionLabel.setTextAnimated(newText: _question)
        }
    }
    
}
