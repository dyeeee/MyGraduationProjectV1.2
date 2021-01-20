//
//  LearnStartView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/20.
//

import SwiftUI

struct LearnStartView: View {
    @ObservedObject var wordListViewModel: WordListViewModel = WordListViewModel()
    
    var testIDList = ["2899","3413","3598","3679"]
    
    
    var body: some View {
        NavigationView {
            VStack {
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
