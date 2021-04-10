//
//  CharactersUseCaseTests.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 09/04/21.
//

@testable import Domain
import XCTest

final class CharactersUseCaseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetListCharactersUseCaseWithSuccess() {
        let expectation = XCTestExpectation(description: "Fetch list characters")
        let listCharacters = getListCharacters()
        let useCase = MockCharactersUseCase(dataCharacters: listCharacters)
        useCase.getListCharacters(page: 0) { (result) in
            switch result {
            case .success(let dataCharacters):
                XCTAssertEqual(dataCharacters.limit, listCharacters.limit)
                XCTAssertEqual(dataCharacters.offset, listCharacters.offset)
                XCTAssertEqual(dataCharacters.total, listCharacters.total)
                XCTAssertEqual(dataCharacters.results.count, listCharacters.results.count)
                expectation.fulfill()
            case .failure:
                XCTFail("Unexpected error")
            }
        }
    }
    
    func testGetListCharactersUseCaseWithError() {
        let expectation = XCTestExpectation(description: "Fetch list characters with error")
        let useCase = MockCharactersUseCase(dataCharacters: nil)
        useCase.getListCharacters(page: 0) { (result) in
            switch result {
            case .success:
                XCTFail("Unexpected error")
            case .failure(let error):
                if let error = error as? MockCharactersUseCaseError {
                    XCTAssertEqual(error, .generic)
                    expectation.fulfill()
                } else {
                    XCTFail("Unexpected error")
                }
            }
        }
    }
}

private extension CharactersUseCaseTests {
    func getListCharacters() -> DataCharacters {
        let characterMarvel1 = CharacterMarvel(id: 1011334,
                                               name: "3-D Man",
                                               description: "",
                                               thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"))
        let characterMarvel2 = CharacterMarvel(id: 1011334,
                                               name: "3-D Man",
                                               description: "",
                                               thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"))
        return DataCharacters(offset: 0,
                              limit: 2,
                              total: 2,
                              results: [characterMarvel1,characterMarvel2])
    }
}
