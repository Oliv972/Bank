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
    
    //@IBOutlet weak var button_reload: UIButton!
    @IBOutlet weak var tableview: UITableView!

    
    @IBOutlet weak var labelTitle: UILabel!
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.accountsProvider = AccountsProvider(with: self)
        self.colorsThemeProvider = ThemeColorVCProvider(vc: self)
        self.labelTitle.addShadow()
    }
    @IBAction func actionButton(_ sender: UIButton) {
        //if sender == self.button_reload   { self.accountsProvider?.doFetchAccounts() }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
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
        vw.textColor = Store.shared.State_Theme.mainColor
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
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: AccountCell.Identifier(), for: indexPath) as! AccountCell
                cell.label_info.text = data.title
                cell.label_amount.text = data.amount
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
            //self.label_info.text = message

            UIView.animate(withDuration: 0.1, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                switch newstate {
                case .loading:
                    //self.button_reload.isEnabled = false
                    //self.label_info.isHidden = false
                    break
                case .error:
                    //self.button_reload.isEnabled = true
                    //self.label_info.isHidden = false
                    break
                case .updated:
                    //self.button_reload.isEnabled = true
                    //self.label_info.isHidden = true
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
        self.labelTitle.textColor = theme?.mainColor
    }
}

