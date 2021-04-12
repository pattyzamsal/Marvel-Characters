//
//  CharacterTableViewCell.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 10/04/21.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    static let identifier = "CharacterTableViewCell"
    
    static func registerCellForTable(_ tableView: UITableView) {
        let nib = UINib(nibName: identifier,
                        bundle: Bundle(for: CharacterTableViewCell.self))
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .gray
    }
    
    func setup(name: String, photoURL: URL?) {
        nameLabel.text = name
        guard let url = photoURL else {
            return
        }
        photoImageView.af.setImage(withURL: url)
    }
}
