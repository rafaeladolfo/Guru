//
//  ProgressBarView.swift
//  Guru
//
//  Created by Rafael Adolfo  on 02/05/21.
//

import SwiftUI

struct LinearProgressBarView: View {
    @Binding var value: Float

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: 2)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))

                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: 2)
                    .foregroundColor(Color(UIColor.systemGreen))
            }
            .cornerRadius(45.0)
        }
    }
}

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
