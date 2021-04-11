//
//  CharactersListPresenter.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 10/04/21.
//

import Domain
import Foundation

final class CharactersListPresenter {
    private weak var view: CharactersListContract.View?
    private let navigator: CharactersListContract.Navigator
    private let charactersUseCase: CharactersUseCaseContract
    
    private var viewState: CharactersListViewState = .clear {
        didSet {
            view?.render(state: viewState)
        }
    }
    
    private var page: Int = 0
    private var totalPages: Int = 0
    private var limit: Int = 0
    private var total: Int = 0
    private var listCharacters: [CharacterMarvel] = []
    
    init(view: CharactersListContract.View?,
         navigator: CharactersListContract.Navigator,
         charactersUseCase: CharactersUseCaseContract) {
        self.view = view
        self.navigator = navigator
        self.charactersUseCase = charactersUseCase
    }
}

extension CharactersListPresenter: CharactersListContract.Presenter {
    func getCharactersList() {
        charactersUseCase.getListCharacters(page: page) { (response) in
            switch response {
            case .success(let dataCharacters):
                self.setValues(data: dataCharacters)
                // todo falta crear el view model para enviarlo al viewcontroller
            case .failure(let error):
                var message = error.localizedDescription
                if let errorUseCase = error as? CharactersUseCaseError,
                   let errorDescription = errorUseCase.errorDescription {
                    message = errorDescription
                }
                self.view?.render(state: .error(error: message))
            }
        }
    }
    
    func didTapOnCharacter() {
        // todo
        navigator.presentCharacterDetail(id: "",
                                         name: "")
    }
    
    func getNextPage() {
        // todo cargar mas paginas
    }
    
    func goToPreviousView() {
        navigator.presentPreviousView()
    }
}

private extension CharactersListPresenter {
    func setValues(data: DataCharacters) {
        limit = data.limit
        total = data.total
        listCharacters = data.results
        setTotalOfPages()
    }
    
    func setTotalOfPages() {
        totalPages = Int(ceil(Double(total) / Double(limit)))
    }
}
