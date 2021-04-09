//
//  APIClient.swift
//  Data
//
//  Created by Patricia Zambrano on 8/04/21.
//

import Foundation
import Alamofire
import AlamofireImage

final class APIClient: WebServiceProtocol {
    func execute<Output>(endpoint: APIRouter, completion: @escaping WebServiceHandler<Output>) {
        if !validateConnectInternet() {
            completion(.failure(error: WebServiceProtocolError.noConnation))
            return
        }
        let request = endpoint as URLRequestConvertible
        AF.request(request)
            .logRequest()
            .validate { (_, httpResponse, data) -> DataRequest.ValidationResult in
                if self.isOccuringAnError(response: httpResponse) {
                    return .failure(self.getError(response: httpResponse, data: data))
                } else {
                    return .success(())
                }
            }
            .responseJSON{ response in
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        completion(.failure(error: WebServiceProtocolError.server))
                        return
                    }
                    do {
                        let result = try JSONDecoder().decode(Output.self, from: data)
                        completion(.success(modelData: result))
                    } catch {
                        completion(.failure(error: WebServiceProtocolError.serializationError))
                    }
                case .failure(let error):
                    completion(.failure(error: error))
                }
            }
    }
}

private extension APIClient {
    func validateConnectInternet() -> Bool {
        if let network = NetworkReachabilityManager() {
            return network.isReachable
        }
        return false
    }
    
    func isOccuringAnError(response: HTTPURLResponse) -> Bool {
        return  [401, 403, 405, 409].contains(response.statusCode) || (500..<600 ~= response.statusCode)
    }
    
    func getError(response: HTTPURLResponse, data: Data?) -> WebServiceProtocolError {
        if (500..<600 ~= response.statusCode) {
            return .server
        } else {
            return .parsingError(error: response.description)
        }
    }
}

private extension DataRequest {
    func logRequest() -> Self {
        responseData { response in
            print(response.debugDescription)
        }
        return self
    }
}
