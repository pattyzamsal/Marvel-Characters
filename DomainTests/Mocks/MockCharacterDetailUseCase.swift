//
//  MockCharacterDetailUseCase.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 09/04/21.
//

import Foundation

@testable import Domain
import XCTest

enum MockCharacterDetailUseCaseError: Error {
    case generic
}

final class MockCharacterDetailUseCase: CharacterDetailUseCaseContract {
    var character: CharacterMarvel?
    
    init(character: CharacterMarvel?) {
        self.character = character
    }
    
    func getCharacterDetailBy(id: String, completion: @escaping (Result<CharacterMarvel, Error>) -> Void) {
        if let character = character {
            completion(.success(character))
        } else {
            completion(.failure(MockCharacterDetailUseCaseError.generic))
        }
    }
}
