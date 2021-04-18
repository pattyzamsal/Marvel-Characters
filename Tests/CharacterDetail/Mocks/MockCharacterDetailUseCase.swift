//
//  MockCharacterDetailUseCase.swift
//  MarvelCharactersTests
//
//  Created by Patricia Zambrano on 18/04/21.
//

@testable import MarvelCharactersSTGDebug
import Domain
import Foundation

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
