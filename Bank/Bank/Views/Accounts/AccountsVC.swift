//
//  AccountsVC.swift
//  Bank
//
//  Created by Olivier Adin on 11/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation
import UIKit


public class AccountsVC : UIViewController{
    
    var accountsProvider : AccountsProvider?
    var colorsThemeProvider : ThemeProvider?
    
    @IBOutlet weak var button_reload: UIButton!
    @IBOutlet weak var tableview: UITableView!

    @IBOutlet weak var buttonTheme: UIButton!
    
    @IBOutlet weak var labelTitle: UILabel!
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.accountsProvider = AccountsProvider(with: self)
        self.colorsThemeProvider = ThemeColorVCProvider(vc: self)
        self.labelTitle.addShadow()
    }
    @IBAction func actionButton(_ sender: UIButton) {
        if sender == self.button_reload   {
            self.accountsProvider?.doFetchAccounts()
        } else if sender == self.buttonTheme {
            
            let alert = UIAlertController(title: "Theme de couleur", message: "Veuillez choisir un thème de couleur", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "Sombre", style: UIAlertAction.Style.default, handler: { alert in
            
                self.colorsThemeProvider?.doChangeToTheme(newtheme: DarkTheme())
            }))
            alert.addAction(UIAlertAction(title: "Clair", style: UIAlertAction.Style.default, handler: { alert in
                self.colorsThemeProvider?.doChangeToTheme(newtheme: ClearTheme())

            }))
            alert.addAction(UIAlertAction(title: "Bleu", style: UIAlertAction.Style.default, handler: { alert in
                self.colorsThemeProvider?.doChangeToTheme(newtheme: BlueTheme())

            }))

            self.present(alert, animated: true, completion: nil)
        }
    }
    override public var preferredStatusBarStyle : UIStatusBarStyle {
        return Store.shared.State_Theme.statusBarStyle ?? UIStatusBarStyle.default
    }
}

extension AccountsVC  : UITableViewDelegate  {
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return "Crédit Agricole" } else { return "Autres Banques"  }
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UILabel()
        vw.textColor = Store.shared.State_Theme.heading_1_Color
        vw.backgroundColor = UIColor.clear
        vw.font =  UIFont(name: "HelveticaNeue-Medium", size: 16.0)!
        vw.addShadow()
        if section == 0 {
            vw.text = "Crédit Agricole"
        }
        else {
            vw.text = "Autres Banques"
        }
        
        
        return vw
    }
}
extension AccountsVC  : UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewmodel = self.accountsProvider else{
            return
        }
        var data : AccountsUIData
        if indexPath.section == 0{
            data = viewmodel.tableviewCAData[indexPath.row]
        }else {
             data = viewmodel.tableviewOtherData[indexPath.row]
        }
        if data.isBankCell {
            //ExpandBankCell
            viewmodel.onTapOnBank(id: data.idBank)
        }else{
            //Go To account detail
            viewmodel.onTapAccountDetail(idBank: data.idBank, idAccount: data.idAccount)
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let viewmodel = self.accountsProvider else{ return 0 }
        
        if section == 0 {
            let result = viewmodel.tableviewCAData.count
            return result
        } else {
            return viewmodel.tableviewOtherData.count
        }
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
       
        guard let viewmodel = self.accountsProvider else{ return 0 }
       
        if viewmodel.tableviewOtherData.count == 0{
            return 1
        }else {
            return 2
        }
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewmodel = self.accountsProvider else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            let data = viewmodel.tableviewCAData[indexPath.row]
            
            if(data.isBankCell){
                let cell = tableView.dequeueReusableCell(withIdentifier: BankCell.Identifier(), for: indexPath) as! BankCell
                cell.label_info.text = data.title
                cell.label_amount.text = data.amount
                cell.image_cheron.isHighlighted = data.idBank != viewmodel.currentSelectedBank
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: AccountCell.Identifier(), for: indexPath) as! AccountCell
                cell.label_info.text = data.title
                cell.label_amount.text = data.amount
                cell.image_cheron.isHighlighted = data.idBank != viewmodel.currentSelectedBank
                return cell
            }
            
            
        } else {
            let data = viewmodel.tableviewOtherData[indexPath.row]
            if(data.isBankCell){
                let cell = tableView.dequeueReusableCell(withIdentifier: BankCell.Identifier(), for: indexPath) as! BankCell
                cell.label_info.text = data.title
                cell.label_amount.text = data.amount
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: AccountCell.Identifier(), for: indexPath) as! AccountCell
                cell.label_info.text = data.title
                cell.label_amount.text = data.amount
                return cell
            }
        }
    }
}
extension AccountsVC  : AccountsView {
    func onTapOnDetail(account: Account) {
        let newView = self.storyboard?.instantiateViewController(withIdentifier: "AccountDetailVC") as! AccountDetailVC
        newView.account = account
        self.navigationController?.pushViewController(newView, animated: true)
    }
    
    
    func onStatus(newstate: ProviderStatus, message: String?) {
    
        OperationQueue.main.addOperation {

            UIView.animate(withDuration: 0.5, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                switch newstate {
                case .loading:
                    self.button_reload.isEnabled = false
                    break
                case .error:
                    self.button_reload.isEnabled = true
                    let alert = UIAlertController(title: "Mise à jour impossible", message: "Error reseau", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Reesayer", style: UIAlertAction.Style.default, handler: {alert in
                        self.accountsProvider?.doFetchAccounts()
                    }))
                    alert.addAction(UIAlertAction(title: "Annuler", style: UIAlertAction.Style.cancel, handler: nil))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    break
                case .updated:
                    self.button_reload.isEnabled = true
                    
                    self.tableview.reloadData()
                }
            }, completion: nil)
        }
    }
}
extension AccountsVC : ThemeColorChangeCapable {
    public func onThemeUpdate(theme: ThemeProtocol?) {
        self.view.backgroundColor = theme?.backgroundColor
        self.tableview.backgroundColor = theme?.backgroundColor
        self.labelTitle.textColor = theme?.title_Color
        self.tabBarController?.tabBar.tintColor = theme?.image_tint_Color
        self.buttonTheme.tintColor = theme?.image_tint_Color
        
        self.button_reload.backgroundColor = theme?.title_Color
        self.button_reload.setTitleColor(theme?.normal_Color, for: .normal)

        self.setNeedsStatusBarAppearanceUpdate()
        self.tableview.reloadData()
    }
}

