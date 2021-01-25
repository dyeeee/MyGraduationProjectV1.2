//
//  LearningView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/25.
//

import SwiftUI

struct LearningView: View {
    var wordExample = ["allow","alleviate","among"]
    
    var body: some View {
        VStack {
            VStack{
                HStack{
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width - 30, height: 20, alignment: .center)
                        .foregroundColor(Color(.systemTeal))
                }
            }
            
            ZStack {
                ForEach(self.wordExample.reversed(), id: \.self) {
                    word in
                    //ReviewCardView(wordContent:word)
                    Text(word)
                }
            }
            .frame(width: UIScreen.main.bounds.width - 30, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .stroke(Color.black.opacity(0.2), lineWidth: 1.0)
        )
        }
    }
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView()
    }
}
