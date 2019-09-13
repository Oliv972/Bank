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
    var locationPresenter : LocatorPresenter?
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.locationPresenter = VISAATMLocatorPresenter(view: self)
    }
    
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
extension LocalisationVC : CLLocationManagerDelegate {}


extension LocalisationVC : LocationViewer {
    public func clearPoints() {
        self.map.removeAnnotations(map.annotations)
    }
    
    public func addBank(atLatitude: Double, longitude: Double, name: String?) {
        let annotation = MKPointAnnotation()
        annotation.title = name
        annotation.subtitle = "One day I'll go here..."
        annotation.coordinate = CLLocationCoordinate2D(latitude: atLatitude, longitude: longitude)

        map.addAnnotation(annotation)
    }
    
    
}



