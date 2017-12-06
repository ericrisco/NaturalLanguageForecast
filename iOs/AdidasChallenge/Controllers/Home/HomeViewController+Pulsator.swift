//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 04/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import Pulsator

// Pulsator Delegate
extension HomeViewController {
    
    public func initPulsator(){
        pulsatorImage.layer.superlayer?.insertSublayer(pulsator, below: pulsatorImage.layer)
        pulsator.numPulse = 10
        pulsator.radius = 100
        pulsator.animationDuration = 6
        pulsator.backgroundColor = UIColor.init(hex: AddidasPalette.blue.rawValue)!.cgColor
    }
    
    public func showPulsator(){
        pulsator.start()
    }
    
    public func hidePulsator(){
        pulsator.stop()
    }
    
}
