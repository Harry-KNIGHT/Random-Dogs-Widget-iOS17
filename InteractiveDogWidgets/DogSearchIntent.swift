//
//  DogSearchIntent.swift
//  InteractiveDogWidgetsExtension
//
//  Created by Elliot Knight on 01/10/2023.
//

import Foundation
import AppIntents

struct DogSearch: AppIntent {
	static var title: LocalizedStringResource = "Random Dog"
	static var description: IntentDescription = "Push button to look another dog"

	func perform() async throws -> some IntentResult {
		return .result()
	}
}
