//
//  Stories.swift
//  Guru
//
//  Created by Rafael Adolfo  on 03/05/21.
//

import Foundation

struct Stories {

    var items: [StoriesItems]
}

extension Stories {

    init() {
        self.items = []
    }
}

struct StoriesItems {

    var imageUrl: String
    var pageUrl: String
    var pageTitle: String
}

extension StoriesItems {

    init() {
        self.imageUrl = ""
        self.pageUrl = ""
        self.pageTitle = ""
    }
}
