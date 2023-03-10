

import Foundation
import CoreLocation

struct RandomUser: Codable, Identifiable{
	let id = UUID().uuidString
	let name: Name
	let picture: PictureUrl
	let location: Location
	
	
	var fullName: String {
		"\(name.first) \(name.last)"
	}
	struct Location: Codable {
		let city: String
		let state: String
		let country: String
		let postcode: Int
		let coordinates: Coordinates
		
		struct Coordinates: Codable {
			let latitude: String
			let longitude: String
		}
	}
	
	struct PictureUrl: Codable {
		let large, thumbnail: String
	}
	
	struct Name: Codable {
		let title, first, last: String
	}
}


// coordinate converting: Ccordinates -> Coordinate
extension RandomUser {
	var coordinate: CLLocationCoordinate2D {
		if let latitude = Double(location.coordinates.latitude),
			let longitude = Double(location.coordinates.longitude) {
			return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
		} else {
			return CLLocationCoordinate2D()
		}
	}
}
