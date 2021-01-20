//
//  WordSearchView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/13.
//

import SwiftUI

struct WordSearchView: View {
    @ObservedObject var wordListViewModel: WordListViewModel
    @State private var searchText = ""
    
    var body: some View {
        NavigationView{
            
            
            
            
            VStack {
                WordListView(wordListViewModel: self.wordListViewModel,dataType: .searchResult)
                    
                }.listStyle(InsetGroupedListStyle())
            .navigationTitle("Word List")
            .navigationBarTitleDisplayMode(.inline)
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
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            
        }
    }
    
    func dealTrans(_ rawTrans:String) -> String {
        let pattern1 = "^(vt|n|a|adj|adv|v|pron|prep|num|art|conj|vi|interj|r)(\\.| )"
        let regex1 = try! Regex(pattern1)
        
        //只替换第1个匹配项0000
        let out1 = regex1.replacingMatches(in: rawTrans, with: "[$1.] ", count: 1)
        
        
        
        let pattern2 = "n(vt|n|a|adj|adv|v|pron|prep|num|art|conj|vi|interj|r)(\\.| )"
        let regex2 = try! Regex(pattern2)
        //替换所有匹配项
        let out2 = regex2.replacingMatches(in: out1, with: "n[$1.] ")
        
        //        //输出结果
        //        print("原始的字符串：", rawTrans)
        //        print("替换第1个匹配项：", out1)
        //        print("替换所有匹配项：", out2)
        
        let result = out2.replacingOccurrences(of: "\\n", with: "\n")
        return result
    }
}


struct WordSearchView_Previews: PreviewProvider {
    static var previews: some View {
        WordSearchView(wordListViewModel: WordListViewModel())
    }
}
