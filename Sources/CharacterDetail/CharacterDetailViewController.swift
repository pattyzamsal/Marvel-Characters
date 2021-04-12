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
    
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private lazy var presenter: CharacterDetailContract.Presenter = {
        let navigator = CharacterDetailNavigator(viewController: self)
        let characterDetailUseCase = ChractersInjector.provideCharacterDetailUseCase()
        return CharacterDetailPresenter(view: self,
                                        navigator: navigator,
                                        characterDetailUseCase: characterDetailUseCase)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.getCharacter(id: id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = name
        setBackButton(title: TextsConstants.backTitle.rawValue)
    }
}

private extension CharacterDetailViewController {    
    func setupView() {
        setActivityIndicator(activityIndicator)
    }
    
    func updateView(character: CharacterDetailViewModel) {
        nameLabel.text = character.name
        descriptionLabel.text = character.description
        guard let url = character.photoURL else {
            return
        }
        photoImageView.af.setImage(withURL: url)
    }
}

extension CharacterDetailViewController: CharacterDetailContract.View {
    func render(state: CharacterDetailViewState) {
        switch state {
        case .render(let character):
            hideLoading()
            updateView(character: character)
        case .error(let error):
            hideLoading()
            showAlertView(error: error) { (_) in
                self.presenter.goToPreviousView()
            }
        case .loading:
            showLoading()
        case .clear:
            break
        }
    }
}
