//
//  ProgressBarViews.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2020/12/30.
//

import SwiftUI

struct ProgressBarViews: View {
    @State var progressValue: Float = 0.5
    
    
    
    var body: some View {
        VStack(spacing:50) {
            Button(action: {
                self.progressValue += 0.1
            }, label: {
                Text("Button")
            })
            
            CircleProgressBar(progressValue: $progressValue)
                .frame(width: 150.0, height: 150.0)
            LineProgressBar(progressValue: $progressValue)
                //.frame(width: 150.0, height: 150.0)
                .padding()
        }
    }
}

struct CircleProgressBar: View {
    @State var progressZero: Float = 0.0
    @State var test: String = ""
    @Binding var progressValue: Float {
        didSet{
            self.progressZero = 0.9
            self.test = "123"
            print(self.progressZero)
        }
    }
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.red)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progressZero, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(Animation.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)
                            .delay(0.4))
            
            Text(String(format: "%.0f %%", min(self.progressValue, 1.0)*100.0))
                .font(.largeTitle)
                .bold()
        }.onAppear(perform: {
            self.progressZero = self.progressValue
        })
    }
}

struct LineProgressBar: View {
    @State var progressZero: Float = 0.0
    @Binding var progressValue: Float
    //    {
    //        didSet{
    //            self.progressZero = 0.9
    //            self.test = "123"
    //            print(self.progressZero)
    //        }
    //    }
    
    var body: some View {
        GeometryReader { reader in
            ZStack(alignment:.center) {
                ZStack(alignment:.leading) {
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .frame(width: reader.size.width, height: 20, alignment: .center)
                        //.stroke(lineWidth: 20.0)
                        //.rotationEffect(Angle(degrees: 90.0))
                        .opacity(0.3)
                        .foregroundColor(Color.red)
                    
                    //RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .frame(width: reader.size.width*CGFloat(self.progressValue), height: 20, alignment: .leading)
                        //.stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color.red)
                    
                    
                    
                    
                }
                .onAppear(perform: {
                    self.progressZero = self.progressValue
                })
                .animation(Animation
                            .spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)
                )
                HStack {
                    Text(String(format: "%.1f %%", min(self.progressValue, 1.0)*100.0))
                        .font(.body)
                        .bold()
                }
                
            }
        }.frame(width: 100, height: 25, alignment: .center)
    }
}



struct ProgressBarViews_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarViews()
    }
}
