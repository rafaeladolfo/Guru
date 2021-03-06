//
//  ImageOverlayView.swift
//  Guru
//
//  Created by Rafael Adolfo  on 30/04/21.
//

import SwiftUI

struct ImageOverlayView: View {
    let overlayText: String

    var body: some View {
        ZStack(alignment: .bottom) {
            Text(overlayText)
                .font(.title2)
                .foregroundColor(.primary)
                .padding(.leading, 10)
        }
        .padding(.bottom, 20)
    }
}
