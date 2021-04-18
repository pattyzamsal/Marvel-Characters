//
//  CharactersListNavigatorMock.swift
//  MarvelCharactersTests
//
//  Created by Patricia Zambrano on 18/04/21.
//

@testable import MarvelCharactersSTGDebug
import Foundation

enum CharactersListNavigatorDestination {
    case characterDetail
    case back
}

final class CharactersListNavigatorMock: CharactersListNavigatorContract {
    var destination: CharactersListNavigatorDestination?
    
    func presentCharacterDetail(id: String, name: String) {
        destination = .characterDetail
    }
    
    func presentPreviousView() {
        destination = .back
    }
}
