//
//  LearningWordListVIew.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/20.
//

import SwiftUI

struct LearningWordListVIew: View {
    @ObservedObject var wordListViewModel: WordListViewModel = WordListViewModel()
    
    var testIDList = ["704","608","898"]
    
    func getWord(id:Int32) -> String {
        let item = self.wordListViewModel.searchItemByID(id: id)
        return item.wordContent ?? "noContent"
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach(testIDList,id:\.self){
                    id in
                    Text(getWord(id: Int32(id) ?? 0))
                }
                
            }
            .navigationBarTitle("Learning")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LearningWordListVIew_Previews: PreviewProvider {
    static var previews: some View {
        LearningWordListVIew()
    }
}
