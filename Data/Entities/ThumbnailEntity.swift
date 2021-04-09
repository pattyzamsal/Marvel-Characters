//
//  ThumbnailEntity.swift
//  Data
//
//  Created by Patricia Zambrano on 8/04/21.
//

import Foundation

struct ThumbnailEntity: Codable {
    let path: String
    let ext: String
    
    var imageURLString: String {
        return "\(path).\(ext)"
    }
    
    private enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
