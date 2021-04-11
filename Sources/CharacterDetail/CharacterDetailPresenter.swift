//
//  CharacterDetailPresenter.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 10/04/21.
//

import Domain
import Foundation

final class CharacterDetailPresenter {
    private weak var view: CharacterDetailContract.View?
    private let navigator: CharacterDetailContract.Navigator
    private let characterDetailUseCase: CharacterDetailUseCaseContract
    
    private var viewState: CharacterDetailViewState = .clear {
        didSet {
            view?.render(state: viewState)
        }
    }
    
    init(view: CharacterDetailContract.View?,
         navigator: CharacterDetailContract.Navigator,
         characterDetailUseCase: CharacterDetailUseCaseContract) {
        self.view = view
        self.navigator = navigator
        self.characterDetailUseCase = characterDetailUseCase
    }
}

extension CharacterDetailPresenter: CharacterDetailContract.Presenter {
    func getCharacter() {
        // todo
    }
    
    func goToPreviousView() {
        navigator.presentPreviousView()
    }
}
