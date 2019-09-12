//
//  AccountDetailVC.swift
//  Bank
//
//  Created by Olivier Adin on 11/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation
import UIKit


public class AccountDetailVC : UIViewController {
    public var account : Account?
    
    var accountDetailProvider : AccountsDetailProvider?

    @IBOutlet weak var labelAmount: UILabel!
    @IBOutlet weak var labelAccountName: UILabel!
    @IBOutlet weak var tableviewoperation: UITableView!
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.accountDetailProvider = AccountsDetailProvider(with: self, with: account )
    }
}

extension AccountDetailVC : AccountDetailView {
    func onOperationListUpdate() {
        self.tableviewoperation.reloadData()
    }
    
    func onAccountDetailUpdate(title: String?, amount: String?) {
        self.labelAmount.text = amount
        self.labelAccountName.text = title
    }
}
extension AccountDetailVC : UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
extension AccountDetailVC : UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let provider = accountDetailProvider else {
            return 0
        }
        return provider.tableviewData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewmodel = self.accountDetailProvider else{
            return UITableViewCell()
        }
        
        let data = viewmodel.tableviewData[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Operation", for: indexPath) as! OperationCell
        cell.label_title.text = data.operation_title
        cell.label_amount.text = data.operation_amount
        cell.label_date.text = data.operation_date
        return cell
    }
}
