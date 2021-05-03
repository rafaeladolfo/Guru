//
//  CarouselViewModel.swift
//  Guru
//
//  Created by Rafael Adolfo  on 01/05/21.
//

import SwiftUI

enum Direction {
    case right
    case left
}

final class StoriesViewModel: ObservableObject {
    @Published var viewPressed = false
    @Published var currentImageIndex: Int = 0
    @Published var timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @Published var model: Stories = Stories(items: [])
    @Published var carouselModel: Carousel = Carousel(items: [])

    private var imagesCount: Int = 0

  

    private func populateCarouselModel(stories: Stories) {

        for items in stories.items {
            carouselModel.items.append(.init(imageUrl: items.image, pageUrl: items.link, pageTitle: items.title))
        }
    }

    private func startTimer() {
        self.timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    }

    private func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
}

extension StoriesViewModel {

    func changeImage(imageDirection: Direction) {
        stopTimer()
        switch imageDirection {
        case .right:
//            currentImageIndex = currentImageIndex < numberOfImages ? currentImageIndex + 1 : 0
            currentImageIndex = (currentImageIndex + 1) % (imagesCount == 0 ? 1 : imagesCount)
        case .left:
            currentImageIndex = currentImageIndex > 1 ? currentImageIndex - 1 : 0
        }
        startTimer()
    }

    func handleImageTapByPosition(tapXLocation: CGFloat) {
        let imageDirection: Direction = tapXLocation > UIScreen.main.bounds.width / 2 ? .right : .left
        HapticEngineManager.sendHapticFeedback()
        changeImage(imageDirection: imageDirection)
    }
}
