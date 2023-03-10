//
//  WhereAmIView.swift
//  UserLocation
//
//  Created by Mikkel Hauge on 10/03/2023.
//

import SwiftUI
import MapKit

struct WhereAmIView: View {
	@EnvironmentObject var locationController: LocationController

    var body: some View {
		VStack{
			Text("You are at:")
			Text("Latitude: \(Double(locationController.coordinateRegion.center.latitude))")
			Text("Longitude: \(Double(locationController.coordinateRegion.center.longitude))")
			
			Map(coordinateRegion: $locationController.coordinateRegion, showsUserLocation: true)
		}

			// .ignoresSafeArea() // fylder hele skærmen ud
	}
}

struct WhereAmIView_Previews: PreviewProvider {
    static var previews: some View {
        WhereAmIView().environmentObject(LocationController())
    }
}
