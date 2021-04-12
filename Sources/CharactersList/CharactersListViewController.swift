//
//  CharactersListViewController.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 10/04/21.
//

import Injector
import UIKit

class CharactersListViewController: BaseViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var emptyView: UIView!
    
    private lazy var presenter: CharactersListContract.Presenter = {
        let navigator = CharactersListNavigator(viewController: self)
        let charactersUseCase = ChractersInjector.provideCharactersUseCase()
        return CharactersListPresenter(view: self,
                                       navigator: navigator,
                                       charactersUseCase: charactersUseCase)
    }()
    
    private var charactersList = [CharactersListViewModel]()

    private enum Constants {
        static let estimatedRowHeight: CGFloat = 80.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.getCharactersList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = TextsConstants.charactersList.rawValue
        setBackButton(title: "")
    }
}

private extension CharactersListViewController {
    func showEmptyView(isHidden: Bool) {
        tableView.isHidden = !isHidden
        emptyView.isHidden = isHidden
    }
    
    func setupView() {
        setActivityIndicator(activityIndicator)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = Constants.estimatedRowHeight
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        CharacterTableViewCell.registerCellForTable(tableView)
    }
}

extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        let character = charactersList[indexPath.row]
        cell.setup(name: character.name, photoURL: character.photoURL)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapOnCharacter(id: charactersList[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = charactersList.count - 1
        if indexPath.row == lastItem, !presenter.isLastPage() {
            presenter.getNextPage()
        }
    }
}

extension CharactersListViewController: CharactersListContract.View {
    func render(state: CharactersListViewState) {
        switch state {
        case .render(let characters):
            hideLoading()
            showEmptyView(isHidden: true)
            charactersList = characters
            tableView.reloadData()
        case .empty:
            hideLoading()
            showEmptyView(isHidden: false)
        case .error(let error):
            hideLoading()
            showAlertView(error: error) { (_) in
                self.presenter.goToPreviousView()
            }
        case .noMorePages:
            hideLoading()
            showAlertView(error: TextsConstants.noMoreCharacters.rawValue, didTapActionButton: nil)
        case .loading:
            showLoading()
        case .clear:
            break
        }
    }
}
