//
//  NetworkProvider.swift
//  BookStore_MariaEugenia
//
//  Created by Maria Eugênia Pereira Teixeira on 02/11/20.
//

import Foundation
import PromiseKit


struct NetworkProvider {
    
    static let shared = NetworkProvider()
    
    func request<T>(_ endpoint: APIService) -> Promise<T> where T : Decodable {
        
        return Promise { resolver in
            do {
                let request = try self.buildRequest(from: endpoint)
                NetworkLogger.log(request: request)
                URLSession.shared.dataTask(with: request) { data, response, error in
                    NetworkLogger.log(response: response, data: data)
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                    
                    if statusCode == 200 {
                        do {
                            let obj = try JSONDataDecoder.decode(T.self, data: data)
                            return resolver.fulfill(obj)
                        } catch {
                            let err = error.localizedDescription
                            return resolver.reject(NetworkError.custom(err))
                        }
                    } else {
                        let err = self.networkResponseError(for: statusCode)
                        return resolver.reject(err)
                    }
                }.resume()
            } catch {
                let err = error.localizedDescription
                return resolver.reject(NetworkError.custom(err))
            }
        }
        
    }
    
    private func buildRequest(from endpoint: Endpoint) throws -> URLRequest {
        guard let url = endpoint.url else {
            throw NetworkError.badUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let params = endpoint.parameters else { return request }
        do {
            try URLParameterEncoder.encode(urlRequest: &request, with: params)
            return request
        } catch {
            throw error
        }
    }
    
    private func networkResponseError(for statusCode: Int) -> NetworkError {
        switch statusCode {
        case 500:
            return .serverError
        default:
            return .unknown
        }
    }
}
