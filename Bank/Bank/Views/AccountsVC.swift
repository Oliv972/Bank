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
    
    var accountsProvider : VMAccountsProvider?
    
    @IBOutlet weak var button_reload: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var label_info: UILabel!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.accountsProvider = VMAccountsProvider(with: self)
    }
    @IBAction func actionButton(_ sender: UIButton) {
        if sender == self.button_reload   { self.accountsProvider?.doFetchAccounts() }
    }
}


extension AccountsVC  : UITableViewDelegate  {
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Credit Agricole"
        }else {
            return "Autres Banques"
        }
    }
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension AccountsVC  : UITableViewDataSource{
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
        guard let viewmodel = self.accountsProvider else{
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            let data = viewmodel.tableviewCAData[indexPath.row]
            
            if(data.isBankCell){
                let cell = tableView.dequeueReusableCell(withIdentifier: "Bank", for: indexPath) as! BankCell
                cell.label_info.text = data.title
                cell.label_amount.text = data.amount 
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "Account", for: indexPath) as! AccountCell
                cell.label_info.text = data.title
                cell.label_amount.text = data.amount
                return cell
            }
            
            
        } else {
            let data = viewmodel.tableviewOtherData[indexPath.row]
            if(data.isBankCell){
                let cell = tableView.dequeueReusableCell(withIdentifier: "Bank", for: indexPath) as! BankCell
                cell.label_info.text = data.title
                cell.label_amount.text = data.amount
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "Account", for: indexPath) as! AccountCell
                cell.label_info.text = data.title
                cell.label_amount.text = data.amount
                return cell
            }
        }
    }
}

extension AccountsVC :  VMAccountsRenderer {
    func onStatus(newstate: VMStatus, message: String?) {
    
        OperationQueue.main.addOperation {
            self.label_info.text = message

            UIView.animate(withDuration: 0.1, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                switch newstate {
                case .loading:
                    self.button_reload.isEnabled = false
                    self.label_info.isHidden = false
                case .error:
                    self.button_reload.isEnabled = true
                    self.label_info.isHidden = false
                case .updated:
                    self.button_reload.isEnabled = true
                    self.label_info.isHidden = true
                    self.tableview.reloadData()
                }
            }, completion: nil)
        }
    }
}

