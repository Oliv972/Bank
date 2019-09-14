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
    var contrastedBackgroundColor : UIColor? { get }

    
    var title_Color       : UIColor? { get }
    var subtitle_Color    : UIColor? { get }
    var normal_Color      : UIColor? { get }

    var heading_1_Color   : UIColor? { get }
    var heading_2_Color   : UIColor? { get }
    var image_tint_Color  : UIColor? { get }

    var statusBarStyle    : UIStatusBarStyle? { get }
}


class DarkTheme: ThemeProtocol {
    
    var statusBarStyle: UIStatusBarStyle? = .lightContent
    
    var backgroundColor          : UIColor? = UIColor(named: "Color-DarkGray")
    var contrastedBackgroundColor: UIColor? = UIColor(named: "Color-Gray")
    
    var title_Color              : UIColor? = UIColor(named: "Color-Red")
    var subtitle_Color           : UIColor? = UIColor(named: "Color-Gray")
    var heading_1_Color          : UIColor? = UIColor(named: "Color-White")
    var heading_2_Color          : UIColor? = UIColor(named: "Color-DarkGray")
    var normal_Color             : UIColor? = UIColor(named: "Color-White")
    var image_tint_Color         : UIColor? = UIColor(named: "Color-Red")
}
