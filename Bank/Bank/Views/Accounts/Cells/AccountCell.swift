//
//  AccountCell.swift
//  Bank
//
//  Created by Olivier Adin on 11/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation
import UIKit

public class AccountCell : UITableViewCell{
    
    @IBOutlet weak var label_info: UILabel!
    @IBOutlet weak var label_amount: UILabel!
    @IBOutlet weak var image_cheron: UIImageView!
    var colorsThemeProvider : ThemeProvider?
   
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.colorsThemeProvider = ThemeColorVCProvider(vc: self)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.colorsThemeProvider = ThemeColorVCProvider(vc: self)
    }
    
    public static func Identifier()-> String{
        return "AccountCell"
    }
}

extension AccountCell : ThemeColorChangeCapable {
    public func onThemeUpdate(theme: ThemeProtocol?) {
       
        
        self.contentView.backgroundColor = theme?.backgroundColor
        self.label_info.textColor   = theme?.subtitle_Color
        self.label_amount.textColor = theme?.normal_Color
        self.image_cheron.tintColor = theme?.image_tint_Color

    }
}
