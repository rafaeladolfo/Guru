//
//  CarouselView.swift
//
//
//  Created by Rafael Adolfo  on 01/05/21.
//

import SwiftUI

@available(iOS 14.0, *)
struct CarouselView: View {
    @Binding var isDisplayingSafari: Bool
    @Binding var progressBarValues: [Float]
    @State var model: Stories
    @Binding var currentImageIndex: Int

    var geometry: GeometryProxy

    var body: some View {
        ZStack {
            StoriesProgressBarView(progressBarValues: $progressBarValues)
                .zIndex(1.0)
                .offset(y: -210)

            HStack(spacing:0) {
                ForEach(0..<10, id:\.self) { num in

                    CarouselImageView(isDisplayingSafari: $isDisplayingSafari,
                                      imageUrl: model.items[num].imageUrl,
                                      overlayText: model.items[num].pageTitle,
                                      geometry: geometry)
                }
            }
            .offset(x: CGFloat(currentImageIndex) * -geometry.size.width, y: 0)
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
            .edgesIgnoringSafeArea(.top)
        }
    }
}
