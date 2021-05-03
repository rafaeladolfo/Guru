//
//  ApiConfiguration.swift
//  Guru
//
//  Created by Rafael Adolfo  on 01/05/21.
//

import Foundation

var AppNetworkEnvironment : NetworkEnvironment = .production

final class ApiConfiguration {
    // MARK: - Properties
    var productionUrl: String = ""
    var testUrl: String = ""
    var developmentUrl: String = ""

    init() {
        setApiNetwork()
    }

    // MARK: - Private methods
    private func setApiNetwork() {
        productionUrl = "https://4guruapi.azurewebsites.net:"
        testUrl = "https://4guruapi.azurewebsites.net:"
        developmentUrl = "https://4guruapi.azurewebsites.net:"
    }

    // MARK: - Public methods
    func getApiUrl(port: String, defaultPath: String, apiVersion: String?, for networkEnvironment: NetworkEnvironment) -> String {
        let version = apiVersion != nil ? apiVersion! + "/" : ""
        var api = ""

        switch networkEnvironment {
        case .production:
            api = productionUrl
        case .test:
            api = testUrl
        case .development:
            api = developmentUrl
        }

        return api + port + "/" + defaultPath + "/" +  version
    }
}
