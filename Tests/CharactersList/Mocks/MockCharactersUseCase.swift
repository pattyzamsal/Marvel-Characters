//
//  MockCharactersUseCase.swift
//  MarvelCharactersTests
//
//  Created by Patricia Zambrano on 18/04/21.
//

@testable import MarvelCharactersSTGDebug
import Domain
import Foundation

enum MockCharactersUseCaseError: Error {
    case generic
}

final class MockCharactersUseCase: CharactersUseCaseContract {
    var dataCharacters: DataCharacters?
    
    init(dataCharacters: DataCharacters?) {
        self.dataCharacters = dataCharacters
    }
    
    func getListCharacters(page: Int, completion: @escaping (Result<DataCharacters, Error>) -> Void) {
        if let dataCharacters = dataCharacters {
            completion(.success(dataCharacters))
        } else {
            completion(.failure(MockCharactersUseCaseError.generic))
        }
    }
}
