import SwiftUI
import MapKit

struct MapView: View {
	@Environment(\.presentationMode) var presentationMode
	
	@EnvironmentObject var stateController: StateController
	
	
	
	var body: some View {
		Map(coordinateRegion: $stateController.region, annotationItems: stateController.randomUsers) { user in
			MapAnnotation(coordinate: user.coordinate) {
				ImageView(user: user, size: 25)
			}
		}
		.navigationTitle(Text("All Users"))
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItem(placement: .navigationBarLeading) {
				Button("Done") {
					presentationMode.wrappedValue.dismiss()
				}
			}
		}
	}
}
