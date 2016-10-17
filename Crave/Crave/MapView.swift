//
//  MapView.swift
//  Crave
//
//  Created by Robert Durst on 10/15/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreData

public class MapView{
    
    var viewMap = UIView()
    var mapView = GMSMapView()
    
    func create()->UIView{
        
        //General Initializers
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height

        //Google Maps
        let camera = GMSCameraPosition.camera(withLatitude: locationManagerClass.getLocationLatitude(),longitude: locationManagerClass.getLocationLongitude(), zoom: 12)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 63, width: width, height: height*9/10-45), camera: camera)
        //mapView.isMyLocationEnabled = true
        //mapView.settings.myLocationButton = true
        //mapView.settings.compassButton = true
        viewMap.addSubview(mapView)
        
        
        let imageName = "ColbySeal"
        let image = UIImage(named: imageName)
        
        //Marker For Current Location
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: locationManagerClass.getLocationLatitude(), longitude: locationManagerClass.getLocationLongitude())
        marker.title = "Current Location"
        marker.icon = GMSMarker.markerImage(with: UIColor.black)
        marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
        marker.map = mapView

        
        //Marker For Colby College
        let markerOrigin = GMSMarker()
        markerOrigin.position = CLLocationCoordinate2D(latitude: ColbyLat, longitude: ColbyLon)
        markerOrigin.icon = image
        markerOrigin.title = "Colby College"
        //markerOrigin.snippet = "Colby College"
        markerOrigin.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
        markerOrigin.userData = NSURL.init(fileURLWithPath: "https://www.colby.edu/")
        markerOrigin.map = mapView
        
        
        return viewMap
    }
    
    
    func UpdateMap(restaurants: NearbyRestaurants) {
        NotificationCenter.default.removeObserver(self)

        for thing in restaurants.getNearbyRestaurants(){
            
            let markerOrigin = GMSMarker()
            markerOrigin.position = CLLocationCoordinate2D(latitude: thing.getLat(), longitude: thing.getLon())
            //markerOrigin.icon = UIImage(named: "ColbySeal")
            markerOrigin.title = thing.getName()
            //markerOrigin.snippet = "Colby College"
            markerOrigin.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
            //markerOrigin.userData = NSURL.init(fileURLWithPath: "https://www.colby.edu/")
            markerOrigin.map = mapView
           
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
