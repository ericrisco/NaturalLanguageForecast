//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 04/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation

extension Date{
        
    static func difference(day1: Date, day2: Date) -> Int{
        let c = (Calendar.current as NSCalendar).components([.day], from: day1, to: day2, options: [])
        return c.day!
    }
    
    static func isValidDate(dateString: String, dateFormat: String) -> Bool {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = dateFormat
        if let _ = dateFormatterGet.date(from: dateString) {
            return true
        } else {
            return false
        }
    }
    
    static func toString(date: Date, dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let retString = dateFormatter.string(from: date)
        return retString
    }
    
    static func toDate(s: String, dateFormat: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        if let date = dateFormatter.date(from: s) {
            return date
        }
        return Date()
    }
    
}
