//
//  String+Currency.swift
//  Bank
//
//  Created by Olivier Adin on 11/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation

extension String {
    func addDefaultCurrency ()-> String {
        return "\(self) €"
    }
}
