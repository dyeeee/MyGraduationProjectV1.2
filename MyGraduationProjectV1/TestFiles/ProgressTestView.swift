//
//  ProgressTestView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2020/12/30.
//

import SwiftUI

struct ProgressTestView: View {
    @State var progressValue: Float = 0.5

    var body: some View {
        ZStack {
            Color.yellow
                .opacity(0.1)
                .edgesIgnoringSafeArea(.all)

            VStack {
                ProgressBar(progress: self.$progressValue)
                    .frame(width: 150.0, height: 150.0)
                    .padding(40.0)

                Button(action: {
                    self.incrementProgress()
                }) {
                    HStack {
                        Image(systemName: "plus.rectangle.fill")
                        Text("随机增加一点")
                    }
                    .padding(15.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15.0)
                            .stroke(lineWidth: 2.0)
                    )
                }

                Spacer()
            }
        }
    }

    func incrementProgress() {
        let randomValue = Float([0.012, 0.022, 0.034, 0.016, 0.11].randomElement()!)
        self.progressValue += randomValue
    }
}

struct ProgressBar: View {
    @Binding var progress: Float

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.red)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)

            Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                .font(.largeTitle)
                .bold()
        }
    }
}

struct ProgressTestView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressTestView()
    }
}

