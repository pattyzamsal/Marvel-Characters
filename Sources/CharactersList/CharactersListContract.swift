//
//  CharactersListContract.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 10/04/21.
//

import Foundation

enum CharactersListContract {
    typealias Presenter = CharactersListPresenterContract
    typealias View = CharactersListViewContract
    typealias Navigator = CharactersListNavigatorContract
}

protocol CharactersListPresenterContract {
    func getCharactersList()
    func didTapOnCharacter(id: Int)
    func getNextPage()
    func isLastPage() -> Bool
    func goToPreviousView()
}

protocol CharactersListViewContract: AnyObject {
    func render(state: CharactersListViewState)
}

protocol CharactersListNavigatorContract {
    func presentCharacterDetail(id: String, name: String)
    func presentPreviousView()
}

enum CharactersListViewState {
    case clear
    case loading
    case empty
    case render(characters: [CharactersListViewModel])
    case noMorePages
    case error(error: String)
}
