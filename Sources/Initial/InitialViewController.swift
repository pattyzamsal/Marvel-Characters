//
//  ViewController.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 8/04/21.
//

import UIKit

class InitialViewController: BaseViewController {

    @IBOutlet private weak var startButton: UIButton!
    
    private lazy var presenter: InitialContract.Presenter = {
        let navigator = InitialNavigator(viewController: self)
        return InitialPresenter(view: self,
                                navigator: navigator)
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = TextsConstants.initialTitle.rawValue
    }
    
    @IBAction func startButtonDidTap(_ sender: Any) {
        presenter.didTapOnStartButton()
    }
}

extension InitialViewController: InitialContract.View {
    func renderViewState(_ state: InitialViewState) {
        switch state {
        case .clear:
            break
        }
    }
}
