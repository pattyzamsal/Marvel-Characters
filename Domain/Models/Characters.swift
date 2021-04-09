//
//  Characters.swift
//  Domain
//
//  Created by Patricia Zambrano on 8/04/21.
//

import Foundation

public struct Characters {
    public let data: DataCharacters
    
    public init(data: DataCharacters) {
        self.data = data
    }
}

public struct DataCharacters {
    public let offset: Int
    public let limit: Int
    public let total: Int
    public let results: [CharacterMarvel]
    
    public init(offset: Int,
                limit: Int,
                total: Int,
                results: [CharacterMarvel]) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.results = results
    }
}
