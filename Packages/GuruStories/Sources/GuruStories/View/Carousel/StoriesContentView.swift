//
//  StoriesContentView.swift
//
//
//  Created by Rafael Adolfo  on 01/05/21.
//

import SwiftUI

@available(iOS 14.0, *)
struct StoriesContentView: View {
    @State private var isDisplayingSafari = false
    @Binding var progressBarValues: [Float]
    @Binding var currentImageIndex: Int
    @State var model: Stories


    var body: some View {
        GeometryReader { geometry in
            CarouselView(isDisplayingSafari: $isDisplayingSafari, progressBarValues: $progressBarValues, model: model, currentImageIndex:
                            $currentImageIndex, geometry: geometry)
        }
        .frame(width: UIScreen.main.bounds.width, height: 450, alignment: .center)
        .fullScreenCover(isPresented: $isDisplayingSafari) {
            SafariView(url: URL(string: model.items[currentImageIndex].pageUrl)!, readerMode: true)
        }

    }
}
