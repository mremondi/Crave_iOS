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
    
    
    func UpdateMap(restaurants: NearbyRestaurants) {
        NotificationCenter.default.removeObserver(self)

        for thing in restaurants.getNearbyRestaurants(){
            
            let markerOrigin = GMSMarker()
            markerOrigin.position = CLLocationCoordinate2D(latitude: thing.getLat(), longitude: thing.getLon())
            //markerOrigin.icon = UIImage(named: "ColbySeal")
            markerOrigin.userData = thing.getId()
            markerOrigin.title = thing.getName()
            //markerOrigin.snippet = "Colby College"
           
            //markerOrigin.userData = NSURL.init(fileURLWithPath: "https://www.colby.edu/")
            markerOrigin.map = mapView
           
        }
    }
    
    func mapView(_ mapView: GMSMapView!, didTap marker: GMSMarker!) -> Bool {
        return false
    }
    
    func mapView(_ mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) -> Bool {
        delegate?.InfoWindowClicked(id: marker.userData as! String)
        return false
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
