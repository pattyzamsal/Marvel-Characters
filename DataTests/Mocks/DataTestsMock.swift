//
//  DataTestsMock.swift
//  DataTests
//
//  Created by Patricia Zambrano on 9/04/21.
//

import Foundation

class DataTestsMock {
    func getLocalURLPathOfMockJSONBy(nameFile: String) -> URL? {
        let bundle = Bundle(for: type(of: self))
        return bundle.url(forResource: nameFile, withExtension: "json")
    }
    
    func convertURLToData(url: URL) -> Data? {
        return try? Data(contentsOf: url)
    }
}
