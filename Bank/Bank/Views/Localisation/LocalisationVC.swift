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
    var colorsThemeProvider : ThemeProvider?
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.locationPresenter = VISAATMLocatorPresenter(view: self)
        self.colorsThemeProvider = ThemeColorVCProvider(vc: self)

    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.map.showAnnotations(self.map.annotations, animated: false)

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
extension LocalisationVC : MKMapViewDelegate{}
extension LocalisationVC : CLLocationManagerDelegate {}

extension LocalisationVC : UICollectionViewDelegate{
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.map.showAnnotations([self.map.annotations[indexPath.row]], animated: true)

    }
}

extension LocalisationVC : UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let list = locationPresenter?.raw_atm_data ?? []
        return list.count
    }
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCell.Identifier(), for: indexPath) as! LocationCell
       
        if let ano = locationPresenter?.raw_atm_data[indexPath.row].bank_name{
            cell.labelTitle.text = ano
        }
        if let ano = locationPresenter?.raw_atm_data[indexPath.row].address{
            cell.labelSubTitle.text = ano
        }
        if let ano = locationPresenter?.raw_atm_data[indexPath.row].type{
            
            
        }
        return cell
    }
}


extension LocalisationVC : LocationViewer {
    public func clearPoints() {
        self.map.removeAnnotations(self.map.annotations)
    }
    public func addBank(atLatitude: Double, longitude: Double, name: String?) {
        let annotation = MKPointAnnotation()
        annotation.title = name
        annotation.coordinate = CLLocationCoordinate2D(latitude: atLatitude, longitude: longitude)
        map.addAnnotation(annotation)
        self.collectionView.reloadData()
        self.map.showAnnotations(self.map.annotations, animated: true)

    }
}
extension LocalisationVC : ThemeColorChangeCapable {
    public func onThemeUpdate(theme: ThemeProtocol?) {
        self.view.backgroundColor = theme?.backgroundColor
        map.tintColor = theme?.title_Color
        self.labelTitle.textColor = theme?.title_Color
        self.labelTitle.addShadow()
    }
}



