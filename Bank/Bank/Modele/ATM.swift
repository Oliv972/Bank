//
//  ATM.swift
//  Bank
//
//  Created by Olivier Adin on 13/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation


struct ATM : Codable{
    let latitude : Double
    let longitude : Double
    let bank_name : String?
    let address   : String
    let type : [atm_type]
}

enum atm_type : String, Codable{
    case VISA
    case MasterCard
    case AmericanExpress
}
