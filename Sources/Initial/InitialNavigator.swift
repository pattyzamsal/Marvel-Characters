//
//  InitialNavigator.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 10/04/21.
//

import Foundation
import UIKit

final class InitialNavigator {
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension InitialNavigator: InitialContract.Navigator {
    func presentListCharacters() {
        let charactersListVC = CharactersListViewController()
        viewController?.navigationController?.pushViewController(charactersListVC, animated: true)
    }
}
