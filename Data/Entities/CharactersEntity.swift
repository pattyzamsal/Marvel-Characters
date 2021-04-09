//
//  CharactersEntity.swift
//  Data
//
//  Created by Patricia Zambrano on 8/04/21.
//

import Domain
import Foundation

struct CharactersEntity: Codable {
    let data: DataCharactersEntity
    
    func toDomain() throws -> Characters {
        return Characters(data: try data.toDomain())
    }
}

struct DataCharactersEntity: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let results: [CharacterEntity]
    
    func toDomain() throws -> DataCharacters {
        return DataCharacters(offset: offset,
                              limit: limit,
                              total: total,
                              results: try results.map{ try $0.toDomain() })
    }
}
