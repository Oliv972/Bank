//
//  LocationCell.swift
//  Bank
//
//  Created by Olivier Adin on 14/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation
import UIKit

public class LocationCell : UICollectionViewCell{
    
    var colorsThemeProvider : ThemeProvider?
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubTitle: UILabel!
    //@IBOutlet weak var buttonMenu: UIButton!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.colorsThemeProvider = ThemeColorVCProvider(vc: self)
        //self.buttonMenu.layer.cornerRadius = self.buttonMenu.frame.height/2
        self.contentView.layer.cornerRadius = 5
        self.contentView.layer.borderWidth = 1.0
        
        self.contentView.layer.borderColor = UIColor.clear.cgColor
       // self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 1.0
       // self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath

    }
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.colorsThemeProvider = ThemeColorVCProvider(vc: self)
    }
    
    public static func Identifier()->String{
        return "LocationCell"
    }
}

extension LocationCell : ThemeColorChangeCapable {
    public func onThemeUpdate(theme: ThemeProtocol?) {
        self.contentView.backgroundColor = theme?.backgroundColor

        self.labelTitle.textColor = theme?.title_Color
        self.labelSubTitle.textColor = theme?.subtitle_Color

    }
}
