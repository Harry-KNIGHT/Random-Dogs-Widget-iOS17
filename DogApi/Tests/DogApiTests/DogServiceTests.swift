//
//  File.swift
//  
//
//  Created by Elliot Knight on 01/10/2023.
//

import XCTest
@testable import DogApi

final class DogServiceTests: XCTestCase {

	var service: DogServiceDefaultMock!

	override func setUpWithError() throws {
		service = DogServiceDefaultMock()
	}

	override func tearDownWithError() throws {
		service = nil
	}

	func test_fetchOneRandomDog() async {
		do {
			// GIVEN
			service.mockChoosen = .validFormat

			// WHEN
			let dog = try await service.fetchRandomDog()

			// THEN

			XCTAssertEqual(dog.imageUrl, "https://randomdogimage.wwdc")
			XCTAssertEqual(service.serviceCalledCount, 1)
		} catch {
			XCTFail("This test would not fail")
		}
	}

	func test_given_invalidDataMock_when_fetchData_then_throwsError() async {
		// GIVEN
		service.mockChoosen = .invalidFormat

		do {
			// WHEN
			let _ = try await service.fetchRandomDog()
			XCTFail("This would catch")
		} catch {
			// THEN
			XCTAssertEqual(error as? ServiceError, .unknown)
			XCTAssertEqual(service.serviceCalledCount, 0)

		}
	}

	func test_given_unexistingdUrl_then_throwsError() async {
		// GIVEN
		service.mockChoosen = .unexistingUrl

		do {
			// WHEN
			let _ = try await service.fetchRandomDog()
			XCTFail("This would catch")
		} catch {
			// THEN
			XCTAssertEqual(error as? ServiceError, .incorrectUrl)
			XCTAssertEqual(service.serviceCalledCount, 0)
		}
	}
}
