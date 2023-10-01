//
//  DogServiceDefault.swift
//  
//
//  Created by Elliot Knight on 01/10/2023.
//

import Foundation

final public class DogServiceDefault: DogService {

	public init() {}

	public func fetchRandomDog() async throws -> DogData {
		guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else {
			throw ServiceError.incorrectUrl
		}

		let (data, response) = try await URLSession.shared.data(from: url)

		guard let response = response as? HTTPURLResponse else {
			throw ServiceError.notAnHttpResponse
		}

		do {
			switch response.statusCode {
			case 200...299:
				guard let decodedResponse = try? JSONDecoder().decode(DogData.self, from: data) else {
					throw ServiceError.cantDecodeData
				}
				return decodedResponse
			case 401:
				throw ServiceError.unautorized
			default:
				throw ServiceError.serverError(code: response.statusCode)
			}
		} catch {
			throw ServiceError.unknown
		}
	}
}

public enum ServiceError: Error, Equatable {
	case incorrectUrl
	case notAnHttpResponse
	case incorrectHttpResponse
	case cantDecodeData
	case unautorized
	case serverError(code: Int)
	case unknown
}
