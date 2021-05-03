//
//  GuruApp.swift
//  Guru
//
//  Created by Rafael Adolfo  on 03/05/21.
//

import SwiftUI

@main
struct GuruApp: App {
    init() {
        NetworkMonitor.shared.startMonitoring()
    }
    
    var body: some Scene {
        WindowGroup {
            Home()
        }
    }
}
