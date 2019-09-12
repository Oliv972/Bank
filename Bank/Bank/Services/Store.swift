//
//  Store.swift
//  Bank
//
//  Created by Olivier Adin on 11/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation


public final class Store {
    
    static var shared : Store = Store()
    
    var State_Environnement : EnvironnementProtocol    = Production()
    var State_Application   : ApplicationStateProtocol = Locked()
    var State_Network       : NetworkStateProtocol     = Disconnected()


}
