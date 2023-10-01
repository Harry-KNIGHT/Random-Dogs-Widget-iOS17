//
//  RandomDogView.swift
//  RandomDogs
//
//  Created by Elliot Knight on 30/09/2023.
//

import SwiftUI
import DogApi

struct RandomDogView: View {
	@StateObject private var dogViewModel = RandomDogViewModel(service: DogServiceDefault())
	
	var body: some View {
		VStack {
			Spacer()
			AsyncImage(url: URL(string: dogViewModel.dog?.imageUrl ?? "")) { image in
				image
					.resizable()
					.scaledToFit()
			} placeholder: {
				ProgressView()
					.font(.title2)
					.padding()
			}
			Spacer()
			Button(action: {
				dogViewModel.callDog()
			}, label: {
				Text("Fetch new image")
					.font(.title2)
			})
			.buttonStyle(.bordered)
			.buttonBorderShape(.roundedRectangle(radius: 10))
		}
	}
}

#Preview {
	RandomDogView()
}
