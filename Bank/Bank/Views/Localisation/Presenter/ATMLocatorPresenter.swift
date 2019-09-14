//
//  ATMLocatorPresenter.swift
//  Bank
//
//  Created by Olivier Adin on 13/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation



protocol LocatorPresenter {
    func doFetchATMLocations()
    var raw_atm_data : [ATM] { get }
}

public protocol LocationViewer : NSObjectProtocol{
    func clearPoints()
    func addBank(atLatitude : Double, longitude : Double, name : String?)
}

public class VISAATMLocatorPresenter : LocatorPresenter {
    
    private weak var renderer : LocationViewer?
    public var raw_atm_data : [ATM] = []
    
    public init(view : LocationViewer){
        self.renderer = view
        self.doFetchATMLocations()
    }
    
    func doFetchATMLocations() {
        let url = Store.shared.State_Environnement.url_visa_atm
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil , let data = data else {
                //let string_error = error?.localizedDescription ?? "Error fetching locations"
                //self.vc?.onStatus(newstate: .error, message: string_error)
                return
            }
            do{
                let decoder = JSONDecoder()
                self.raw_atm_data = try decoder.decode([ATM].self, from: data)
                self.doBuildInfosForUI()
            } catch  {
                //let string_error = error.localizedDescription
            }
        })
        task.resume()
    }
    
    
    func doBuildInfosForUI(){
        self.renderer?.clearPoints()

        for atm in self.raw_atm_data {
            OperationQueue.main.addOperation {
                self.renderer?.addBank(atLatitude: atm.latitude, longitude: atm.longitude, name: atm.bank_name)
            }
        }
    }
}
