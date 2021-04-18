//
//  InitialViewMock.swift
//  MarvelCharactersTests
//
//  Created by Patricia Zambrano on 18/04/21.
//

@testable import MarvelCharactersSTGDebug
import Foundation

final class InitialViewMock: InitialViewContract {
    var state: InitialViewState?
    
    func renderViewState(_ state: InitialViewState) {
        self.state = state
    }
}
