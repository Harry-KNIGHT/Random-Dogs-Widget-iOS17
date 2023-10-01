//
//  DogServiceDefaultMock.swift
//
//
//  Created by Elliot Knight on 01/10/2023.
//

import Foundation
import DogApi

final class DogServiceDefaultMock: DogService {

	var mockChoosen: DataMock = .validFormat
	var serviceCalledCount = 0

	enum DataMock: String {
		case validFormat = "DogDataMock"
		case invalidFormat = "InvalidDogDataMock"
		case unexistingUrl
	}

	func fetchRandomDog() async throws -> DogData {
		guard let url = Bundle.module.url(forResource: mockChoosen.rawValue, withExtension: "json") else {
			throw ServiceError.incorrectUrl
		}

		let data = try Data(contentsOf: url)

		do {
			let dog = try JSONDecoder().decode(DogData.self, from: data)
			serviceCalledCount += 1
			return dog
		} catch {
			throw ServiceError.unknown
		}
	}

}
