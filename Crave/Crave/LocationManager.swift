//
//  LocationManager.swift
//  Crave
//
//  Created by Robert Durst on 10/16/16.
//  Copyright © 2016 Crave. All rights reserved.
//
// Central class for referencing the location of the device/user.

import CoreLocation


class LocationManager: NSObject, CLLocationManagerDelegate{
    
    var locationManager = CLLocationManager()
    var bearing = 100.00
    
    override init(){
        
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func enableLocation(){
        
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse:
                break
			default:
				break
            }
        } else {
            print("Location services are not enabled")
        }
        
    }
    
    func getLocationLatitude()->CLLocationDegrees{
        return(locationManager.location!.coordinate.latitude)
    }
    
    func getLocationLongitude()->CLLocationDegrees{
        return(locationManager.location!.coordinate.longitude)
    }
    
    func getLocationCoordinate()->CLLocationCoordinate2D{
        return(locationManager.location!.coordinate)
    }
    
    func getLocationBearing()->Double{
        return bearing
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        bearing = (newHeading.magneticHeading)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // This should match your CLLocationManager()
        locationManager.stopUpdatingLocation()
        
    }
    
}
