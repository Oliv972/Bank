//
//  BankInfos.swift
//  Bank
//
//  Created by Olivier Adin on 11/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation

public struct AccountList : Codable{
    let id : String
    let title : String
    let isCA : Int
    let amount : String
    let accounts : [Account]?
}
public struct Account : Codable {
    let id : String
    let title : String
    let amount : String
    let operations : [Operation]?
}
public struct Operation : Codable {
    let id : String
    let title : String
    let amount : String
    let date : String
}
