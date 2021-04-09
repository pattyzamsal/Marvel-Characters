//
//  CharacterEntity.swift
//  Data
//
//  Created by Patricia Zambrano on 8/04/21.
//

import Domain
import Foundation

struct CharacterEntity: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: ThumbnailEntity
    
    func toDomain() throws -> CharacterMarvel {
        return CharacterMarvel(id: id,
                               name: name,
                               description: description,
                               thumbnailURL: URL(string: thumbnail.imageURLString))
    }
}
