//
//  RotatingCircleView.swift
//  SpaceXLaunches_SwiftUI
//
//  Created by Krunal Mistry on 9/24/22.
//

import SwiftUI

/**
    Custome rortating indicator
 https://www.appcoda.com/swiftui-animation-basics-building-a-loading-indicator/
 */
struct RotatingCircleView: View {
    @State private var isLoading = false

        var body: some View {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color.green, lineWidth: 5)
                .frame(width: 200, height: 200)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.default.repeatForever(autoreverses: false))
                .onAppear() {
                    self.isLoading = true
                }
        }
}

struct RotatingCircleView_Previews: PreviewProvider {
    static var previews: some View {
        RotatingCircleView()
    }
}
