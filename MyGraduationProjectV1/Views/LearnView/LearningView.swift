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
    
    @State var todayAllCount:Int = 36
    @State var todayNewCount:Int = 0
    @State var todayReviewCount:Int = 0
    
    @State var progressWidth = UIScreen.main.bounds.width - 80
    
    var wordExample = ["allow","alleviate","among"]
    
    var body: some View {
        VStack {
            
            //今日复习进度条
            VStack{
                HStack{
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                       Image(systemName: "chevron.left.square")
                        .font(.title)
                    })
                    ZStack(alignment:.leading) {
                        HStack(spacing:0) {
                            ZStack {
                                Rectangle()
                                    .frame(width: progressWidth/CGFloat(self.learnWordViewModel.todayAllCount)*CGFloat(todayNewCount), height: 25, alignment: .center)
                                    .foregroundColor(Color(.systemBlue))
                                Text("\(todayNewCount)")
                                    
                            }
                            ZStack {
                                Rectangle()
                                    .frame(width: progressWidth/CGFloat(self.learnWordViewModel.todayAllCount)*CGFloat(todayReviewCount), height: 25, alignment: .center)
                                    .foregroundColor(Color(.systemGreen))
                                Text("\(todayReviewCount)")
                            }
                        }
                        ZStack(alignment:.trailing) {
                            RoundedRectangle(cornerRadius: 5.0, style: .continuous)
                                .stroke()
                                .frame(width: progressWidth, height: 25, alignment: .center)
                            Text("\(self.learnWordViewModel.todayAllCount)")
                                .fontWeight(.semibold)
                                .padding(.trailing,5)
                        }
                    }.clipShape(RoundedRectangle(cornerRadius: 5.0, style: .continuous))
                Spacer()
                }.padding([.leading,.trailing], 10)
//                VStack {
//                    Text("新词\(todayNewCount)")
//                    Text("复习\(todayReviewCount)")
//                    Text("总数\(todayAllCount)")
//                    Text("今日进度\((todayNewCount+todayReviewCount)/todayAllCount)")
//                }
            }
            //今日复习进度条
            
            //新词+学习卡片
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color(.systemGray6))
                        .frame(width: UIScreen.main.bounds.width - 20, alignment: .center)
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("今日学习完成\n(补充统计数据、完成今日打卡)")
                        }
                    })
                }.zIndex(1)
                
                //复习的单词
                ForEach(self.learnWordViewModel.todayReviewWordList.reversed(), id: \.self) {
                    wordItem in
                    ReviewCardView(learningWordItem: wordItem, learnWordViewModel: self.learnWordViewModel, wordListViewModel: self.wordListViewModel, todayReviewCount: self.$todayReviewCount)
                }.zIndex(2)
                
                //新学的单词
                ForEach(self.learnWordViewModel.todayNewWordList.reversed(), id: \.self) {
                    wordItem in
                    LearnCardView(learningWordItem: wordItem, learnWordViewModel: self.learnWordViewModel, wordListViewModel: self.wordListViewModel, todayNewWord: self.$todayNewCount)
                }.zIndex(3)
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
        .navigationBarHidden(true)
        .background(Color(.systemGray6)
                        .frame(width: UIScreen.main.bounds.width)
                        .edgesIgnoringSafeArea(.all))
        .hiddenTabBar()
        .ignoresSafeArea(edges:.bottom)
        .onAppear(perform: {
            self.learnWordViewModel.getTodayList(learnDayCount: 1)
//            todayAllCount = self.learnWordViewModel.todayAllCount
//            todayNewCount = self.learnWordViewModel.todayNewCount
//            todayReviewCount = self.learnWordViewModel.todayReviewCount
        })
    }
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView()
    }
}
