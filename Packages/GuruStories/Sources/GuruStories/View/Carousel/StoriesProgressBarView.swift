//
//  StoriesProgressBarView.swift
//  
//
//  Created by Rafael Adolfo  on 03/05/21.
//

import SwiftUI

@available(iOS 14.0, *)
struct StoriesProgressBarView: View {
    @State var progressBarQuantity: Int = 10
    @Binding var progressBarValues: [Float]

    var body: some View {
        HStack (alignment: .top) {
            ForEach(0 ..< progressBarQuantity, id:\.self) { index in
                LinearProgressBarView(value: $progressBarValues[index])
                    .frame(maxWidth: .infinity)
                    .frame(height: 10)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 10, height: 10, alignment: .leading)
    }
}
