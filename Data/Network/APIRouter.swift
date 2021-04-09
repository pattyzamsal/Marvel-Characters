//
//  APIRouter.swift
//  Data
//
//  Created by Patricia Zambrano on 8/04/21.
//

import Foundation
import Alamofire

private enum Paths: String {
    case listCharacters = "/characters"
    case detailCharacters = "/characters/@"
}

public enum APIRouter: URLRequestConvertible {
    case getListCharacters(page: Int)
    case getDetailCharacter(id: String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        return .get
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .getListCharacters:
            return Paths.listCharacters.rawValue
        case .getDetailCharacter(let id):
            return Paths.detailCharacters.rawValue.replacingOccurrences(of: "@", with: id)
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        var params = ["ts": Environment.timestamp,
                      "apikey": Environment.publicKey,
                      "hash": Encryption().generateStringMD5()]
        switch self {
        case .getListCharacters(let page):
            let limit = 100
            params["limit"] = "\(limit)"
            params["offset"] = "\(limit * page)"
            return params
        default:
            return params
        }
    }
    
    // MARK: - URLRequestConvertible
    public func asURLRequest() throws -> URLRequest {
        let url = try Environment.baseURL.asURL()
        var urlRequest: URLRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        if let parameters = parameters {
            return try URLEncoding.queryString.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
