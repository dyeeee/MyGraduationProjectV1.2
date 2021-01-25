//
//  LearningWordListVIew.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/20.
//

import SwiftUI

struct LearningWordListVIew: View {
    @ObservedObject var learnWordViewModel: LearnWordViewModel = LearnWordViewModel()
    @ObservedObject var wordListViewModel: WordListViewModel = WordListViewModel()
    
    @State var noteTypeIndex = 3
    let alphaList = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    var body: some View {
        //NavigationView{
            ScrollViewReader { reader in
                VStack(spacing:0) {
                    
                    Picker(selection: self.$noteTypeIndex, label: Text("Picker"), content:
                            {
                                Text("学习中").tag(0)
                                Text("未学习").tag(1)
                                Text("已掌握").tag(2)
                                Text("全部单词").tag(3)
                            })
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(5)
                        .padding([.top,.bottom],5)
                        .background(Color(.systemGray6))
                    
                    
                    
                    TabView(selection: self.$noteTypeIndex){
                        
                        VStack {
                            //定位到对应id的字母按钮
//                            HStack {
//                                Image(systemName: "scroll.fill")
//                                    HStack(spacing:2.5){
//                                            ForEach(self.alphaList,id:\.self){
//                                                char in
//                                                Button(action: {
//                                                    withAnimation{
//                                                        reader.scrollTo(char.uppercased())
//                                                    }
//                                                }, label: {
//                                                    FilterLabel(text:char)
//                                                })
//                                        }
//                                        Spacer()
//                                    }
//                            }
//                            .padding(.leading,10)
//                            .foregroundColor(Color("WordLevelsColor"))
//                            .padding(.bottom,-5)
//                            .padding(.top,2)
//                            //Text("test")
                            
                            
                            List {
                                ForEach(self.learnWordViewModel.learningWordList,id:\.self){
                                    word in
                                    NavigationLink(
                                        destination: WordDetailView(wordItem:self.wordListViewModel.searchItemByID(id: word.wordID),wordListViewModel:wordListViewModel,wordNote: word.sourceWord?.wordNote ?? "nullTag")
//                                            .onAppear(perform: {
//                                                item.latestSearchDate = Date()
//                                                item.historyCount = item.historyCount + 1
//                                            })
                                    )
                                    {
                                        VStack(alignment:.leading){
                                            Text(word.wordContent ?? "noContent")
                                                .font(.title3)
//                                            Text(dealTrans(word.sourceWord?.translation ?? "noTranslation").replacingOccurrences(of: "\n", with: "; "))
//                                                .font(.footnote)
//                                                .foregroundColor(Color(.systemGray))
//                                                .lineLimit(1)
                                        }
                                    }
                                }
                            }
                            .listStyle(InsetGroupedListStyle())
                        }.tag(0)
                        
                        VStack {
                            //定位到对应id的字母按钮
//                            HStack {
//                                Image(systemName: "scroll.fill")
//                                    HStack(spacing:2.5){
//                                            ForEach(self.alphaList,id:\.self){
//                                                char in
//                                                Button(action: {
//                                                    withAnimation{
//                                                        reader.scrollTo(char.uppercased())
//                                                    }
//                                                }, label: {
//                                                    FilterLabel(text:char)
//                                                })
//                                        }
//                                        Spacer()
//                                    }
//                            }
//                            .padding(.leading,10)
//                            .foregroundColor(Color("WordLevelsColor"))
//                            .padding(.bottom,-5)
//                            .padding(.top,2)
//                            //Text("test")
                            
                            
                            List {
                                ForEach(self.learnWordViewModel.unlearnedWordList,id:\.self){
                                    word in
                                    NavigationLink(
                                        destination: WordDetailView(wordItem:self.wordListViewModel.searchItemByID(id: word.wordID),wordListViewModel:wordListViewModel,wordNote: word.sourceWord?.wordNote ?? "nullTag")
//                                            .onAppear(perform: {
//                                                item.latestSearchDate = Date()
//                                                item.historyCount = item.historyCount + 1
//                                            })
                                    )
                                    {
                                        VStack(alignment:.leading){
                                            Text(word.wordContent ?? "noContent")
                                                .font(.title3)
//                                            Text(dealTrans(word.sourceWord?.translation ?? "noTranslation").replacingOccurrences(of: "\n", with: "; "))
//                                                .font(.footnote)
//                                                .foregroundColor(Color(.systemGray))
//                                                .lineLimit(1)
                                        }
                                    }
                                }
                            }
                            .listStyle(InsetGroupedListStyle())
                        }.tag(1)
                        
                        VStack {
                            //定位到对应id的字母按钮
//                            HStack {
//                                Image(systemName: "scroll.fill")
//                                    HStack(spacing:2.5){
//                                            ForEach(self.alphaList,id:\.self){
//                                                char in
//                                                Button(action: {
//                                                    withAnimation{
//                                                        reader.scrollTo(char.uppercased())
//                                                    }
//                                                }, label: {
//                                                    FilterLabel(text:char)
//                                                })
//                                        }
//                                        Spacer()
//                                    }
//                            }
//                            .padding(.leading,10)
//                            .foregroundColor(Color("WordLevelsColor"))
//                            .padding(.bottom,-5)
//                            .padding(.top,2)
//                            //Text("test")
                            
                            
                            List {
                                ForEach(self.learnWordViewModel.knownWordList,id:\.self){
                                    word in
                                    NavigationLink(
                                        destination: WordDetailView(wordItem:self.wordListViewModel.searchItemByID(id: word.wordID),wordListViewModel:wordListViewModel,wordNote: word.sourceWord?.wordNote ?? "nullTag")
//                                            .onAppear(perform: {
//                                                item.latestSearchDate = Date()
//                                                item.historyCount = item.historyCount + 1
//                                            })
                                    )
                                    {
                                        VStack(alignment:.leading){
                                            Text(word.wordContent ?? "noContent")
                                                .font(.title3)
//                                            Text(dealTrans(word.sourceWord?.translation ?? "noTranslation").replacingOccurrences(of: "\n", with: "; "))
//                                                .font(.footnote)
//                                                .foregroundColor(Color(.systemGray))
//                                                .lineLimit(1)
                                        }
                                    }
                                }
                            }
                            .listStyle(InsetGroupedListStyle())
                        }.tag(2)
                        
                        VStack {
                            //定位到对应id的字母按钮
//                            HStack {
//                                Image(systemName: "scroll.fill")
//                                    HStack(spacing:2.5){
//                                            ForEach(self.alphaList,id:\.self){
//                                                char in
//                                                Button(action: {
//                                                    withAnimation{
//                                                        reader.scrollTo(char.uppercased())
//                                                    }
//                                                }, label: {
//                                                    FilterLabel(text:char)
//                                                })
//                                        }
//                                        Spacer()
//                                    }
//                            }
//                            .padding(.leading,10)
//                            .foregroundColor(Color("WordLevelsColor"))
//                            .padding(.bottom,-5)
//                            .padding(.top,2)
//                            //Text("test")
                            
                            
                            List {
                                ForEach(self.learnWordViewModel.allWordsToLearnList,id:\.self){
                                    word in
                                    NavigationLink(
                                        destination: WordDetailView(wordItem:self.wordListViewModel.searchItemByID(id: word.wordID),wordListViewModel:wordListViewModel,wordNote: word.sourceWord?.wordNote ?? "nullTag")
//                                            .onAppear(perform: {
//                                                item.latestSearchDate = Date()
//                                                item.historyCount = item.historyCount + 1
//                                            })
                                    )
                                    {
                                        VStack(alignment:.leading){
                                            Text(word.wordContent ?? "noContent")
                                                .font(.title3)
//                                            Text(dealTrans(word.sourceWord?.translation ?? "noTranslation").replacingOccurrences(of: "\n", with: "; "))
//                                                .font(.footnote)
//                                                .foregroundColor(Color(.systemGray))
//                                                .lineLimit(1)
                                        }
                                    }
                                }
                            }
                            .listStyle(InsetGroupedListStyle())
                        }.tag(3)
                        
                        
                    }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                }
                .navigationTitle("学习中的单词列表")
                .background(Color(.systemGray6))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) { // <3>
                        Menu{
                            Button(action: {
                                self.learnWordViewModel.deleteAll()
                            }) {
                                Text("DeleteAll")
                            }
                            Button(action: {
                                self.learnWordViewModel.preloadLearningWordFromCSV()
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
    //}
}

struct LearningWordListVIew_Previews: PreviewProvider {
    static var previews: some View {
        LearningWordListVIew()
    }
}
