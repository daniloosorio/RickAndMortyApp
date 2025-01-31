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
        sut = DefaultCharacterRepository(apiService: CharacterListFakeApiServiceSuccess())
        sutFailure = DefaultCharacterRepository(apiService: CharacterListFakeApiServiceFailure())
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
            XCTAssertTrue(response?.results.first?.id == 21)
        }
        catch{
            XCTFail("Always receive a response an not trow an error")
        }
    }
    
    func testSuccessCase_SearchCharacter() async {
        do{
            let response = try await sut?.searchCharacter(by: "Rick",and: nil)
            XCTAssertTrue(response?.results.first?.id == 21)
        }catch{
            XCTFail("Always receive a response an not trow an error")
        }
    }
}

extension CharacterRepositoryTest {
    func testFailureCase_getCharacterList() async {
        do {
            let _ = try await sutFailure?.getCharacterList(pageNumber: nil)
            XCTFail("Should throw an error")
        }catch{
            //test passed
        }
        
    }
    
    func testFailureCase_getCharacterListParseError() async {
        let sut: CharacterRepository = DefaultCharacterRepository(apiService: CharacterListFakeApiServiceParseError())
        do {
            let _ = try await sut.getCharacterList(pageNumber: nil)
            XCTFail( "Should throw an error")
        }catch {
            if error is AppError {
                XCTAssertEqual(error.localizedDescription, AppError.parseError.localizedDescription)
            }else{
                XCTFail("This test should throw an parse error")
            }
        }
    }
    
    func testFailureCase_SearchCharacter() async {
        do {
            let _ = try await sutFailure?.searchCharacter(by : "Rick",and : nil)
            XCTFail("this test should throw an error" )
            
        } catch {
            // test passed
        }
    }
}
