//
//  VMAccountsDisplay.swift
//  Bank
//
//  Created by Olivier Adin on 11/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation
import UIKit


enum VMStatus{
    case loading
    case error
    case updated
}

protocol VMAccountsRenderer where Self : UIViewController{
    func onStatus(newstate : VMStatus, message : String?)
}


public struct UICellInfo{
    var idBank : String? = nil
    var idAccount : String? = nil
    var idOperation : String? = nil
    
    var title  : String
    var amount : String
    var isBankCell : Bool
}

public final class VMAccountsProvider{
    
    
    private weak var vc : VMAccountsRenderer?
    
    private var raw_accounts : [AccountList]?
    
    
    public var tableviewCAData    : [UICellInfo] = []
    public var tableviewOtherData : [UICellInfo] = []
    
    private var currentSelectedBank : String? = ""

    
    init(with viewcontroller : VMAccountsRenderer) {
        self.vc = viewcontroller
        self.doFetchAccounts()
    }
    public func doFetchAccounts(){
        
        self.vc?.onStatus(newstate: .loading, message: "Loading...")
        
        let url = Store.shared.State_Environnement.Get_AccountsURL()
        
        let session = URLSession.shared
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil , let data = data else {
                let string_error = error?.localizedDescription ?? "Error fetching accounts"
                self.vc?.onStatus(newstate: .error, message: string_error)
                return
            }
            
            do{
                let string = String.init(bytes: data, encoding: .utf8)!
                print(string)
                
                let decoder = JSONDecoder()
                self.raw_accounts = try decoder.decode([AccountList].self, from: data)
                self.loadDataForViewController()
            } catch  {
                let string_error = error.localizedDescription
                self.vc?.onStatus(newstate: .error, message: string_error)
            }
        })
        task.resume()
    }
    
    private func getCreditAgricoleAccounts()->([AccountList]){
        guard let raw_data = self.raw_accounts else{
            return []
        }
        let filtred_list = raw_data.filter { bank_info -> Bool in
            let isCA = bank_info.isCA.boolValue
            return isCA
        }
        return filtred_list.sorted(by: { (obj1, obj2) -> Bool in
            return obj1.title.lowercased() < obj2.title.lowercased()
        })
    }
    
    private func getOtherAccounts()->([AccountList]){
        guard let raw_data = self.raw_accounts else{
            return []
        }
        let filtred_list = raw_data.filter { bank_info -> Bool in
            let isCA = !bank_info.isCA.boolValue
            return isCA
        }
        return filtred_list.sorted(by: { (obj1, obj2) -> Bool in
            return obj1.title.lowercased() < obj2.title.lowercased()
        })
    }    
    
    public func loadDataForViewController(){
       //Credit agricole
        let creditARawData = self.getCreditAgricoleAccounts()
        self.tableviewCAData = self.extractData(from: creditARawData)
        //Other
        let otherBanksRawData = self.getOtherAccounts()
        self.tableviewOtherData = self.extractData(from: otherBanksRawData)
        
        self.vc?.onStatus(newstate: .updated, message: nil)

    }
    

    func extractData(from BanksRawData : [AccountList])->[UICellInfo]{
        var extractedData : [UICellInfo] = []
        for bankAccount in BanksRawData{
            if let bankAccountList = bankAccount.accounts {
                
                //check is the cell is expanded

                let isExpanded = self.currentSelectedBank == bankAccount.id
                
                extractedData.append(UICellInfo(idBank: bankAccount.id,
                                                idAccount: nil,
                                                idOperation: nil,
                                                title: bankAccount.title,
                                                amount: bankAccount.amount.addDefaultCurrency(),
                                                isBankCell: true))
                
                if isExpanded {
                    for account in bankAccountList{
                        extractedData.append(UICellInfo(idBank: bankAccount.id,
                                                        idAccount: account.id,
                                                        idOperation: nil,
                                                        title: account.title,
                                                        amount: account.amount.addDefaultCurrency(),
                                                        isBankCell: false))
                    }
                }
            }
        }
        return extractedData
    }
    
    
    func onTapOnBank(id : String?){
        //Select or Unselect the cell
        if (id == self.currentSelectedBank){
            self.currentSelectedBank = ""
        } else {
            self.currentSelectedBank = id
        }
        self.loadDataForViewController()
    }
    func onTapAccountDetail(id : String?){
        //Go to detail operation
       
        
    }
    
    
}
