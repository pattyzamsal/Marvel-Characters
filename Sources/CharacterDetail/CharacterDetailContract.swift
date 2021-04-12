//
//  CharacterDetailContract.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 10/04/21.
//

import Foundation

enum CharacterDetailContract {
    typealias Presenter = CharacterDetailPresenterContract
    typealias View = CharacterDetailViewContract
    typealias Navigator = CharacterDetailNavigatorContract
}

protocol CharacterDetailPresenterContract {
    func getCharacter(id: String)
    func goToPreviousView()
}

protocol CharacterDetailViewContract: AnyObject {
    func render(state: CharacterDetailViewState)
}

protocol CharacterDetailNavigatorContract {
    func presentPreviousView()
}

enum CharacterDetailViewState {
    case clear
    case loading
    case render(character: CharacterDetailViewModel)
    case error(error: String)
}
