//
//  SearchPageViewModelTest.swift
//  RickAndMortyAppTests
//
//  Created by Danilo Osorio on 10/02/25.
//

import XCTest
@testable import //here target

//MARK: - Test
class Test: XCTestCase {
    
    //GIVEN
    private var sut: UseCase?
    private var sutFailure : UseCase?
    
    override func setUp() {
        super.setUp()
        sut = Default(repository: RepositorySuccesMok())
        sutFailure = Default(repository: RepositoryFailureMok())
    }
    
    override func tearDown() {
        sut = nil
        sutFailure = nil
        super.tearDown()
    }
}

//MARK: - Success Test
extension Test {
    func testSuccess() {
        //WHEN use sut here
        
        //THEN make assert here
    }
}

//MARK: - Failure Test
extension Test {
    func testFailure() {
        //GIVEN
        guard let sutFailure = sutFailure else { return }
        
        //WHEN use sutFailure here
        
        //THEN make assert here
        
    }
}

//MARK: - Instructions
// replace Test -> name of File test.swift
// sut: subjet under test
// replace ->  UseCase with Class examople viewModel
// replace -> replace default with class to test and inject  mocks if is necesary
