
import SwiftUI

@main
struct UserLocationApp: App {
	
	@StateObject var stateController = StateController()
	@StateObject var locationController = LocationController()

    var body: some Scene {
        WindowGroup {
			WelcomeView().environmentObject(stateController).environmentObject(locationController)
        }
    }
}
