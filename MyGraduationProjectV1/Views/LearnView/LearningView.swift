//
//  LearningView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/25.
//

import SwiftUI

struct LearningView: View {
    @ObservedObject var wordListViewModel: WordListViewModel = WordListViewModel()
    @ObservedObject var learnWordViewModel: LearnWordViewModel = LearnWordViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var wordExample = ["allow","alleviate","among"]
    
    var body: some View {
        VStack {
            VStack{
                HStack{
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Back")
                    })
                    Rectangle()
                        .frame(width: 200, height: 20, alignment: .center)
                        .foregroundColor(Color(.systemTeal))
                    
                    Button(action: {
                        self.learnWordViewModel.getTodayNewWordItems(num: 30)
                    }, label: {
                        Text("get")
                    })
                }
            }
            
            ZStack {
                ForEach(self.learnWordViewModel.todayNewWordList, id: \.self) {
                    wordItem in
                    ReviewCardView(learningWordItem: wordItem, learnWordViewModel: self.learnWordViewModel, wordListViewModel: self.wordListViewModel)
                        
                    
                }
            }
            .frame(width: UIScreen.main.bounds.width - 30, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .stroke(Color.black.opacity(0.2), lineWidth: 1.0)
        )
        }
        .navigationBarHidden(true)
        .hiddenTabBar()
    }
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView()
    }
}
