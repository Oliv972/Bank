//
//  ColorThemeState.swift
//  Bank
//
//  Created by Olivier Adin on 13/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation
import UIKit

public protocol ThemeProtocol {
    var backgroundColor : UIColor? { get }
    var mainColor       : UIColor? { get }
    var secondColor     : UIColor? { get }
    var thirdColor      : UIColor? { get }

}


class DarkTheme: ThemeProtocol {
    var backgroundColor: UIColor? = UIColor(named: "Color-Blackboard")
    var mainColor      : UIColor? = UIColor(named: "Color-Grain")
    var secondColor    : UIColor? = UIColor(named: "Color-Tan")
    var thirdColor     : UIColor? = UIColor(named: "Color-Oxblood")

    
}
