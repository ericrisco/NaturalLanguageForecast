//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 04/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

extension Date{
    
    static let MOBILE_TO_BACKEND = "MM/dd/yyyy HH:mm"
    static let BACKEND_TO_MOBILE = "yyyyMMddHHmmss"
    
    static func difference(day1: Date, day2: Date) -> Int{
        let c = (Calendar.current as NSCalendar).components([.day], from: day1, to: day2, options: [])
        return c.day!
    }
    
    static func actualDate() -> String {
        
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        return "\(year)\(month)\(day)000000"
    }
    
    static func backendFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = MOBILE_TO_BACKEND
        let retString = dateFormatter.string(from: date)
        return retString
    }
    
    static func dateFormat(s: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = BACKEND_TO_MOBILE
        if let date = dateFormatter.date(from: s) {
            return date
        }
        return Date()
    }
    
}
