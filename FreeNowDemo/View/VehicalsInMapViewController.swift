//
//  VehicalsInMapViewController.swift
//  FreeNowDemo
//
//  Created by wfh on 07/11/20.
//

import Foundation
import UIKit
import MapKit

class VehicalsInMapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 100
    var locationManager: CLLocationManager!
    let newPin = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        locationManager = CLLocationManager()
        locationManager.delegate = self

        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let location = CLLocation(latitude:53.5511, longitude: 9.9937) // default pin at hambueg center location
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        
        mapView.setRegion(region, animated: true)
        newPin.coordinate = location.coordinate
        mapView.addAnnotation(newPin)
    
        let mRect: MKMapRect = self.mapView.visibleMapRect;
        let neMapPoint: MKMapPoint = MKMapPoint(x: mRect.maxX, y: mRect.maxY);
        let swMapPoint: MKMapPoint = MKMapPoint(x: mRect.origin.x, y: mRect.origin.y);
        
        let nwMapPoint: MKMapPoint = MKMapPoint(x: mRect.origin.x, y: mRect.maxY);
        let seMapPoint: MKMapPoint = MKMapPoint(x: mRect.maxX, y: mRect.origin.y);
        
        let neCoord = neMapPoint.coordinate;
        let swCoord = swMapPoint.coordinate;
        
        let nwCoord = nwMapPoint.coordinate;
        let seCoord = seMapPoint.coordinate;
        
        
        print("northWest: "+String(nwCoord.latitude)+" && "+String(nwCoord.longitude));
        print("southEast: "+String(seCoord.latitude)+" && "+String(seCoord.longitude));
        
        print("northEast: "+String(neCoord.latitude)+" && "+String(neCoord.longitude));
        print("southWest: "+String(swCoord.latitude)+" && "+String(swCoord.longitude));
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    deinit {
        print("deinit :VehicalsInMapViewController")
    }
}
