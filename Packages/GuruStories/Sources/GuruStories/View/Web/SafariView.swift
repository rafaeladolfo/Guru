//
//  SafariView.swift
//  
//
//  Created by Rafael Adolfo  on 03/05/21.
//

import SwiftUI
import SafariServices

@available(iOS 14.0, *)
struct SafariView: UIViewControllerRepresentable {
    let url: URL
    let readerMode: Bool

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let config = SFSafariViewController.Configuration.init()
        config.entersReaderIfAvailable = readerMode

        return SFSafariViewController(url: url, configuration: config)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
    }
}
