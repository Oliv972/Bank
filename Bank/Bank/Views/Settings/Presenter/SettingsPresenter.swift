//
//  SettingsPresenter.swift
//  Bank
//
//  Created by Olivier Adin on 13/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation



protocol Settings {

}
protocol SettingsView : NSObjectProtocol{
    
}

class SettingsController : Settings {
    private weak var view : SettingsView?
    
    init(view : SettingsView){
        self.view = view
    }
    
    
        
}
