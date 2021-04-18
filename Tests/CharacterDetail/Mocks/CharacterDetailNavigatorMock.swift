//
//  CharacterDetailNavigatorMock.swift
//  MarvelCharactersTests
//
//  Created by Patricia Zambrano on 18/04/21.
//

@testable import MarvelCharactersSTGDebug
import Foundation

enum CharacterDetailNavigatorDestination {
    case back
}

final class CharacterDetailNavigatorMock: CharacterDetailNavigatorContract {
    var destination: CharacterDetailNavigatorDestination?
    
    func presentPreviousView() {
        destination = .back
    }
}
