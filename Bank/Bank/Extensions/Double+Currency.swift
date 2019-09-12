//
//  Double+Currency.swift
//  Bank
//
//  Created by Olivier Adin on 12/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation

extension Double {
    func formatToCurrency ()-> String {
        let number = NSNumber(value: self)
        return NumberFormatter.localizedString(from: number, number: .currency)
        
    }
}
