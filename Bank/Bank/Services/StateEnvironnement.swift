//
//  StateEnvironnement.swift
//  Bank
//
//  Created by Olivier Adin on 11/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation


protocol EnvironnementProtocol{
    func Get_AccountsURL()->URL
}


public class Production : EnvironnementProtocol{
    func Get_AccountsURL() -> URL {
        let stringURL = "http://demo0576531.mockable.io/accounts"
        guard let url =  URL(string: stringURL) else{ fatalError("URL is not valid") }
        return url
    }
}
public class Developpement : EnvironnementProtocol{
    func Get_AccountsURL() -> URL {
        let stringURL = "http://51.75.194.143/accounts"
        guard let url =  URL(string: stringURL) else{ fatalError("URL is not valid") }
        return url
    }
}
public class LocalHost : EnvironnementProtocol{
    func Get_AccountsURL() -> URL {
        let stringURL = "http://localhost/accounts"
        guard let url =  URL(string: stringURL) else{ fatalError("URL is not valid") }
        return url
    }
}
