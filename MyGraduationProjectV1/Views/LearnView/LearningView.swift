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
            
            //今日复习进度条
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
                        self.learnWordViewModel.getTodayReviewWordItems()
                    }, label: {
                        Text("get")
                    })
                }
            }
            //今日复习进度条
            
            //新词+学习卡片
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color(.systemGray6))
                        .frame(width: UIScreen.main.bounds.width - 20, alignment: .center)
                    Text("完成今日学习")
                }
                
                //复习的单词
                ForEach(self.learnWordViewModel.todayReviewWordList.reversed(), id: \.self) {
                    wordItem in
                    ReviewCardView(learningWordItem: wordItem, learnWordViewModel: self.learnWordViewModel, wordListViewModel: self.wordListViewModel)
                }
                
                //新学的单词
                ForEach(self.learnWordViewModel.todayNewWordList.reversed(), id: \.self) {
                    wordItem in
                    ReviewCardView(learningWordItem: wordItem, learnWordViewModel: self.learnWordViewModel, wordListViewModel: self.wordListViewModel)
                }
            }
            //.frame(width: UIScreen.main.bounds.width - 20, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .stroke(Color.black.opacity(0.2), lineWidth: 1.0)
                )
            
            //底部
            VStack{
                HStack{
                   Text("")
                }
            }.padding([.top,.bottom],10)
            //底部
        }
        .background(Color(.systemGray6)
                        .frame(width: UIScreen.main.bounds.width)
                        .edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
        .hiddenTabBar()
        .ignoresSafeArea(edges:.bottom)
        
    }
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView()
    }
}
