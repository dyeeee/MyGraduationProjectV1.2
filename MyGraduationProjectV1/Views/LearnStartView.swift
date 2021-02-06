//
//  LearnStartView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/20.
//

import SwiftUI

struct LearnStartView: View {
    @ObservedObject var wordListViewModel: WordListViewModel = WordListViewModel()
    @ObservedObject var learnWordViewModel: LearnWordViewModel = LearnWordViewModel()
    @AppStorage("LearnDayCount") var learnDayCount:Int = 1
    
    var body: some View {
        NavigationView {
            VStack(spacing:20) {
                Text("今天是此单词书学习的第\(learnDayCount)天")
                NavigationLink(
                    destination: LearningWordListVIew(),
                    label: {
                        Text("学习的单词列表")
                    })
                
                NavigationLink(
                    destination: LearningView(),
                    label: {
                        Text("开始学习")
                    })
                Text("Hello, World!")
                
            }
            .navigationBarTitle("Learning")
            .navigationBarTitleDisplayMode(.inline)
            .showTabBar()
        }
    }
}

struct LearnStartView_Previews: PreviewProvider {
    static var previews: some View {
        LearnStartView()
    }
}
