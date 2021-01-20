//
//  ShowAllWordsView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/13.
//

import SwiftUI

struct ShowAllWordsView: View {
    @ObservedObject var wordListViewModel: WordListViewModel
    @State private var searchText = ""
    
    
    var body: some View {
        NavigationView{
            WordListView(wordListViewModel: self.wordListViewModel, dataType: .all)
                .navigationTitle("All Words")
                .toolbar { // <2>
                    ToolbarItem(placement: .navigationBarLeading) { // <3>
                        Button {
                            self.wordListViewModel.deleteAll()
                        } label: {
                            Text("DeleteAll")
                        }
                        
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu{
                            Button(action: {
                                self.wordListViewModel.createTestItem()
                            }) {
                                Label("Create Test", systemImage: "plus.circle")
                            }
                            Button(action: {
                                self.wordListViewModel.preloadFromCSV()
                            }) {
                                Label("Preload", systemImage: "text.badge.plus")
                            }
                            Button(action: {
                                self.wordListViewModel.preloadFromBigCSV()
                            }) {
                                Label("PreloadBig", systemImage: "text.badge.plus")
                            }
                            Button(action: {
                                self.wordListViewModel.deleteAllHistory()
                            }) {
                                Label("删除历史记录", systemImage: "trash")
                            }
                        } label: {
                            VStack {
                                Image(systemName: "ellipsis.circle")
                            }
                        }
                    }
                }
        }
    }
}

struct ShowAllWordsView_Previews: PreviewProvider {
    static var previews: some View {
        ShowAllWordsView(wordListViewModel: WordListViewModel())
    }
}
