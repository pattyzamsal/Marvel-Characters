//
//  CharactersProviderTests.swift
//  DataTests
//
//  Created by Patricia Zambrano on 9/04/21.
//

import XCTest
@testable import Data

final class CharactersProviderTests: XCTestCase {
    
    private var provider: MockCharactersProvider!
    private var data: Data!
    private var listCharactersEntity: CharactersEntity!
    private lazy var mockDataTests = DataTestsMock()
    
    override func setUp() {
        super.setUp()
        guard let url = mockDataTests.getLocalURLPathOfMockJSONBy(nameFile: "CharactersList"),
              let data = mockDataTests.convertURLToData(url: url),
              let list = try? JSONDecoder().decode(CharactersEntity.self, from: data) else {
            return
        }
        self.data = data
        self.listCharactersEntity = list
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testListCharactersParseSuccess() {
        guard let url = mockDataTests.getLocalURLPathOfMockJSONBy(nameFile: "CharactersList") else {
            XCTFail("Couldn't get json file")
            return
        }
        guard let data = mockDataTests.convertURLToData(url: url) else {
            XCTFail("Couldn't load data")
            return
        }
        do {
            let result = try JSONDecoder().decode(CharactersEntity.self, from: data)
            XCTAssertEqual(result.data.limit, 3)
           
        } catch {
            XCTFail("Couldn't get object from data")
        }
    }
    
    func testGetListCharactersWithSuccess() {
        let expectation = XCTestExpectation(description: "Fetch list characters")
        provider = MockCharactersProvider(result: .success(data))
        provider.getListCharacters(page: 0) { (result) in
            switch result {
            case .success(let dataCharacters):
                let dataListCharacters = try? self.listCharactersEntity.data.toDomain()
                XCTAssertEqual(dataCharacters.limit, dataListCharacters?.limit)
                XCTAssertEqual(dataCharacters.offset, dataListCharacters?.offset)
                XCTAssertEqual(dataCharacters.total, dataListCharacters?.total)
                XCTAssertEqual(dataCharacters.results.count, dataListCharacters?.results.count)
                expectation.fulfill()
            case .failure:
                XCTFail("Unexpected error")
            }
        }
        wait(for: [expectation], timeout: 3)
    }
    
    func testGetListCharactersWithError() {
        let expectation = XCTestExpectation(description: "Fetch list characters with error")
        let errorData = Data()
        provider = MockCharactersProvider(result: .success(errorData))
        provider.getListCharacters(page: 0) { (result) in
            switch result {
            case .success:
                XCTFail("Unexpected error")
            case .failure(let error):
                if let error = error as? MockCharactersProviderContractError {
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
