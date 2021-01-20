//
//  StarLevelView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/10.
//

import SwiftUI

struct StarLevelView: View {
    @State var starLevel:Int = 3
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    var maximumRating = 5
    //number是第x颗星星，starLevel是评分（应该有几颗黄色星星）
    func image(for number: Int) -> Image {
        if number > starLevel {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    var body: some View {
        HStack(spacing:0) {
            ForEach(1..<maximumRating + 1) {
                number in
                self.image(for: number)
                    .foregroundColor(number > self.starLevel ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.starLevel = number
                    }
            }
        }
    }
}

struct StarLevelView_Previews: PreviewProvider {
    static var previews: some View {
        StarLevelView(starLevel: 3)
    }
}
