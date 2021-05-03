//
//  LinearProgressBarView.swift
//  
//
//  Created by Rafael Adolfo  on 03/05/21.
//

import SwiftUI

@available(iOS 14.0, *)
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
