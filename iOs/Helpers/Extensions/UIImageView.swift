//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 06/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    public func imageFromServerURL(urlString: String, placeholder: String = "placeholder") {
        
        let image = UIImage(named: placeholder)
        if(self.image == nil){
            self.image = image
        }
        
        print(urlString)
        
        if urlString != "" {
            DispatchQueue.global().async {
                do{
                    let d = try Files.getFileFrom(urlString: urlString)
                    DispatchQueue.main.async {
                        let image = UIImage(data: d)
                        UIView.transition(with: self,
                                          duration: 0.4,
                                          options: .transitionCrossDissolve,
                                          animations: { self.image = image },
                                          completion: nil)
                        
                    }
                }catch{
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
        
    }
}
