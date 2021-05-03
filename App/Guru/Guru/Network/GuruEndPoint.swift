//
//  GuruEndPoint.swift
//  Guru
//
//  Created by Rafael Adolfo  on 01/05/21.
//

import Foundation

//MARK: API paths alias
enum GuruEndPoint {
    case fetchStories
}

//MARK: API endpoints paths
enum GuruServicePath {
    static let fetchStories = "stories"
}

extension GuruEndPoint: EndPointType {
    // MARK: - Endpoint setup
    var apiPort: String {
        return "443"
    }

    var apiDefaultPath: String {
        return "api"
    }

    var apiVersion: String? {
        return nil
    }

    var task: HTTPTask {
        switch self {
        case .fetchStories:
            return .requestParameters(bodyEncoding: .bodyEncoding, parameters: nil)
        }
    }

    var environmentUrl: String {
        return ApiConfiguration().getApiUrl(port: apiPort, defaultPath: apiDefaultPath, apiVersion: apiVersion, for: AppNetworkEnvironment)
    }

    var baseURL: URL {
        guard let url = URL(string: environmentUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var path: String {
        switch self {
        case .fetchStories:
            return GuruServicePath.fetchStories
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .fetchStories:
            return .get
        }
    }
}
