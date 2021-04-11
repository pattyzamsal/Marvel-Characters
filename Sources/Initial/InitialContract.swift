//
//  InitialContract.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 10/04/21.
//

import Foundation

enum InitialContract {
    typealias Presenter = InitialPresenterContract
    typealias View = InitialViewContract
    typealias Navigator = InitialNavigatorContract
}

protocol InitialPresenterContract {
    func didTapOnStartButton()
}

protocol InitialViewContract: AnyObject {
    func renderViewState(_ state: InitialViewState)
}

protocol InitialNavigatorContract {
    func presentListCharacters()
}

enum InitialViewState {
    case clear
}
