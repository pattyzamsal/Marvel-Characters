//
//  CharacterDetailNavigator.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 10/04/21.
//

import Foundation
import UIKit


final class CharacterDetailNavigator {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension CharacterDetailNavigator: CharacterDetailContract.Navigator {
    func presentPreviousView() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
