
import MapKit
import UIKit
import CoreLocation

//test

class MAP2: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    //@IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager:CLLocationManager!
    var region:CLRegion!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //位置情報を取得する為の設定
        self.locationManager=CLLocationManager()
        self.locationManager.requestAlwaysAuthorization() //認証用。ios8以上だと必須
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation //測定の制度を設定
        self.locationManager.pausesLocationUpdatesAutomatically=false //位置情報が自動的にOFFにならない様に設定
        self.locationManager.distanceFilter=100.0// 100m以上移動した場合に位置情報を取得
        self.locationManager.delegate=self
        
        //地図を表示する為の設定
        self.mapView.delegate=self
        self.mapView.showsUserLocation=true //地図上に現在地を表示
        
        //現在地の取得を開始
        self.locationManager.startUpdatingLocation()
    }
    
    //現在地の情報を取得(startUpdatingLocationを呼ぶと自動的に呼ばれる)
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        print("test1")
        //現在地を基準に地図を表示
        /*
         let centerCoordinate : CLLocationCoordinate2D = CLLocationCoordinate2DMake(manager.location!.coordinate.latitude,manager.location!.coordinate.longitude)
         let span = MKCoordinateSpanMake(0.003, 0.003)
         var centerPosition = MKCoordinateRegionMake(centerCoordinate, span)
         mapView.setRegion(centerPosition, animated: true)
         
         mapView.userTrackingMode = MKUserTrackingMode.FollowWithHeading//方向も表示？
         */
        let TDUcoordinate : CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.985898, 139.373045)
        let span = MKCoordinateSpanMake(0.003, 0.003)
        let region = MKCoordinateRegionMake(TDUcoordinate, span)
        mapView.setRegion(region, animated:false)
        //mapView.userTrackingMode = MKUserTrackingMode.FollowWithHeading//方向も表示？
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
