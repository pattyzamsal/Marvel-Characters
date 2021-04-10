//
//  CharacterDetailUseCaseTests.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 09/04/21.
//

@testable import Domain
import XCTest

final class CharacterDetailUseCaseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetCharacterUseCaseWithSuccess() {
        let expectation = XCTestExpectation(description: "Fetch specific character")
        let specificCharacter = getCharacter()
        let useCase = MockCharacterDetailUseCase(character: specificCharacter)
        useCase.getCharacterDetailBy(id: "1011334") { (result) in
            switch result {
            case .success(let character):
                XCTAssertEqual(character.id, specificCharacter.id)
                XCTAssertEqual(character.name, specificCharacter.name)
                XCTAssertEqual(character.description, specificCharacter.description)
                XCTAssertEqual(character.thumbnailURL, specificCharacter.thumbnailURL)
                expectation.fulfill()
            case .failure:
                XCTFail("Unexpected error")
            }
        }
    }
    
    func testGetCharacterUseCaseWithError() {
        let expectation = XCTestExpectation(description: "Fetch specific character with error")
        let useCase = MockCharacterDetailUseCase(character: nil)
        useCase.getCharacterDetailBy(id: "") { (result) in
            switch result {
            case .success:
                XCTFail("Unexpected error")
            case .failure(let error):
                if let error = error as? MockCharacterDetailUseCaseError {
                    XCTAssertEqual(error, .generic)
                    expectation.fulfill()
                } else {
                    XCTFail("Unexpected error")
                }
            }
        }
    }
}

private extension CharacterDetailUseCaseTests {
    func getCharacter() -> CharacterMarvel {
        return CharacterMarvel(id: 1011334,
                               name: "3-D Man",
                               description: "",
                               thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"))
    }
}
