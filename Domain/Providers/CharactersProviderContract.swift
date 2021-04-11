//
//  CharactersProviderContract.swift
//  Domain
//
//  Created by Patricia Zambrano on 8/04/21.
//

import Foundation

public enum CharactersProviderContractError: Error {
    case generic(error: String)
    
    public var errorDescription: String? {
        switch self {
        case .generic(let error):
            return error
        }
    }
}

public protocol CharactersProviderContract {
    func getListCharacters(page: Int, completion: @escaping (Result<DataCharacters, Error>) -> Void)
}
