//
//  SimulationCalculatorPresenter.swift
//  Bank
//
//  Created by Olivier Adin on 12/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation


protocol CreditCalculator {
    func onChangeTaux   (newvalue : Double)
    func onChangeMontant(newvalue : Double)
    func onChangeDuree  (newvalue : Int)
    
}

protocol CreditViewer : NSObjectProtocol{
    func onTauxUpdate   (newvalue : String)
    func onMontantUpdate(newvalue : String)
    func onDureeUpdate  (newvalue : String)

    func onNewResult(result : String)
}



public class DefaultCalculator : CreditCalculator {
    private weak var renderer : CreditViewer?

    private var current_Taux     : Double = 0.0
    private var current_Montant  : Double = 0.0
    private var current_Duree    : Int = 0
    
    init(vc : CreditViewer, defaultTaux : Double, defaultMontant : Double, defaultDuree : Int) {
        self.renderer = vc
        self.onChangeTaux(newvalue: defaultTaux)
        self.onChangeMontant(newvalue: defaultMontant)
        self.onChangeDuree(newvalue: defaultDuree)

        
    }
    
    func onChangeTaux(newvalue: Double) {
        let string = String(format: "%.2f", newvalue)
        self.renderer?.onTauxUpdate(newvalue: string)
        
        
        self.calculate(t: newvalue/100)
    }
    
    func onChangeMontant(newvalue: Double) {
        
        let string = ("\(newvalue.formatToCurrency())")
        self.renderer?.onMontantUpdate(newvalue: string)
        self.calculate(C: newvalue)
    }
    func onChangeDuree(newvalue: Int) {
        let years = newvalue/12
        
        
        
        let string = "\(newvalue) mois (environ \(years) ans)"
        self.renderer?.onDureeUpdate(newvalue: string)
        self.calculate(n: newvalue)
    }
    
    /// Simuler Credit
    ///
    /// - Parameters:
    ///   - C: Le montant souhaité à emprunter
    ///   - n: La durée du crédit (en mois)
    ///   - t: Le taux annuel (%).
    private func calculate (C : Double? = nil , n : Int? = nil, t : Double? = nil ){
        
     
        
        
        let C_unwrap = C ?? self.current_Montant
        let n_unwrap = n ?? self.current_Duree
        let t_unwrap = t ?? self.current_Taux
        
        
        self.current_Montant = C_unwrap
        self.current_Duree = n_unwrap
        self.current_Taux = t_unwrap

        
        //Le nombre a–n, lu « a puissance moins n », ou « a exposant moins n » par abus de langage, est l'inverse de la puissance n-ième de a
        let variable = 1 + (t_unwrap / 12)
        let variable_puissance_moins_n = 1 / (pow(variable, Double(n_unwrap)))
        
        let numerateur = C_unwrap * t_unwrap / 12
        let dénominateur = 1 -  variable_puissance_moins_n
        
        
        guard dénominateur != 0 else {
            print("Division par zéro")
            self.renderer?.onNewResult(result: "")

            return
        }
        

        let result = numerateur   / dénominateur
        let stringresult = String(format: "%.2f", result).formatToCurrency()
        self.renderer?.onNewResult(result: stringresult)
        
    }
    
    
}

//
//extension Double {
//    /// Rounds the double to decimal places value
//    func rounded(toPlaces places:Int) -> Double {
//        let divisor = pow(10.0, Double(places))
//        return (self * divisor).rounded() / divisor
//    }
//}
