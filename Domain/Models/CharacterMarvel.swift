//
//  CharacterMarvel.swift
//  Domain
//
//  Created by Patricia Zambrano on 8/04/21.
//

import Foundation

public struct CharacterMarvel {
    public let id: Int
    public let name: String
    public let description: String
    public let thumbnailURL: URL?
    
    public init(id: Int,
                name: String,
                description: String,
                thumbnailURL: URL?) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnailURL = thumbnailURL
    }
}
