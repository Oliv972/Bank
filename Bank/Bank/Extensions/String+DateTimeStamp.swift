//
//  String+DateTimeStamp.swift
//  Bank
//
//  Created by Olivier Adin on 12/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation

extension String {
    func convertTimeStampToDate ()-> String {
        
        guard let toTimeInterval = TimeInterval(self) else{
            return "#ConversionProblem"
        }
        
        let date = Date(timeIntervalSince1970: toTimeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM/yyyy" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        
        return strDate
    }
}
