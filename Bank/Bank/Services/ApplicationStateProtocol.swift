//
//  ApplicationStateProtocol.swift
//  Bank
//
//  Created by Olivier Adin on 12/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation

protocol ApplicationStateProtocol{
    func doUnlockApplication()
    func doLockApplication()
    func doFetchAccounts()
    
    func onAccountsUpdate()
    func onAppLock()
    func onAppUnLock()
}

public class Unlocked : ApplicationStateProtocol{
    func doUnlockApplication() {
        //Already unlocked
    }
    func doLockApplication() {}
    func doFetchAccounts() {}
    func onAccountsUpdate() {}
    func onAppLock() {
        Store.shared.State_Application = Locked()
    }
    func onAppUnLock() {}
}
public class InBackGround : ApplicationStateProtocol{
    func doUnlockApplication() {}
    func doLockApplication() {}
    func doFetchAccounts() {}
    
    func onAccountsUpdate() {}
    func onAppLock() {}
    func onAppUnLock() {}
}
public class Locked : ApplicationStateProtocol{
    func doUnlockApplication() {}
    func doLockApplication() {}
    func doFetchAccounts() {}
    
    func onAccountsUpdate() {}
    func onAppLock() {}
    func onAppUnLock() {}
}
