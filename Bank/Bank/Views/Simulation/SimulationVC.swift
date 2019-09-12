//
//  SimulationVC.swift
//  Bank
//
//  Created by Olivier Adin on 12/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation
import UIKit


public class SimulationVC : UIViewController{
    @IBOutlet weak var sliderTaux: UISlider!
    @IBOutlet weak var sliderMontant: UISlider!
    @IBOutlet weak var sliderDuree: UISlider!
    @IBOutlet weak var labelResult: UILabel!
    
    
    @IBOutlet weak var labelTaux: UILabel!
    @IBOutlet weak var labelDuree: UILabel!
    @IBOutlet weak var labelMontant: UILabel!

    
    
    
    var provider :  CreditCalculator?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.provider = DefaultCalculator(vc: self,
                                          defaultTaux: Double(self.sliderTaux.value),
                                          defaultMontant: Double(self.sliderMontant.value),
                                          defaultDuree: Int(self.sliderDuree.value))
    }
   
    @IBAction func unwindToSimulationVC(segue:UIStoryboardSegue) { }

    @IBAction func onSliderChange(_ sender: UISlider) {
   
        if sender == self.sliderTaux {
            self.provider?.onChangeTaux(newvalue: Double(sender.value))
        } else if sender == self.sliderMontant {
            self.provider?.onChangeMontant(newvalue:  Double(sender.value))
        } else if sender == self.sliderDuree {
            self.provider?.onChangeDuree(newvalue: Int(sender.value))
        }
    }
}


extension SimulationVC : CreditViewer {
    func onMontantUpdate(newvalue: String) {
        self.labelMontant.text = newvalue

    }
    
    func onDureeUpdate(newvalue: String) {
        self.labelDuree.text = newvalue

    }
    
    func onTauxUpdate(newvalue: String) {
        self.labelTaux.text = newvalue
    }
    
    func onNewResult(result: String) {
        self.labelResult.text = result
    }
}
