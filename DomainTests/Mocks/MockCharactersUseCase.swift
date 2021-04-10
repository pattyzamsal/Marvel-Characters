//
//  MockCharactersUseCase.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 09/04/21.
//

@testable import Domain
import XCTest

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
