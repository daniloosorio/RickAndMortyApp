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
    func testSuccessCase_getCharacterList() async{
        do {
            let response = try await sut?.getCharactersList(pageNumber: nil)
            XCTAssert(response?.results.first?.id == 21)
            
        }catch {
            XCTFail("Always receive a response and not throw an error")
        }
    }
    
    func testSuccesCase_SearchCharacter() async{
        do {
            let response = try await sut?.searchCharacter(by: "Rick", and: nil)
            XCTAssert(response?.results.first?.id == 21)
        }
            catch {
            XCTFail("Always receive a response and not throw an error")
        }
    }
}
// MARK: - Failure Tests
extension CharacterUseCaseTest {
 
    func testFailureCase_getCharacterList() async{
        do{
            let _ = try await sutFailure?.getCharactersList(pageNumber: nil)
            XCTFail("Should throw an error")
        }catch{
            //passed
        }
    }
    
    func testFailureCase_SearchCharacter() async{
        do{
            let _ = try await sutFailure?.searchCharacter(by: "Rick", and: nil)
            XCTFail("Should throw an error")
        }catch{
            //passed 
        }
    }
}
