//
//  NetworkService.swift
//  Guru
//
//  Created by Rafael Adolfo  on 01/05/21.
//

import Foundation

typealias NetworkServiceCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> ()
typealias ClosureType<T> = (_ result: T) -> ()
typealias Failure = ((_ error: String) -> ())

protocol NetworkRoutable {
    associatedtype EndPoint: EndPointType
    func request(_ target: EndPoint, completion: @escaping NetworkServiceCompletion)
    func cancel()
}

final class NetworkService<EndPoint: EndPointType>: NetworkRoutable {
    // MARK: - Properties
    private var task: URLSessionTask?

    // MARK: - Public methods
    func request(_ target: EndPoint, completion: @escaping NetworkServiceCompletion) {
        let session = URLSession.shared
        session.configuration.waitsForConnectivity = true
        
        do {
            let request = try self.buildRequest(from: target)
            print("Request URL: \(request.url?.absoluteString ?? "")")
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        }catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }

    func cancel() {
        self.task?.cancel()
    }

    // MARK: - Private methods
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> RequestResult<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }

    fileprivate func buildRequest(from target: EndPoint) throws -> URLRequest {

        var request = URLRequest(url: target.baseURL.appendingPathComponent(target.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 20.0)

        request.httpMethod = target.httpMethod.rawValue

        do {
            switch target.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            case .requestParameters(let bodyEncoding, let parameters):

            // MARK: - Guru: I'm not using authentication for this challenge
//                if let user = UserDefaults.standard.getUserData(){
//                    request.setValue("Bearer " + user.token, forHTTPHeaderField: "Authorization")
//                }

                try self.configureParameters(bodyEncoding: bodyEncoding, parameters: parameters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }

    fileprivate func configureParameters(bodyEncoding: ParameterEncoding,
                                         parameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    parameters: parameters)
        } catch {
            throw error
        }
    }
}

extension NetworkService {
    func request<T: Decodable>(_ target: EndPoint,
                               model: T.Type,
                               path: String? = nil,
                               completion: @escaping ClosureType<T>,
                               failure: @escaping Failure){

        return request(target, completion: { data,response,error in
            DispatchQueue.main.async {
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            failure(NetworkResponse.noData.rawValue)
                            return
                        }
                        do {
                           let apiResponse = try JSONDecoder().decode(model.self, from: responseData)
                           completion(apiResponse)
                        } catch {
                            failure(NetworkResponse.unableToDecode.rawValue)
                        }
                    case .failure(let networkFailureError):
                        failure(networkFailureError)
                    }
                } else {
                    failure(NetworkResponse.noData.rawValue)
                }
            }
        })
    }
}
