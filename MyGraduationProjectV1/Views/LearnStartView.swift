//
//  LearnStartView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/20.
//

import SwiftUI

struct LearnStartView: View {
    @ObservedObject var wordListViewModel: WordListViewModel = WordListViewModel()
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: LearningWordListVIew(),
                    label: {
                        Text("学习的单词列表")
                    })
                
                NavigationLink(
                    destination: LearningWordListVIew(),
                    label: {
                        Text("开始学习")
                    })
                Text("Hello, World!")
                
            }
            .navigationBarTitle("Learning")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LearnStartView_Previews: PreviewProvider {
    static var previews: some View {
        LearnStartView()
    }
}
