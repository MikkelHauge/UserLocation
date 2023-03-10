//
//  RandomUserView.swift
//  UserLocation
//
//  Created by Mikkel Hauge on 10/03/2023.
//

import SwiftUI
import _MapKit_SwiftUI

struct RandomUserView: View {
	@EnvironmentObject var stateController: StateController
	@State private var usersOnMap = false //.sheet med users (vises ikke pr. default)
	// @Binding var region: MKCoordinateRegion
	
	var lastNameSortedUsersers: [RandomUser] {
		stateController.randomUsers.sorted {
			$0.name.last < $1.name.last
		}
	}
	
    var body: some View {
		NavigationView{
			List(lastNameSortedUsersers) { user in
				NavigationLink(
					destination: RandomUserDetailView(user: user).environmentObject(stateController)
				) {
					HStack{
						Map(coordinateRegion: .constant(MKCoordinateRegion(center: user.coordinate, span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50))), annotationItems: [user]) { user in
							MapMarker(coordinate: user.coordinate, tint: Color.orange)
						}
						.padding()
						.frame(width: 130, height: 100)
						.cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)

						Text("\(user.name.first) \(user.name.last)")
					}
				}
			} .navigationTitle("Random Users")
			.toolbar{
				ToolbarItem(placement: .navigationBarTrailing){
					Button(action: {
						usersOnMap = true
					}) {
						Image(systemName: "map")
					}
				}
			}
			.sheet(isPresented: $usersOnMap){
				VStack{
					MapView()
					Button(action: {
						usersOnMap = false
					}) {
						Image(systemName: "arrowshape.turn.up.backward.fill")
					}
				}
			}
		}
	}
    }


struct RandomUserView_Previews: PreviewProvider {
    static var previews: some View {
        RandomUserView()
    }
}
