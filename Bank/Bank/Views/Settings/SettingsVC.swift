//
//  SettingsVC.swift
//  Bank
//
//  Created by Olivier Adin on 13/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation
import UIKit



class SettingsVC : UIViewController {
    
    var controller : Settings?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controller = SettingsController(view: self)
    }
}



extension SettingsVC : SettingsView {
    
}
