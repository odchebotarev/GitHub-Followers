//
//  Date+Ext.swift
//  GitHub Followers
//
//  Created by Oleg Chebotarev on 15.11.2020.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
}
