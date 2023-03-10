//
//  ContentView.swift
//  UserLocation
//
//  Created by Mikkel Hauge on 10/03/2023.
//

import SwiftUI
import _MapKit_SwiftUI

struct WelcomeView: View {
	@EnvironmentObject var stateController: StateController
	@EnvironmentObject var locationController: LocationController
	
	@State private var usersOnMap = false //.sheet med users (vises ikke pr. default)
	// @Binding var region: MKCoordinateRegion
	
	var lastNameSortedUsersers: [RandomUser] {
		stateController.randomUsers.sorted {
			$0.name.last < $1.name.last
		}
	}
	
	var body: some View {
		NavigationView {
			TabView {
				RandomUserView()
					.tabItem {
						Image(systemName: "person.fill.questionmark")
						Text("Random Users")
					}
				WhereAmIView()
					.tabItem {
						Image(systemName: "map.fill")
						Text("Where Am I?")
					}
				}
			}
		}
		
		
	}
	
	
	
	struct WelcomeView_Previews: PreviewProvider {
		static var previews: some View {
			WelcomeView()
		}
	}

