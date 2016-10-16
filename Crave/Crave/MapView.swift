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

class MapView: UIView {
    
    var viewMap = UIView()
    
    func create()->GMSMapView{
        
        //General Initializers
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height

        //Google Maps
        let camera = GMSCameraPosition.camera(withLatitude: ColbyLat,longitude: ColbyLon, zoom: 12)
        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 63, width: width, height: height*9/10-53), camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        viewMap.addSubview(mapView)
        
        
        let imageName = "ColbySeal"
        let image = UIImage(named: imageName)
        
        

        
        //Marker For Colby College
        let markerOrigin = GMSMarker()
        markerOrigin.position = CLLocationCoordinate2D(latitude: ColbyLat, longitude: ColbyLon)
        markerOrigin.icon = image
        markerOrigin.title = "Colby College"
        //markerOrigin.snippet = "Colby College"
        markerOrigin.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
        markerOrigin.userData = NSURL.init(fileURLWithPath: "https://www.colby.edu/")
        markerOrigin.map = mapView
        
        return mapView
    }
    
    
    func UpdateMap(restaurants: NearbyRestaurants, mapView: GMSMapView) {
        
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
    
    func getView() -> UIView{
        return viewMap
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
