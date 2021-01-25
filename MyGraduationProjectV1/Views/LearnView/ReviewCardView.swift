//
//  ReviewCardView.swift
//  MyStudyCard
//
//  Created by YES on 2021/1/5.
//

import SwiftUI


//一张复习卡片
struct ReviewCardView: View {
    @ObservedObject var learningWordItem:LearningWordItem
    @ObservedObject var learnWordViewModel: LearnWordViewModel
    @ObservedObject var wordListViewModel:WordListViewModel
    
    
    @State var showThisCard:Bool = true
    @State var afterUnknown:Bool = false
    
    @State var todayReviewCount = 0
    //var removal: (() -> Void)? = nil
    
    
    var body: some View {
        if showThisCard {
            ZStack(alignment:.center) {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.white)
                
                
                VStack {
                    todayReviewCountView(reviewCount: self.$todayReviewCount)
                    
                    
                    
                    if afterUnknown {
                        WordDetailView(wordItem: self.learningWordItem.sourceWord ?? WordItem(), wordListViewModel: self.wordListViewModel)
                            .frame(width: UIScreen.main.bounds.width - 20, alignment: .center)
                    }
                    else{
                        VStack {
                            Text(self.learningWordItem.wordContent ?? "noContent")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.clear)
                                .overlay(Rectangle().frame(height:6)
                                            .foregroundColor(Color.blue.opacity(0.8))
                                            .offset(x:0,y:12))
                        }.overlay(
                            Text(self.learningWordItem.wordContent ?? "noContent")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        )
                        .padding([.top],20)
                        
                        WordPhoneticView(phonetic_EN: self.learningWordItem.sourceWord?.phonetic_EN ?? "no phonetic_EN", phonetic_US: self.learningWordItem.sourceWord?.phonetic_US ?? "no phonetic_US",fontSize: 20)
                        
                        VStack(alignment:.leading){
                            Text("例句")
                                .font(.callout)
                                .foregroundColor(Color("WordSentencesColor"))
                            
                            WordExampleSentencesView(wordContent: self.learningWordItem.wordContent!, wordExampleSentences: self.learningWordItem.sourceWord?.exampleSentences ?? "noEXP",maxLine:2,showCH:false)
                        }.padding([.leading,.trailing],30)
                    }
                    
                    
                    Spacer()
                    
                    VStack {
                        
                        ZStack {
                            HStack{
                                Button(action: {
                                    self.afterUnknown = true
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                                            .frame(width: UIScreen.main.bounds.width*0.25, height: 40, alignment: .center)
                                            .foregroundColor(Color(red: 245/255, green: 245/255, blue: 250/255))
                                        HStack {
                                            Image(systemName: "flame.fill")
                                            
                                            Text("不认识").font(.custom("FZDIHT_JW--GB1-0", size: 18,relativeTo: .body))
                                        }.foregroundColor(Color(.systemRed))
                                    }
                                })
                                
                                Button(action: {}, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                                            .frame(width: UIScreen.main.bounds.width*0.25, height: 40, alignment: .center)
                                            .foregroundColor(Color(red: 245/255, green: 245/255, blue: 250/255))
                                        HStack {
                                            Image(systemName: "cloud.fill")
                                            Text("模糊").font(.custom("FZDIHT_JW--GB1-0", size: 18,relativeTo: .body))
                                        }.foregroundColor(Color(.systemBlue))
                                    }
                                })
                                
                                Button(action: {
                                    if self.todayReviewCount == 3 {
                                        //self.showThisCard = false
                                    }else{
                                        self.todayReviewCount = self.todayReviewCount + 1
                                    }
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                                            .frame(width: UIScreen.main.bounds.width*0.25, height: 40, alignment: .center)
                                            .foregroundColor(Color(.systemGray6))
                                        
                                        HStack {
                                            Image(systemName: "leaf.fill")
                                                .renderingMode(.template)
                                                .font(.title3)
                                            Text("认识").font(.custom("FZDIHT_JW--GB1-0", size: 18,relativeTo: .body))
                                        } .foregroundColor(Color(.systemGreen))
                                    }
                                })
                            }.frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
                            
                            if(afterUnknown){
                                Button(action: {
                                    self.showThisCard = false
                                }, label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 5, style: .continuous)
                                            .frame(width: UIScreen.main.bounds.width*0.75, height: 40, alignment: .center)
                                            .foregroundColor(Color(red: 240/255, green: 240/255, blue: 245/255))
                                        HStack {
                                            Image(systemName: "checkmark.circle.fill")
                                            
                                            Text("记住了").font(.custom("FZDIHT_JW--GB1-0", size: 18,relativeTo: .title))
                                        }.foregroundColor(Color(.systemGreen))
                                    }
                                })
                            }
                        }
                    }.padding(.bottom,15)
                    //                    }
                }.padding(.top,30)
                
            }
        }
        
    }
}


struct todayReviewCountView: View {
    @Binding var reviewCount:Int
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5.0, style: .continuous)
                .fill(Color(.systemGray4))
                .opacity(0.3)
                .frame(width: 90, height: 20, alignment: .center)
            
            
            HStack(spacing:3) {
                ForEach(0..<3,id:\.self){
                    num in
                    RoundedRectangle(cornerRadius: 5.0, style: .continuous)
                        .fill(num < reviewCount ? Color(.systemGreen) : Color(.systemGray3))
                        .frame(width: 25, height: 10, alignment: .center)
                }
                
            }
            
        
        }
        
    }
}

struct ReviewCardView_Previews: PreviewProvider {
    static var previews: some View {
        let wordItem = WordItem(context: PersistenceController.preview.container.viewContext)
        wordItem.wordID = 24543
        wordItem.starLevel = 3
        wordItem.wordContent = "alleviate"
        wordItem.phonetic_EN = "ә'li:vieit"
        wordItem.phonetic_US = "[ə'livɪ'et]"
        wordItem.definition = "v provide physical relief, as from pain\nv make easier"
        wordItem.translation = "vt. 减轻, 使缓和"
        wordItem.collinsLevel = 1
        wordItem.wordTags = "cet6 ky toefl ielts gre"
        wordItem.bncLevel = 7706
        wordItem.frqLevel = 55
        wordItem.wordExchanges = "d:alleviated/i:alleviating/3:alleviates/p:alleviated"
        wordItem.exampleSentences = "Excuse me what eyedrop can be treated or to what eyedrop can be treated or alleviate myopic eyedrop ah?<br>请问一下有没有什么眼药水可以治疗或缓解近视的眼药水啊？<br>And ease the tension in the form of many, why not bring serious harm to the body of a factor to alleviate it?<br>而且缓解紧张情绪的形式很多，为什么非要拿一个严重危害身体的因素来缓解呢？<br>The reason that cats can alleviate negative moods is often attributed to attachment - the emotional bond between cat and owner.<br>猫能够改善人们负性情绪的原因往往都归于他们对人的依恋——猫与主人间的感情粘合剂。<br>"
        
        wordItem.wordNote = ""
        
        let learnWord = LearningWordItem(context: PersistenceController.preview.container.viewContext)
        learnWord.wordID = 24543
        learnWord.wordContent = "alleviate"
        learnWord.sourceWord = wordItem
        
        return
            ReviewCardView(learningWordItem: learnWord, learnWordViewModel: LearnWordViewModel(), wordListViewModel: WordListViewModel())
            .frame(width: UIScreen.main.bounds.width - 20, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .stroke(Color.black.opacity(0.2), lineWidth: 1.0))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .navigationBarTitleDisplayMode(.inline)
    }
}
