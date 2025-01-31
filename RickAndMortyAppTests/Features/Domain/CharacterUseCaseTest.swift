//
//  CharacterUseCaseTest.swift
//  RickAndMortyAppTests
//
//  Created by Danilo Osorio on 30/01/25.
//

import XCTest
@testable import RickAndMortyApp

final class CharacterUseCaseTest: XCTestCase {

    var sut: CharacterUseCase?
    var sutFailure: CharacterUseCase?
    
    override func setUp() {
        super.setUp()
        sut = DefaultCharacterUseCase(repository: DefaultCharacterRepository(apiService: CharacterListFakeApiServiceSuccess()))
        sutFailure = DefaultCharacterUseCase(repository: DefaultCharacterRepository(apiService: CharacterListFakeApiServiceFailure()))
    }
    
    override func tearDown() {
        sut = nil
        sutFailure = nil
        super.tearDown()
    }
}

// MARK: - Succes tests
extension CharacterUseCaseTest {
    func testSuccessCase_ResponseEntityIsNotNil() {
        
    }
}
// MARK: - Failure Tests
extension CharacterUseCaseTest {
    func testFailureCase_ResponseEntityIsNilAndReceiveError() {
        
    }
}
