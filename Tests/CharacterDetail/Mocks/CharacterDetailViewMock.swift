//
//  CharacterDetailViewMock.swift
//  MarvelCharactersTests
//
//  Created by Patricia Zambrano on 18/04/21.
//

@testable import MarvelCharactersSTGDebug
import Foundation

final class CharacterDetailViewMock: CharacterDetailViewContract {
    var onStateChange: (() -> Void)?
    var character: CharacterDetailViewModel?
    var error: String = ""
    
    init(onStateChange: @escaping (() -> Void)) {
        self.onStateChange = onStateChange
    }
    
    func render(state: CharacterDetailViewState) {
        switch state {
        case .render(let character):
            self.character = character
        case .error(let error):
            self.error = error
        default:
            break
        }
        onStateChange?()
    }
}
