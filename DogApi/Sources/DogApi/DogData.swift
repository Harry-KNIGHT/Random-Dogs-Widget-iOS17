//
//  File.swift
//  
//
//  Created by Elliot Knight on 01/10/2023.
//

import Foundation

public struct DogData: Decodable {
	public let imageUrl: String

	public init(imageUrl: String) {
		self.imageUrl = imageUrl
	}

	public enum CodingKeys: String, CodingKey {
		case imageUrl = "message"
	}
}
