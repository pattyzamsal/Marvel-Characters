//
//  CharacterDetailPresenterTests.swift
//  MarvelCharactersTests
//
//  Created by Patricia Zambrano on 11/04/21.
//

@testable import MarvelCharactersSTGDebug
import Domain
import XCTest

final class CharacterDetailPresenterTests: XCTestCase {
    var mockView: CharacterDetailViewMock!
    var navigator: CharacterDetailNavigatorMock!
    
    override func setUp() {
        super.setUp()
        navigator = CharacterDetailNavigatorMock()
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        navigator = nil
    }
    
    func testFetchCharacterByIdSuccess() {
        let exp = expectation(description: "Fetch character success")
        let getCharacterDetailUseCase = MockCharacterDetailUseCase(character: getCharacter())
        mockView = CharacterDetailViewMock(onStateChange: { [weak self] in
            guard let character = self?.mockView.character else {
                return
            }
            XCTAssertNotNil(character)
            exp.fulfill()
        })
        let presenter = CharacterDetailPresenter(view: mockView,
                                                 navigator: navigator,
                                                 characterDetailUseCase: getCharacterDetailUseCase)
        presenter.getCharacter(id: "1009220")
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testFetchCharacterByIdWithError() {
        let exp = expectation(description: "Fetch character with error")
        let getCharacterDetailUseCase = MockCharacterDetailUseCase(character: nil)
        mockView = CharacterDetailViewMock(onStateChange: { [weak self] in
            guard let error = self?.mockView.error,
                  !error.isEmpty else {
                return
            }
            exp.fulfill()
        })
        let presenter = CharacterDetailPresenter(view: mockView,
                                                 navigator: navigator,
                                                 characterDetailUseCase: getCharacterDetailUseCase)
        presenter.getCharacter(id: "1009220")
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testGoToPreviousView() {
        let getCharacterUseCase = MockCharacterDetailUseCase(character: nil)
        mockView = CharacterDetailViewMock(onStateChange: {
            return
        })
        let presenter = CharacterDetailPresenter(view: mockView,
                                                 navigator: navigator,
                                                 characterDetailUseCase: getCharacterUseCase)
        presenter.goToPreviousView()
        XCTAssertEqual(navigator.destination, .back)
    }
    
    func testGetCharacterDetailViewModel() {
        let character = getCharacter()
        let characterViewModel = CharacterDetailViewModel(name: character.name,
                                                          description: character.description,
                                                          photoURL: character.thumbnailURL)
        XCTAssertEqual(character.name, characterViewModel.name)
        XCTAssertEqual(character.description, characterViewModel.description)
        XCTAssertEqual(character.thumbnailURL, characterViewModel.photoURL)
    }
}

private extension CharacterDetailPresenterTests {
    func getCharacter() -> CharacterMarvel {
        return CharacterMarvel(id: 1009220,
                               name: "Captain Marvel",
                               description: "Vowing to serve his country any way he could, young Steve Rogers took the super soldier serum to become America's one-man army. Fighting for the red, white and blue for over 60 years, Captain America is the living, breathing symbol of freedom and liberty.",
                               thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/3/50/537ba56d31087"))
    }
}
