//
//  BankCell.swift
//  Bank
//
//  Created by Olivier Adin on 11/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation
import UIKit

public class BankCell : UITableViewCell{
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
        return "BankCell"
    }
}

extension BankCell : ThemeColorChangeCapable {
    public func onThemeUpdate(theme: ThemeProtocol?) {
        self.contentView.backgroundColor = theme?.backgroundColor
        self.label_info.textColor = theme?.mainColor
        self.label_amount.textColor = theme?.secondColor
    }
}
