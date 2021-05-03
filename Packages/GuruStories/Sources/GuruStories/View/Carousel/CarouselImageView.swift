//
//  CarouselImageView.swift
//
//
//  Created by Rafael Adolfo  on 01/05/21.
//

import SwiftUI

@available(iOS 14.0, *)
struct CarouselImageView: View {
    @Binding var isDisplayingSafari: Bool

    var imageUrl: String
    var overlayText: String
    var geometry: GeometryProxy

    var body: some View {
        ZStack {
            WebImage(url: imageUrl)
                .scaledToFill()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()

            Rectangle()
                .foregroundColor(.clear)
                .background(LinearGradient(gradient: Gradient(colors: [Color(.systemBackground), .clear]), startPoint: .bottom, endPoint: .top))
                .overlay(
                    ImageOverlayView(overlayText: overlayText)
                        .onTapGesture {
                            self.isDisplayingSafari.toggle()
                        }
                    , alignment: .bottom)
        }
    }
}
