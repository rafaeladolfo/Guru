//
//  StoriesCarouselView.swift
//  Guru
//
//  Created by Rafael Adolfo  on 01/05/21.
//

import SwiftUI

public struct StoriesView: View {
    @Environment(\.scenePhase) var appState
    @StateObject var viewModel = StoriesViewModel()

    public var body: some View {
        let dragGesture = DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged {  g in
                self.viewModel.handleImageTapByPosition(tapXLocation: g.location.x)
            }

        let longPressGesture = LongPressGesture(minimumDuration: 10.0)
            .onChanged { _ in self.viewModel.viewPressed = true  }
            .onEnded {  _ in self.viewModel.viewPressed = false }

        ZStack {
            switch viewModel.state {
            case .idle:
                Color.clear.onAppear(perform: viewModel.fetchStories)
            case .loading:
                LoadingView()
            case .failed(let error):
                ErrorView(errorMessage: error)
            case .loaded:
                StoriesContentView(progressBarValues: $viewModel.progressBarValues,
                                   currentImageIndex: $viewModel.currentImageIndex,
                                   model: viewModel.model)
                    .gesture(dragGesture)
            }
        }
        .onChange(of: appState) { (state) in
            if state == .active {
                viewModel.state = .idle
            }
        }
    }

    public init() {

    }
}
