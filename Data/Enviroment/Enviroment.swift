//
//  Enviroment.swift
//  Data
//
//  Created by Patricia Zambrano on 8/04/21.
//

import Foundation

struct Environment {
    static let publicKey: String = Bundle.main.infoDictionary?["Public key"] as! String
    static let privateKey: String = Bundle.main.infoDictionary?["Private key"] as! String
    static let timestamp: String = String(Date().timeIntervalSince1970)
    static let baseURL: String = Bundle.main.infoDictionary?["Base url"] as! String
}
