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
        viewState = .loading
        charactersUseCase.getListCharacters(page: page) { (response) in
            switch response {
            case .success(let dataCharacters):
                self.setValues(data: dataCharacters)
                if dataCharacters.results.isEmpty {
                    self.view?.render(state: .empty)
                } else {
                    self.view?.render(state: .render(characters: self.getCharactersListViewModel()))
                }
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
    
    func didTapOnCharacter(id: Int) {
        guard let character = getCharacterBy(id: id) else {
            return
        }
        navigator.presentCharacterDetail(id: "\(character.id)",
                                         name: character.name)
    }
    
    func getNextPage() {
        if page < totalPages {
            page += 1
            viewState = .loading
            charactersUseCase.getListCharacters(page: page) { (response) in
                switch response {
                case .success(let dataCharacters):
                    self.updateValues(data: dataCharacters)
                    self.view?.render(state: .render(characters: self.getCharactersListViewModel()))
                case .failure(let error):
                    var message = error.localizedDescription
                    if let errorUseCase = error as? CharactersUseCaseError,
                       let errorDescription = errorUseCase.errorDescription {
                        message = errorDescription
                    }
                    self.view?.render(state: .error(error: message))
                }
            }
        } else {
            self.view?.render(state: .noMorePages)
        }
    }
    
    func isLastPage() -> Bool {
        return page == totalPages
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
        totalPages = Int(floor(Double(total) / Double(limit)))
    }
    
    func updateValues(data: DataCharacters) {
        listCharacters += data.results
    }
    
    func getCharactersListViewModel() -> [CharactersListViewModel] {
        return listCharacters.map {
            CharactersListViewModel(id: $0.id,
                                    name: $0.name,
                                    photoURL: $0.thumbnailURL)
        }
    }
    
    func getCharacterBy(id: Int) -> CharacterMarvel? {
        return listCharacters.filter{ $0.id == id }.first
    }
}
