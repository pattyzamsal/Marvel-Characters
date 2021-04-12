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
    
    private var id: String = ""
    
    init(view: CharacterDetailContract.View?,
         navigator: CharacterDetailContract.Navigator,
         characterDetailUseCase: CharacterDetailUseCaseContract) {
        self.view = view
        self.navigator = navigator
        self.characterDetailUseCase = characterDetailUseCase
    }
}

private extension CharacterDetailPresenter {
    func getCharacterDetailViewModel(character: CharacterMarvel) -> CharacterDetailViewModel {
        let description = character.description.isEmpty ? TextsConstants.basicDescription.rawValue : character.description
        return CharacterDetailViewModel(name: character.name,
                                        description: description,
                                        photoURL: character.thumbnailURL)
    }
}

extension CharacterDetailPresenter: CharacterDetailContract.Presenter {
    func getCharacter(id: String) {
        viewState = .loading
        self.id = id
        characterDetailUseCase.getCharacterDetailBy(id: id) { (response) in
            switch response {
            case .success(let character):
                let characterViewModel = self.getCharacterDetailViewModel(character: character)
                self.view?.render(state: .render(character: characterViewModel))
            case .failure(let error):
                var message = error.localizedDescription
                if let errorUseCase = error as? CharacterDetailUseCaseError,
                   let errorDescription = errorUseCase.errorDescription {
                    message = errorDescription
                }
                self.view?.render(state: .error(error: message))
            }
        }
    }
    
    func goToPreviousView() {
        navigator.presentPreviousView()
    }
}
