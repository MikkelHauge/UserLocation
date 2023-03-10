
import Foundation
import MapKit

/*
 den kan få gps lokationshalløj, hvis klassen (lokationcontroller) overholder delegates krav, som er at implementerer "CLLocationManagerDelegate"
 */
@MainActor
class LocationController: NSObject, ObservableObject {
	@Published var coordinateRegion = MKCoordinateRegion() // brugerens lokation
	
	private var locationManager: CLLocationManager?

	override init() {
		super.init()
		coordinateRegion.span = .init(latitudeDelta: 2.001, longitudeDelta: 2.001)
		locationManager = CLLocationManager()
		locationManager?.delegate = self // sæt kun delegate propertien på location manager, hvis den ikke er nil
		checkLocationAuthorization() // 👇
	}
	
	deinit { // når controlleren nedlægges, stopper gps chippen. denne burde ligge i den fil hvor gps'en bruges
		locationManager?.stopUpdatingLocation()
	}
	
	private func checkLocationAuthorization(){ // check auth status på gps
		guard let locationManager else { return } // laver lokalvariabel version, hvis den findes
		
		switch locationManager.authorizationStatus {
			// -> fix -> free cases
		case .notDetermined:
			locationManager.requestWhenInUseAuthorization()
		case .restricted: // bare denne ene gang
			print("Restricted access to location")
		case .denied: // ingen adgang
			print("Denied access to location")

		case .authorizedAlways, .authorizedWhenInUse: // altid & i brug
			locationManager.startUpdatingLocation()
			
		@unknown default:
			print("Error - lol")
		}
		
	}
	
}


//  skal være en delegate -> derfor NSObject (linje 5)
extension LocationController: CLLocationManagerDelegate {
	// kun CLLocationManagerDelegate funktioner
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		checkLocationAuthorization()
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		coordinateRegion.center = locations.first!.coordinate // udråbstegn: vi er sikre på der er en (locations er optional)
		
	}
}
