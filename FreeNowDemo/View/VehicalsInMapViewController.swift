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
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let location = CLLocation(latitude:53.5511, longitude: 9.9937) // default pin at hambueg center location
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005))
        
        mapView.setRegion(region, animated: true)
        newPin.coordinate = location.coordinate
        mapView.addAnnotation(newPin)
        
        
        
//        let halfLatDelta = region.span.latitudeDelta / 2
//        let halfLngDelta = region.span.longitudeDelta / 2
//
//        let nePoint:CGPoint = CGPointMake(self.mapView.bounds.origin.x + mapView.bounds.size.width, mapView.bounds.origin.y)
//        let swPoint:CGPoint = CGPointMake((self.mapView.bounds.origin.x), (mapView.bounds.origin.y + mapView.bounds.size.height))
//
//        //Then transform those point into lat,lng values
//
//
//        let topLeftCoord = CLLocationCoordinate2D(
//            latitude: center.latitude + halfLatDelta,
//            longitude: center.longitude - halfLngDelta
//        )
//        let bottomRightCoord = CLLocationCoordinate2D(
//            latitude: center.latitude - halfLatDelta,
//            longitude: center.longitude + halfLngDelta
//        )
//
//
//        let NECoordinate = CLLocationCoordinate2D(latitude: topLeftCoord.latitude, longitude: topLeftCoord.longitude)
//        let SWCoordinate = CLLocationCoordinate2D(latitude: bottomRightCoord.latitude, longitude: bottomRightCoord.longitude)

        let mRect: MKMapRect = self.mapView.visibleMapRect;
        let neMapPoint: MKMapPoint = MKMapPoint(x: mRect.maxX, y: mRect.origin.y);
        let swMapPoint: MKMapPoint = MKMapPoint(x: mRect.origin.x, y: mRect.maxY);
//        let olaMapPoint: MKMapPoint = MKMapPoint(x: mRect.maxX, y: mRect.maxY);
        let neCoord = neMapPoint.coordinate;
        let swCoord = swMapPoint.coordinate;
//        let olaCoord = olaMapPoint.coordinate
        print(neCoord.latitude)
        print(neCoord.longitude)
        
        print(swCoord.latitude)
        print(swCoord.longitude)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    deinit {
        print("deinit :VehicalsInMapViewController")
    }
}
