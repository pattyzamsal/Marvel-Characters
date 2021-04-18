//
//  CharactersListPresenterTests.swift
//  MarvelCharactersTests
//
//  Created by Patricia Zambrano on 11/04/21.
//

@testable import MarvelCharactersSTGDebug
import Domain
import XCTest

final class CharactersListPresenterTests: XCTestCase {
    var mockView: CharactersListViewMock!
    var navigator: CharactersListNavigatorMock!
    var page: Int = 0
    var totalPages: Int = 0
    var limit: Int = 0
    var total: Int = 0
    var listCharacters: [CharacterMarvel] = []
    
    override func setUp() {
        super.setUp()
        navigator = CharactersListNavigatorMock()
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        navigator = nil
    }
    
    func testFetchCharactersListWithSuccess() {
        let exp = expectation(description: "Fetch characters list success")
        let getListCharactersUseCase = MockCharactersUseCase(dataCharacters: getListCharacters())
        mockView = CharactersListViewMock(onStateChange: { [weak self] in
            guard let characters = self?.mockView.characters, !characters.isEmpty else {
                return
            }
            exp.fulfill()
        })
        let presenter = CharactersListPresenter(view: mockView,
                                                navigator: navigator,
                                                charactersUseCase: getListCharactersUseCase)
        presenter.getCharactersList()
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testFetchCharactersListWithError() {
        let exp = expectation(description: "Fetch characters list with error")
        let getListCharactersUseCase = MockCharactersUseCase(dataCharacters: nil)
        mockView = CharactersListViewMock(onStateChange: { [weak self] in
            guard let error = self?.mockView.error,
                  !error.isEmpty else {
                return
            }
            exp.fulfill()
        })
        let presenter = CharactersListPresenter(view: mockView,
                                                navigator: navigator,
                                                charactersUseCase: getListCharactersUseCase)
        presenter.getCharactersList()
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testDidTapOnCharacter() {
        let getListCharactersUseCase = MockCharactersUseCase(dataCharacters: getListCharacters())
        mockView = CharactersListViewMock(onStateChange: {
            return
        })
        let presenter = CharactersListPresenter(view: mockView,
                                                navigator: navigator,
                                                charactersUseCase: getListCharactersUseCase)
        presenter.getCharactersList()
        presenter.didTapOnCharacter(id: 1011334)
        XCTAssertEqual(navigator.destination, .characterDetail)
    }
    
    func testGetNextPageSuccess() {
        page = 1
        totalPages = 2
        let exp = expectation(description: "Fetch next page of characters list success")
        mockView = CharactersListViewMock(onStateChange: {
            return
        })
        self.getNexPage(dataCharacters: getListCharacters()) { (result) in
            switch result {
            case .success(let characters):
                XCTAssertNotNil(characters)
                exp.fulfill()
            case .failure:
                XCTFail("Unexpected error")
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testGetNextPageWithError() {
        page = 1
        totalPages = 2
        let exp = expectation(description: "Fetch next page of characters list with error")
        mockView = CharactersListViewMock(onStateChange: {
            return
        })
        self.getNexPage(dataCharacters: nil) { (result) in
            switch result {
            case .success:
                XCTFail("Unexpected error")
            case .failure(let error):
                XCTAssertNotNil(error)
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testIsLastPageWithSuccess() {
        page = 2
        totalPages = 2
        let isLastPage = self.isLastPage()
        XCTAssertEqual(page, totalPages)
        XCTAssertEqual(isLastPage, true)
    }
    
    func testIsLastPageWithError() {
        page = 1
        totalPages = 2
        let isLastPage = self.isLastPage()
        XCTAssertNotEqual(page, totalPages)
        XCTAssertEqual(isLastPage, false)
    }
    
    func testGoToPreviousView() {
        let getListCharactersUseCase = MockCharactersUseCase(dataCharacters: nil)
        mockView = CharactersListViewMock(onStateChange: {
            return
        })
        let presenter = CharactersListPresenter(view: mockView,
                                                navigator: navigator,
                                                charactersUseCase: getListCharactersUseCase)
        presenter.goToPreviousView()
        XCTAssertEqual(navigator.destination, .back)
    }
    
    func testSetValues() {
        let dataCharacters = getListCharacters()
        limit = dataCharacters.limit
        total = dataCharacters.total
        listCharacters = dataCharacters.results
        XCTAssertEqual(limit, dataCharacters.limit)
        XCTAssertEqual(total, dataCharacters.total)
        XCTAssertEqual(listCharacters, dataCharacters.results)
    }
    
    func testSetTotalOfPages() {
        let dataCharacters = getListCharacters()
        limit = dataCharacters.limit
        total = dataCharacters.total
        let totalPages = Int(floor(Double(total) / Double(limit)))
        XCTAssertEqual(totalPages, Int(floor(Double(total) / Double(limit))))
    }
    
    func testUpdateValues() {
        let dataCharacters = getListCharacters()
        var listCharacters = dataCharacters.results
        let newCharacter = CharacterMarvel(id: 1011336,
                                           name: "Iron Man",
                                           description: "There aren't any registered information",
                                           thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"))
        listCharacters += [newCharacter, newCharacter]
        XCTAssertEqual(listCharacters.count, dataCharacters.results.count + 2)
    }
    
    func testGetCharactersListViewModel() {
        let dataCharacters = getListCharacters()
        let charactersListViewModel = dataCharacters.results.map {
            CharactersListViewModel(id: $0.id,
                                    name: $0.name,
                                    photoURL: $0.thumbnailURL)
        }
        XCTAssertEqual(dataCharacters.results.count, charactersListViewModel.count)
    }
    
    func testGetCharacterById() {
        let dataCharacters = getListCharacters()
        let character = dataCharacters.results.filter{ $0.id == 1011334 }.first
        XCTAssertNotNil(character)
    }
}

private extension CharactersListPresenterTests {
    func getNexPage(dataCharacters: DataCharacters?, completion: @escaping (Result<DataCharacters, Error>) -> Void) {
        if page < totalPages {
            page += 1
            mockView.render(state: .loading)
            if let dataCharacters = dataCharacters {
                completion(.success(dataCharacters))
            } else {
                completion(.failure(MockCharactersUseCaseError.generic))
            }
        } else {
            mockView.render(state: .noMorePages)
        }
    }
    
    func isLastPage() -> Bool {
        return page == totalPages
    }
    
    func getListCharacters() -> DataCharacters {
        let characterMarvel1 = CharacterMarvel(id: 1011334,
                                               name: "3-D Man",
                                               description: "There aren't any registered information",
                                               thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg"))
        let characterMarvel2 = CharacterMarvel(id: 1009220,
                                               name: "Captain Marvel",
                                               description: "Vowing to serve his country any way he could, young Steve Rogers took the super soldier serum to become America's one-man army. Fighting for the red, white and blue for over 60 years, Captain America is the living, breathing symbol of freedom and liberty.",
                                               thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/3/50/537ba56d31087"))
        return DataCharacters(offset: 0,
                              limit: 2,
                              total: 2,
                              results: [characterMarvel1,characterMarvel2])
    }
}
