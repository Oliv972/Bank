//
//  NetworkState.swift
//  Bank
//
//  Created by Olivier Adin on 12/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation

protocol NetworkStateProtocol{
    func onWifiConnection()
    func onConnectionLoss()
    func onFourGConnection()
    func onTreeGConnection()
    func onEdgeConnection()
}

public class Connected : NetworkStateProtocol{
    func onWifiConnection() {
        //Already connected
    }
    func onConnectionLoss() {
        Store.shared.State_Network = Disconnected()
    }
    func onFourGConnection() {
        //Already connected
    }
    func onTreeGConnection() {
        //Already connected
    }
    func onEdgeConnection() {
        //Already connected
    }
}
public class Disconnected : NetworkStateProtocol{
    func onWifiConnection() {
        Store.shared.State_Network = Connected()
    }
    func onConnectionLoss() {
        //Already disconnected
    }
    func onFourGConnection() {
        Store.shared.State_Network = Connected()
    }
    func onTreeGConnection() {
        Store.shared.State_Network = Connected()
    }
    func onEdgeConnection() {
        Store.shared.State_Network = Connected()
    }
}
