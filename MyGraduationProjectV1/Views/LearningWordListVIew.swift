//
//  LearningWordListVIew.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/20.
//

import SwiftUI

struct LearningWordListVIew: View {
    @ObservedObject var learningWordViewModel: LearningWordViewModel = LearningWordViewModel()
    

    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.learningWordViewModel.learningWordList,id:\.self){
                    word in
                    
                    VStack {
                        Text("WordID: \(word.wordID)")
                        Text("WordContent: \(word.wordContent ?? "no content")")
                        Text("WordDetail: \(word.sourceWord?.translation ?? "no translation")")
                    }
                    
                }
                
            }
            .navigationBarTitle("Learning")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { // <2>
                ToolbarItem(placement: .navigationBarLeading) { // <3>
                    Button {
                        self.learningWordViewModel.deleteAll()
                    } label: {
                        Text("DeleteAll")
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu{
                        Button(action: {
                            self.learningWordViewModel.preloadLearningWordFromCSV()
                        }) {
                            Label("Preload", systemImage: "text.badge.plus")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
    }
}

struct LearningWordListVIew_Previews: PreviewProvider {
    static var previews: some View {
        LearningWordListVIew()
    }
}
