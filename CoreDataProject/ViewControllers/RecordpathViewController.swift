//
//  RecordpathViewController.swift
//  CoreDataProject
//
//  Created by Cykul Cykul on 13/01/19.
//  Copyright © 2019 MAC BOOK. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMaps

class RecordpathViewController: UIViewController {

   
   // Timer... declaration variables...
    
    var timer = Timer()
    var currentLoc  : CLLocation!
    var latitudeToServer : CLLocationDegrees!
    var longtitudeToServer : CLLocationDegrees!
    var seconds = 0
    var locations1 : [CLLocation]!
    var startTime,randomNumber,time,speed: String!
    var updatingLocation : Timer?
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var startbtn: UIButton!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var SpeedLabel: UILabel!
    @IBOutlet weak var AvgspeedLabel: UILabel!
    var userLocation1 = [String]()
    var latitudeArrRC = [Double]()
    var longitudeArrRC = [Double]()
    var altitudeArrRC = [Double]()
    var speedArrRC = [Double]()
    var startDate: Date!
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var travelTime,avarageSpeed,distance : Double!
    var traveledDistance: Double = 0
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentLocation()
    }
    
    func currentLocation()
    {
        self.mapView.isMyLocationEnabled = true
        self.mapView.settings.compassButton = true
        self.mapView.settings.myLocationButton = true
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        currentLoc = locationManager.location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        mapView.delegate = self
    }
    
    // function get timer string values...
    
    func getTodayString() -> String{
        
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        
        return today_string
        
    }
    
    @IBAction func timerbutton(_ sender: Any) {
        self.start()
    }
    
    @IBAction func pausebtn(_ sender: Any) {
        self.pause()
    }
    
    @IBAction func finishbtn(_ sender: Any) {
        self.resume()
    }
    
    func resume()
    {
        timer.invalidate()
        let alert = UIAlertController(title: "Map's", message:"your sucessfully complete your Activity", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: {(_ action: UIAlertAction) -> Void in
        }))
        self.present(alert, animated: true, completion: nil)
        print(self.TimerLabel.text!)
    }
    
    func start()
    {
        startTime = getTodayString()
        randomNumber = String(Int(arc4random()))
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RecordpathViewController.timerfunctionality), userInfo: nil, repeats: true)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitudeToServer, longitude: longtitudeToServer)
        marker.map = mapView
        self.currentLocation()
    }
    
    func pause()
    {
        timer.invalidate()
        updatingLocation?.invalidate()
        locationManager.stopUpdatingLocation()
    }
    
    @objc func timerfunctionality()
    {
        seconds += 1
        func timeString(time:TimeInterval) -> String {
            let hours = Int(time) / 3600
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        }
        TimerLabel.text = "\(timeString(time: TimeInterval(seconds)))"
        time = timeString(time: TimeInterval(seconds))
        getDistance()
    }
    
    // get distance
    func getDistance(){
        
        if startDate == nil {
            startDate = Date()
        } else {
            travelTime = Date().timeIntervalSince(self.startDate)
        }
        if startLocation == nil {
            startLocation = locations1!.first
        } else if let location = locations1.last {
            
            let x = lastLocation.speed*3.6
            var y = Double(round(100*x)/100)
            speed = "\(y)"
            if y == -3.6{
                y = 0
                SpeedLabel.text = "\(y) KMPH"
            }else{
                SpeedLabel.text = "\(y) KMPH"
            }
            let avgSpeed123 = (traveledDistance/travelTime)*3.6
            let avgSpeed = Double(round(100*avgSpeed123)/100)
            avarageSpeed = avgSpeed
            AvgspeedLabel.text = "\(avgSpeed) KMPH"
            traveledDistance += lastLocation.distance(from: location)
            let dist = traveledDistance/1000
            distance = Double(round(100*dist)/100)
            distanceLabel.text = "\(distance ?? 0.00) KM"
        }
        lastLocation = locations1.last
        
        
    }
}

extension RecordpathViewController:CLLocationManagerDelegate,GMSMapViewDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations1 = locations
    let location = locationManager.location?.coordinate
         cameraMoveToLocation(toLocation: location)
        guard let locationValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        latitudeToServer = locationValue.latitude
        longtitudeToServer = locationValue.longitude
        let altitude = locations.last?.altitude ?? 0.0
        altitudeArrRC.append(Double(round(10000*altitude)/10000))
        print(altitudeArrRC)
        print(locations.last?.speed ?? 0.0 * 3.6)
        let speed = locations.last?.speed ?? 0.0 * 3.6
        let speed1 = Double(round(100*speed)/100)
        if speed1 > 0{
        }else{
            speedArrRC.append(speed1)
        }
        latitudeArrRC.append(latitudeToServer)
        longitudeArrRC.append(longtitudeToServer)
        
        //***** Zoom UserLocation*****
        let vancouver = CLLocationCoordinate2D(latitude: latitudeToServer, longitude: longtitudeToServer)
        let vancouverCam = GMSCameraUpdate.setTarget(vancouver)
        mapView.animate(with: vancouverCam)
        mapView.animate(toBearing: 0)
        mapView.animate(toViewingAngle: 0)
        mapView.setMinZoom(10, maxZoom: 80)
        let pointString = "\(self.latitudeToServer!),\(self.longtitudeToServer!)"
        self.userLocation1.append(pointString)
        let path = GMSMutablePath()
        print(self.userLocation1)
        for i in 0..<self.userLocation1.count {
            let latlongArray = self.userLocation1[i].components(separatedBy: CharacterSet(charactersIn: ","))
            path.addLatitude(Double(latlongArray[0]) ?? 0.0, longitude: Double(latlongArray[1]) ?? 0.0)
        }
        DispatchQueue.main.async {
            if self.userLocation1.count > 1 {
                let polyline = GMSPolyline(path: path)
                polyline.strokeColor = UIColor.blue
                polyline.strokeWidth = 6.0
                polyline.map = self.mapView
            }
        }
    }
    
    func cameraMoveToLocation(toLocation: CLLocationCoordinate2D?) {
        if toLocation != nil {
            mapView.camera = GMSCameraPosition.camera(withTarget: toLocation!, zoom: 15)
        }
    }
}
