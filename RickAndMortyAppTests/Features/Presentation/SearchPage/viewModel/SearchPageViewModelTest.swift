//
//  SearchPageViewModelTest.swift
//  RickAndMortyAppTests
//
//  Created by Danilo Osorio on 10/02/25.
//

import XCTest
@testable import RickAndMortyApp

//MARK: - Test
class SearchPageViewModelTest: XCTestCase {
    
    //GIVEN
    private var sut: SearchPageViewModel?
    private var sutFailure : SearchPageViewModel?
    
    override func setUp() {
        super.setUp()
        sut = SearchPageViewModel(useCase: DefaultCharacterUseCase(repository: DefaultCharacterRepository(apiService: CharacterListFakeApiServiceSuccess())))
        sutFailure = SearchPageViewModel(useCase: DefaultCharacterUseCase(repository: DefaultCharacterRepository(apiService: CharacterListFakeApiServiceFailure())))
    }
    
    override func tearDown() {
        sut = nil
        sutFailure = nil
        super.tearDown()
    }
}

//MARK: - Success Test
extension SearchPageViewModelTest {
    func testSuccessCaseSearchCharacter() async {
        //WHEN use sut here
        await sut?.searchCharacter(by: "Rick", isFirstLoad: true)
        //THEN make assert here
        XCTAssert(sut?.characterList.first?.id == 21)
    }
    
    func testSuccessCaseSearchCharacterEmptyName() async {
        //WHEN use sut here
        await sut?.searchCharacter(by: "", isFirstLoad: true)
        //THEN make assert here
        XCTAssert(sut?.characterList.isEmpty ?? false)
    }
}

//MARK: - Failure Test
extension SearchPageViewModelTest {
    func testFailureCaseSearchCharacter() async {
        //GIVEN
        guard let sutFailure = sutFailure else { return }
        
        //WHEN use sutFailure here
        await sutFailure.searchCharacter(by: "Rick",isFirstLoad: true)
        //THEN make assert here
        XCTAssert(sutFailure.characterList.isEmpty)
        
    }
}

//MARK: - Instructions
// replace Test -> name of File test.swift
// sut: subjet under test
// replace ->  UseCase with Class examople viewModel
// replace -> replace default with class to test and inject  mocks if is necesary
