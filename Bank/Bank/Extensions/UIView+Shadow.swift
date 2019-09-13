//
//  UIView+Shadow.swift
//  Bank
//
//  Created by Olivier Adin on 13/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    
    // OUTPUT 1
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0.3, height: 0.1)
        self.layer.shadowRadius = 1
    }
    
}
