//
//  NetworkManager.swift
//  Guru
//
//  Created by Rafael Adolfo  on 30/04/21.
//

import Foundation

class NetworkManager {
    // MARK: - Singleton
    static let shared = NetworkManager()

    // MARK: - Network service providers
    let guruProvider = NetworkService<GuruEndPoint>()

    // MARK: - Public methods
    func fetchStories(completion: @escaping ClosureType<GuruStories>, failure: @escaping Failure){
        guruProvider.request(.fetchStories, model: GuruStories.self, completion: completion, failure: failure)
    }
}

extension NetworkManager {
    // MARK: - Methods for testing purposes
    func fetchStoriesFromFile(completion: @escaping (Bool, GuruStories?) -> Void) {
        let jsonPath = "stories"
        let parser = Parser()

        parser.getJsonData(jsonPath, completion: { data in
            if let json = data {
                do {
                    let estimate = try JSONDecoder().decode(GuruStories.self, from: json)
                    completion(true, estimate)
                }
                catch _ as NSError {
                    fatalError("Couldn't load data from \(jsonPath)")
                }
            }
        })
    }
}
