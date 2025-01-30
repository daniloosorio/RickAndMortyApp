//
//  CharacterRepositoryTest.swift
//  RickAndMortyAppTests
//
//  Created by Danilo Osorio on 29/01/25.
//

import XCTest
@testable import RickAndMortyApp

class CharacterRepositoryTest: XCTestCase {
    var sut: CharacterRepository?
    var sutFailure: CharacterRepository?
    
    override func setUp() {
        super.setUp()
        sut = DefaultCharacterRepository()
        sutFailure = DefaultCharacterRepository()
    }
    
    override func tearDown() {
        sut = nil
        sutFailure = nil
        super.tearDown()
    }
}

extension CharacterRepositoryTest {
    func testSuccesCase_getCharacterList() async {
        do {
            let response = try await sut?.getCharacterList(pageNumber:nil)
            XCTAssertTrue(response?.results.first?.id == 1)
        }
        catch{
            XCTFail("Always receive a response an not trow an error")
        }
    }
}
    
    extension CharacterRepositoryTest {
        func testFailureCase_ResponseEntityIsNilAndReceiveError() {
            
        }
}
