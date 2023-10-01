//
//  RandomDogViewModel.swift
//  RandomDogs
//
//  Created by Elliot Knight on 30/09/2023.
//

import Foundation
import DogApi

final class RandomDogViewModel: ObservableObject {

	@Published var dog: DogData?

	private let service: DogService

	init(service: DogService) {
		self.service = service

		callDog()
	}
	
	// MARK: Public methods

	public func callDog() {
		Task {
			await getDog()
		}
	}

	// MARK: Private methods
	
	@MainActor
	private func getDog() async {
		do {
			dog = try await service.fetchRandomDog()
		} catch {
			dog = nil
		}
	}
}
