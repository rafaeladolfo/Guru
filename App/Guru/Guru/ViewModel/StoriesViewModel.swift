//
//  CarouselViewModel.swift
//  Guru
//
//  Created by Rafael Adolfo  on 01/05/21.
//

import SwiftUI
import Foundation

enum Direction {
    case right, left
}

enum TimerState {
    case start, stop
}

final class StoriesViewModel: BaseViewModel {
    // MARK: - Properties
    @Published var model: Stories = Stories()
    @Published var currentImageIndex: Int = 0
    @Published var viewPressed = false

    @Published var progressBarValues: [Float] = []

    private var imagesCount: Int = 0

    override init() {
        super.init()
        startProgressBar()
    }

    // MARK: - Public methods
    override func load() {
        fetchStories()
        startProgressBar()
    }

    func fetchStories() {
        state = .loading
        NetworkManager.shared.fetchStories { [weak self] response in
            if response.items.count == 0 {
                self?.state = .failed("No stories")
                return
            }
            self?.populateCarouselModel(stories: response)
            self?.state = .loaded
        } failure: { err in
            self.state = .failed(err)
        }
    }

    func changeImage(imageDirection: Direction) {
        switch imageDirection {
        case .right:
            currentImageIndex = (currentImageIndex + 1) % (imagesCount == 0 ? 1 : imagesCount)
        case .left:
            currentImageIndex = currentImageIndex > 0 ? currentImageIndex - 1 : imagesCount-1
        }
        handleProgressBar()
    }

    func handleProgressBar() {
        for index in 0...imagesCount-1 {
            if index < currentImageIndex {
                self.progressBarValues[index] = 1
            } else {
                self.progressBarValues[index] = 0.0
            }
        }
        handleProgressBarTimer()
    }

    func handleImageTapByPosition(tapXLocation: CGFloat) {
        let imageDirection: Direction = tapXLocation > UIScreen.main.bounds.width / 2 ? .right : .left
        HapticEngineManager.sendHapticFeedback()
        changeImage(imageDirection: imageDirection)
    }

    // MARK: - Private methods
    private func fetchStoriesFromFile() {
        NetworkManager.shared.fetchStoriesFromFile { success, data in
            if success {
                self.populateCarouselModel(stories: data!)
            }
        }
    }

    private func populateCarouselModel(stories: GuruStories) {
        model.items.removeAll()
        for items in stories.items {
            model.items.append(.init(imageUrl: items.image, pageUrl: items.link, pageTitle: items.title))
        }        
        imagesCount = model.items.count
    }

    private func startProgressBar() {
        self.progressBarValues.removeAll()
        for _ in 0...9 {
            self.progressBarValues.append(0.0)
        }
        handleProgressBarTimer()
    }

    private func handleProgressBarTimer() {
        let index = currentImageIndex

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if index != self.currentImageIndex || self.viewPressed {
                timer.invalidate()
                return
            }

            self.progressBarValues[self.currentImageIndex] += 0.02
            if self.progressBarValues[self.currentImageIndex] >= 1  {
                timer.invalidate()
                self.changeImage(imageDirection: .right)
            }
        }
    }
}
