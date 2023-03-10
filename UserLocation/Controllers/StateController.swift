import SwiftUI
import CoreLocation
import MapKit

@MainActor
class StateController: ObservableObject {
	
	@Published var randomUsers: [RandomUser] = []  //same as @Published var users = [User]()
	@Published var region = MKCoordinateRegion(
		center: CLLocationCoordinate2D(latitude: 56.334_900,
									   longitude: 10.009_020),
		latitudinalMeters: 250200,
		longitudinalMeters: 250200
	)
	
	init() {
		guard let randomUserUrl = URL(string: "https://randomuser.me/api/?nat=DK&results=5") else { return }
		fetchUsers(from: randomUserUrl)
	}

	func fetchUsers(from url: URL) {
		Task(priority: .medium) {
			guard let rawUserData = await NetworkService.getData(from: url) else { return }
			let decoder = JSONDecoder()
			
			do {
				let decodedRandomUserResult = try decoder.decode(RandomUserResult.self, from: rawUserData)
				randomUsers = decodedRandomUserResult.results
			} catch {
				fatalError("Error while converting rawUserData to RandomUserResult instance")
			}
			
		}
		
	}
	
}
