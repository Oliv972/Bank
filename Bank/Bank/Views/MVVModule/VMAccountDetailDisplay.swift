//
//  VMAccountDetailDisplay.swift
//  Bank
//
//  Created by Olivier Adin on 11/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation
import UIKit


protocol VMAccountDetailsRenderer where Self : UIViewController{
    
}

public struct UIDetailCellInfo{
    var title  : String
    var amount : String
    var date   : String
}

public final class VMAccountsDetailProvider{
    
    
    private weak var vc : VMAccountDetailsRenderer?
    private var account : Account?

    public var tableviewData    : [UIDetailCellInfo] = []
    
    init(with viewcontroller : VMAccountDetailsRenderer, with account : Account?) {
        self.vc = viewcontroller
        self.account = account
    }
}
