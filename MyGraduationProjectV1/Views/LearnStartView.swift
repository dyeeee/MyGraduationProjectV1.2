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
    
    
    var body: some View {
        NavigationView {
            VStack(spacing:20) {
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
