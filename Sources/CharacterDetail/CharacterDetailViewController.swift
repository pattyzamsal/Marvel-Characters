//
//  CharacterDetailViewController.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 10/04/21.
//

import Injector
import UIKit

class CharacterDetailViewController: BaseViewController {
    
    var id: String = ""
    var name: String = ""
    
    private lazy var presenter: CharacterDetailContract.Presenter = {
        let navigator = CharacterDetailNavigator(viewController: self)
        let characterDetailUseCase = ChractersInjector.provideCharacterDetailUseCase()
        return CharacterDetailPresenter(view: self,
                                        navigator: navigator,
                                        characterDetailUseCase: characterDetailUseCase)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = name
        setBackButton(title: TextsConstants.backTitle.rawValue)
    }
}

extension CharacterDetailViewController: CharacterDetailContract.View {
    func render(state: CharacterDetailViewState) {
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
