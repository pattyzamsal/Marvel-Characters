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
    
    private weak var activityIndicator: UIActivityIndicatorView!
    
    func setBackButton(title: String) {
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.topItem?.title = title
    }
    
    func setActivityIndicator(_ activityIndicator: UIActivityIndicatorView!) {
        self.activityIndicator = activityIndicator
    }
    
    func showLoading() {
        view.isUserInteractionEnabled = false
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        view.isUserInteractionEnabled = true
        activityIndicator.alpha = 0
        activityIndicator.stopAnimating()
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
