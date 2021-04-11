//
//  CharactersListViewController.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 10/04/21.
//

import Injector
import UIKit

class CharactersListViewController: BaseViewController {
    
    private lazy var presenter: CharactersListContract.Presenter = {
        let navigator = CharactersListNavigator(viewController: self)
        let charactersUseCase = ChractersInjector.provideCharactersUseCase()
        return CharactersListPresenter(view: self,
                                       navigator: navigator,
                                       charactersUseCase: charactersUseCase)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getCharactersList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = TextsConstants.charactersList.rawValue
        setBackButton(title: "")
    }
}

extension CharactersListViewController: CharactersListContract.View {
    func render(state: CharactersListViewState) {
        switch state {
        case .render(let characters):
            // todo mostrar los personajes en el table view
        print("render")
        case .error(let error):
            showAlertView(error: error) { (_) in
                self.presenter.goToPreviousView()
            }
        case .clear:
            break
        }
    }
}
