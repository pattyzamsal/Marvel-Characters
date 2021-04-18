//
//  InitialPresenterTests.swift
//  MarvelCharactersTests
//
//  Created by Patricia Zambrano on 11/04/21.
//

@testable import MarvelCharactersSTGDebug
import XCTest

final class InitialPresenterTests: XCTestCase {
    var mockView: InitialViewMock!
    var navigator: InitialNavigatorMock!
    
    override func setUp() {
        super.setUp()
        mockView = InitialViewMock()
        navigator = InitialNavigatorMock()
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        navigator = nil
    }
    
    func testDidTapOnStartButton() {
        let presenter = InitialPresenter(view: mockView,
                                         navigator: navigator)
        presenter.didTapOnStartButton()
        XCTAssertEqual(navigator.destination, .listCharacters)
    }
}
