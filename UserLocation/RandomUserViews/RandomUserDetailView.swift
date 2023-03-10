//
//  RandomUserDetailView.swift
//  UserLocation
//
//  Created by Mikkel Hauge on 10/03/2023.
//

import SwiftUI
import _MapKit_SwiftUI

struct RandomUserDetailView: View {
	@EnvironmentObject var stateController: StateController

	
	let user: RandomUser
	
    var body: some View {
		ScrollView{
			VStack{
				ImageView(user: user, size: 250)
				
				Text("\(user.fullName)")
					.font(.title)

				HStack{
					Spacer()
					
					Map(coordinateRegion: .constant(MKCoordinateRegion(center: user.coordinate, span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50))), annotationItems: [user]) { user in
						MapMarker(coordinate: user.coordinate)
					}
					.padding()
					.frame(width: 350, height: 400)
					.cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
					
					Spacer()
				}
			}
			
			VStack(alignment: .leading){
				Text("\(user.fullName)")
					.font(.title2)

				Text("\(user.location.city)")
				Text("\(user.location.state)")
				Text("\(user.location.country)")

				Text(verbatim: "\(user.location.postcode)")
				Text("")
				Text("Currently at: ")
				Text("Latitude: \(Double(user.coordinate.latitude))")
				Text("Longitude: \(Double(user.coordinate.longitude))")
			}



		}

    }
}
