//
//  VMAccountDetailDisplay.swift
//  Bank
//
//  Created by Olivier Adin on 11/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation
import UIKit

public struct UIOperationCellInfo{
    var operation_title  : String
    var operation_amount : String
    var operation_date   : String
}

protocol VMAccountDetailsRenderer where Self : UIViewController{
    func onAccountDetailUpdate(title : String?, amount : String?)
    func onOperationListUpdate()
}


public final class VMAccountsDetailProvider{
    
    
    private weak var vc : VMAccountDetailsRenderer?
    private var account : Account?

    public var tableviewData    : [UIOperationCellInfo] = []
    
    init(with viewcontroller : VMAccountDetailsRenderer, with account : Account?) {
        self.vc = viewcontroller
        self.account = account
        self.vc?.onAccountDetailUpdate(title: account?.title.addDefaultCurrency(), amount: account?.amount.addDefaultCurrency())
        self.loadDataForViewController()
    }
    
    
    public func loadDataForViewController(){
        guard let rawOperationListData = self.account?.operations else { return }
        
        let sortedOperations = rawOperationListData.sorted { operation1, operation2 -> Bool in
            if self.isSameDate(dateString1: operation1.date, dateString2: operation2.date) {
                return operation1.title < operation2.title
            }else{
                return operation1.date < operation2.date
            }            
        }
    
        var result : [UIOperationCellInfo] = []
        for operation in sortedOperations {
            let title = operation.title
            let amount = operation.amount.addDefaultCurrency()
            let date = operation.date.convertTimeStampToDate()

            
            result.append(UIOperationCellInfo(operation_title: title, operation_amount: amount, operation_date: date))
        }
        
        tableviewData = result 
    }
    
    //Comparaison qui prend en compte seulement les dates, et non les heures
    private func isSameDate(dateString1 : String, dateString2 : String)->Bool{
        return dateString1.convertTimeStampToDate() == dateString2.convertTimeStampToDate()
    }
}
