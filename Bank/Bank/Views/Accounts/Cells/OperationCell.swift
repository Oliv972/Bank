//
//  OperationCell.swift
//  Bank
//
//  Created by Olivier Adin on 12/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation
import UIKit

public class OperationCell : UITableViewCell{
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_amount: UILabel!
    @IBOutlet weak var label_date: UILabel!
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
        return "OperationCell"
    }
}

extension OperationCell : ThemeColorChangeCapable {
    public func onThemeUpdate(theme: ThemeProtocol?) {
        self.contentView.backgroundColor = theme?.backgroundColor
        self.label_title.textColor = theme?.subtitle_Color
        self.label_amount.textColor = theme?.title_Color
        self.label_date.textColor = theme?.normal_Color

        
       
        
    }
}
