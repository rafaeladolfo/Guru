//
//  Home.swift
//  Guru
//
//  Created by Rafael Adolfo  on 03/05/21.
//

import SwiftUI

struct Home: View {

    var body: some View {
        StoriesView()
        StocksListView()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
