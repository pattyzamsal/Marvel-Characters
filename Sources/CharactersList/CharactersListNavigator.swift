//
//  CharactersListNavigator.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 10/04/21.
//

import Foundation
import UIKit

final class CharactersListNavigator {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension CharactersListNavigator: CharactersListContract.Navigator {
    func presentCharacterDetail(id: String, name: String) {
        let characterDetailVC = CharacterDetailViewController()
        characterDetailVC.id = id
        characterDetailVC.name = name
        viewController?.navigationController?.pushViewController(characterDetailVC, animated: true)
    }
    
    func presentPreviousView() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
