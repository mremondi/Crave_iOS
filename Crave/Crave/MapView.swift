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

public class MapView: UIView, GMSMapViewDelegate{
    
    //Initializers for the element fields of the mapView class
    var viewMap = UIView()
    var mapView = GMSMapView()
    weak var delegate: MapTransitionDelegate?

    
    func create()->UIView{
        
        //General Initializers
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height

        //Google Maps
        let camera = GMSCameraPosition.camera(withLatitude: locationManagerClass.getLocationLatitude(),longitude: locationManagerClass.getLocationLongitude(), zoom: 12)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 63, width: width, height: height*9/10-45), camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.delegate = self
        viewMap.addSubview(mapView)

        
        return viewMap
    }
    
    //Function that updates the mao
    func UpdateMap(restaurants: NearbyRestaurants) {
        NotificationCenter.default.removeObserver(self)

        //For each restaurant in the neabry restaurant object, it places a marker at the restaurant's location
        for thing in restaurants.getNearbyRestaurants(){
            
            let markerOrigin = GMSMarker()
            markerOrigin.position = CLLocationCoordinate2D(latitude: thing.getLat(), longitude: thing.getLon())
            markerOrigin.userData = thing.getId()
            markerOrigin.title = thing.getName()
            markerOrigin.map = mapView
           
        }
    }
    
    func mapView(_ mapView: GMSMapView!, didTap marker: GMSMarker!) -> Bool {
        return false
    }
    
    //Shows the clickable label when a location marker is tapped and when this clickable label is tapped, the transition to restaurant (or here called InfoWindowClicked) function is called
    func mapView(_ mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) -> Bool {
        delegate?.InfoWindowClicked(id: marker.userData as! String)
        return false
    }

}
