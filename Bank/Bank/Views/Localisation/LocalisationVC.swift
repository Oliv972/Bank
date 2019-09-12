//
//  LocalisationVC.swift
//  Bank
//
//  Created by Olivier Adin on 12/09/2019.
//  Copyright © 2019 Olivier Adin. All rights reserved.
//

import Foundation
import UIKit
import MapKit


public class LocalisationVC : UIViewController{
    
    @IBOutlet weak var map: MKMapView!
    var locationManager  : CLLocationManager?

    
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager = CLLocationManager()
        locationManager?.delegate = self

        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            locationManager?.startUpdatingLocation()
            locationManager?.desiredAccuracy = kCLLocationAccuracyKilometer
        }else{
            locationManager?.requestWhenInUseAuthorization()
        }
        
        self.map.showsUserLocation = true;
        self.map.userTrackingMode = MKUserTrackingMode.followWithHeading;
    }
    
    
    override public func viewWillDisappear(_ animated: Bool) {
        locationManager?.stopUpdatingLocation()
        locationManager?.delegate = nil
        locationManager = nil

        super.viewWillDisappear(animated)

    }
    
  
}

extension LocalisationVC : MKMapViewDelegate{
    
}
extension LocalisationVC : CLLocationManagerDelegate {
    
}



