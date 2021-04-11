//
//  BaseViewController.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 10/04/21.
//

import Foundation

import  UIKit

typealias AlertAction = ((UIAlertAction) -> Void)?

class BaseViewController: UIViewController {
    
    func setBackButton(title: String) {
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.topItem?.title = title
    }

    func showAlertView(error: String, didTapActionButton: AlertAction) {
        let alert = UIAlertController(title: TextsConstants.occurAnError.rawValue,
                                      message: error,
                                      preferredStyle: .alert)
        let actionButton = UIAlertAction(title: TextsConstants.accept.rawValue,
                                         style: .default,
                                         handler: didTapActionButton)
        alert.addAction(actionButton)
        present(alert, animated: true, completion: nil)
    }
}
