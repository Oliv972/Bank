//
//  AccountDetailVC.swift
//  Bank
//
//  Created by Olivier Adin on 11/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation
import UIKit


public class AccountDetailVC : UIViewController {
    public var account : Account?
    
    var accountDetailProvider : VMAccountsDetailProvider?

    @IBOutlet weak var labelAmount: UILabel!
    @IBOutlet weak var labelAccountName: UILabel!
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail du compte"
        self.accountDetailProvider = VMAccountsDetailProvider(with: self, with: account )
    }
}

extension AccountDetailVC : VMAccountDetailsRenderer {
    
}
