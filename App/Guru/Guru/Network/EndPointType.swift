//
//  EndPointType.swift
//  Guru
//
//  Created by Rafael Adolfo  on 01/05/21.
//

import Foundation

protocol EndPointType {
    var apiPort: String { get }
    var apiDefaultPath: String { get }
    var apiVersion: String? { get }
    var environmentUrl: String { get }
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
}
