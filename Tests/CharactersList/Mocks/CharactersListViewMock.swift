//
//  CharactersListViewMock.swift
//  MarvelCharactersTests
//
//  Created by Patricia Zambrano on 18/04/21.
//

@testable import MarvelCharactersSTGDebug
import Foundation

final class CharactersListViewMock: CharactersListViewContract {
    var onStateChange: (() -> Void)?
    var characters: [CharactersListViewModel] = []
    var error: String = ""
    
    init(onStateChange: @escaping (() -> Void)) {
        self.onStateChange = onStateChange
    }
    
    func render(state: CharactersListViewState) {
        switch state {
        case .render(let characters):
            self.characters = characters
        case .error(let error):
            self.error = error
        default:
            break
        }
        onStateChange?()
    }
}
