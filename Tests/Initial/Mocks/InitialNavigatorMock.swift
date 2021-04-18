//
//  InitialNavigatorMock.swift
//  MarvelCharactersTests
//
//  Created by Patricia Zambrano on 18/04/21.
//

@testable import MarvelCharactersSTGDebug
import Foundation

enum InitialNavigatorDestination {
    case listCharacters
}

final class InitialNavigatorMock: InitialNavigatorContract {
    var destination: InitialNavigatorDestination?
    
    func presentListCharacters() {
        destination = .listCharacters
    }
}
