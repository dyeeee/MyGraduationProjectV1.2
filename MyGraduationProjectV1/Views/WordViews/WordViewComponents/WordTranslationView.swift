//
//  WordTranslationView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/11.
//

import SwiftUI


struct WordTranslationView: View {
    @State var wordTranslastion:String = "vt. 减轻, 使缓和"
    @State var wordDefinition:String = "v provide physical relief, as from pain\nv make easier"
    
    
    func dealTrans(_ rawTrans:String) -> String {
        let pattern1 = "^(vt|n|a|adj|adv|v|pron|prep|num|art|conj|vi|interj|r)(\\.| )"
        let regex1 = try! Regex(pattern1)
         
        //只替换第1个匹配项
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
    
    var body: some View {
        VStack(alignment:.leading,spacing:15) {
            if(self.wordTranslastion != "nullTag" ){
            VStack(alignment:.leading,spacing:3) {
                VStack {
                    Text("英汉释义")
                        .font(.caption2)
                        .padding(1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 2.0)
                                .stroke())
                }.foregroundColor(Color("WordTransColor"))
                Text("\(dealTrans(self.wordTranslastion))")
                    .padding([.leading],5)
                    .contextMenu {
                        Button(action: {
                            UIPasteboard.general.string = dealTrans(self.wordTranslastion)
                        }) {
                            Text("Copy to clipboard")
                            Image(systemName: "doc.on.doc")
                        }
                    }
                    //.foregroundColor(Color())
            }}
            if(self.wordDefinition != "nullTag" ){
            VStack(alignment:.leading,spacing:3) {
                VStack {
                    Text("英英释义")
                        .font(.caption2)
                        .padding(1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 2.0)
                                .stroke())
                }.foregroundColor(Color("WordTransColor"))
                Text("\(dealTrans(self.wordDefinition))")
                    .padding([.leading],5)
                    .contextMenu {
                        Button(action: {
                            UIPasteboard.general.string = dealTrans(self.wordDefinition)
                        }) {
                            Text("Copy to clipboard")
                            Image(systemName: "doc.on.doc")
                        }
                    }
            }}
        }.font(.callout)
        .padding(.bottom, 10)
        .padding(.top, 5)
    }
}

struct WordTranslationView_Previews: PreviewProvider {
    static var previews: some View {
        WordTranslationView()
    }
}
