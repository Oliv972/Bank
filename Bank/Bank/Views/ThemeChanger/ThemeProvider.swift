//
//  ThemeProvider.swift
//  Bank
//
//  Created by Olivier Adin on 13/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation
import UIKit


public protocol ThemeProvider {
    func doChangeToTheme(newtheme : ThemeProtocol)
    func setRenderer(vc : ThemeColorChangeCapable?)
}

public protocol ThemeColorChangeCapable : NSObjectProtocol{
    func onThemeUpdate(theme : ThemeProtocol?)
}

public class ThemeColorVCProvider : ThemeProvider {
    init(vc : ThemeColorChangeCapable){
        self.renderer = vc
        self.renderer?.onThemeUpdate(theme: Store.shared.State_Theme)
    }
    
    public weak var renderer : ThemeColorChangeCapable?

    public func setRenderer(vc: ThemeColorChangeCapable?) {
        self.renderer = vc
    }
    public func doChangeToTheme(newtheme: ThemeProtocol) {
        Store.shared.State_Theme = newtheme
        self.renderer?.onThemeUpdate(theme: Store.shared.State_Theme)

    }
}
