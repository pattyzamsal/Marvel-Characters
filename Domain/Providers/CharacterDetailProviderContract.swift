//
//  CharacterDetailProviderContract.swift
//  Domain
//
//  Created by Patricia Zambrano on 8/04/21.
//

import Foundation

public enum CharacterDetailProviderContractError: Error {
    case generic
}

public protocol CharacterDetailProviderContract {
    func getCharacterDetailBy(id: String, completion: @escaping (Result<CharacterMarvel, Error>) -> Void)
}
