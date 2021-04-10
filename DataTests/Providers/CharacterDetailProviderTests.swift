//
//  CharacterDetailProviderTests.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 09/04/21.
//

import XCTest
@testable import Data

final class CharacterDetailProviderTests: XCTestCase {
    
    private var provider: MockCharacterDetailProvider!
    private var data: Data!
    private var characterEntity: CharacterEntity!
    private lazy var mockDataTests = DataTestsMock()
    
    override func setUp() {
        super.setUp()
        guard let url = mockDataTests.getLocalURLPathOfMockJSONBy(nameFile: "CharacterDetail"),
              let data = mockDataTests.convertURLToData(url: url),
              let list = try? JSONDecoder().decode(CharactersEntity.self, from: data),
              let character = list.data.results.first else {
            return
        }
        self.data = data
        self.characterEntity = character
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testListCharactersParseSuccess() {
        guard let url = mockDataTests.getLocalURLPathOfMockJSONBy(nameFile: "CharacterDetail") else {
            XCTFail("Couldn't get json file")
            return
        }
        guard let data = mockDataTests.convertURLToData(url: url) else {
            XCTFail("Couldn't load data")
            return
        }
        do {
            let result = try JSONDecoder().decode(CharactersEntity.self, from: data)
            XCTAssertNotNil(result.data.results.first)
           
        } catch {
            XCTFail("Couldn't get object from data")
        }
    }
    
    func testGetCharacterWithSuccess() {
        let expectation = XCTestExpectation(description: "Fetch specific character")
        provider = MockCharacterDetailProvider(result: .success(data))
        provider.getCharacterDetailBy(id: "1017100") { (result) in
            switch result {
            case .success(let character):
                let specificCharacter = try? self.characterEntity.toDomain()
                XCTAssertEqual(character.id, specificCharacter?.id)
                XCTAssertEqual(character.name, specificCharacter?.name)
                XCTAssertEqual(character.description, specificCharacter?.description)
                XCTAssertEqual(character.thumbnailURL, specificCharacter?.thumbnailURL)
                expectation.fulfill()
            case .failure:
                XCTFail("Unexpected error")
            }
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func testGetListCharactersWithError() {
        let expectation = XCTestExpectation(description: "Fetch specific character with error")
        let errorData = Data()
        provider = MockCharacterDetailProvider(result: .success(errorData))
        provider.getCharacterDetailBy(id: "") { (result) in
            switch result {
            case .success:
                XCTFail("Unexpected error")
            case .failure(let error):
                if let error = error as? MockCharacterDetailProviderContractError {
                    XCTAssertEqual(error, .generic)
                    expectation.fulfill()
                } else {
                    XCTFail("Unexpected error")
                }
            }
        }
        wait(for: [expectation], timeout: 3)
    }
}
