//
//  SwiftUIView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/12.
//

import SwiftUI

struct TextEditorAutoUp: View {
    @State private var name = ""
    var body: some View {
        
        VStack {
            Image("EN")
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 300)
                .clipShape(Circle())
            TextEditor(text: $name)
              .textFieldStyle(RoundedBorderTextFieldStyle())
            
        }
            
        }
    }

struct TextEditorAutoUp_Previews: PreviewProvider {
    static var previews: some View {
        TextEditorAutoUp()
    }
}
