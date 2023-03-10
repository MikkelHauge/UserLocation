//
//  UserImageView.swift
//  UserLocation
//
//  Created by Mikkel Hauge on 10/03/2023.
//

import Foundation
import SwiftUI

struct ImageView: View {
	@EnvironmentObject var stateController: StateController

	let user: RandomUser
	let size: CGFloat
	
	var body: some View {
		let url = URL(string: user.picture.large)!
		AsyncImage(url: url) { image in
			image
				.resizable()
				.frame(width: size, height: size)
				.clipShape(Circle())
				
		} placeholder: {
			LoadingView()
		}
	}
}


struct LoadingView: View {
	var body: some View {
		HStack{
			Label("Loading", systemImage: "clock")
				.foregroundColor(.white)
		}
		.frame(maxWidth: .infinity, maxHeight: 100)
		.background(.teal)
		.clipShape(RoundedRectangle(cornerRadius: 10))
		.padding()
	}
}

