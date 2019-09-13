//
//  StateEnvironnement.swift
//  Bank
//
//  Created by Olivier Adin on 11/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation


protocol EnvironnementProtocol{
    var url_account : URL { get }
    var url_visa_atm: URL { get }
}

public class Production : EnvironnementProtocol{
    var url_account : URL = URL(string: "http://demo0576531.mockable.io/accounts")!
    var url_visa_atm: URL = URL(string: "http://51.75.194.143/livio/atmlocation")!
}
public class Developpement : EnvironnementProtocol{
    var url_account : URL = URL(string: "http://51.75.194.143/accounts")!
    var url_visa_atm: URL = URL(string: "http://51.75.194.143/livio/atmlocation")!
}
public class LocalHost : EnvironnementProtocol{
    var url_account : URL = URL(string: "http://localhost/accounts")!
    var url_visa_atm: URL = URL(string: "http://localhost/livio/atmlocation")!
}
