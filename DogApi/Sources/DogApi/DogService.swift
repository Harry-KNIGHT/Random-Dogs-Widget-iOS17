//
//  DogService.swift
//
//
//  Created by Elliot Knight on 01/10/2023.
//

import Foundation

public protocol DogService {
	func fetchRandomDog() async throws -> DogData
}
