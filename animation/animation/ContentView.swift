//
//  ContentView.swift
//  animation
//
//  Created by rutik maraskolhe on 22/07/21.
//


import SwiftUI

struct ContentView: View {
    
    @State var isRotating = false
    @State var angleValue: CGFloat = 0.0
    
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.viewbackground)
                .edgesIgnoringSafeArea(.all)
            
            JoyStickBackgroundView()
            
            Circle()
                .fill(Color.lightShadow)
                .overlay(
                    Circle()
                        .stroke(Color.dipCircle1,lineWidth: 30)
                        .blur(radius: 5)
                )
                .frame(width: 60, height: 60)
            
            
            Group {
                Circle()
                    .fill(Color.viewbackground)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.5),lineWidth: 30)
                            .blur(radius: 5)
                            .offset(x: 2, y: 2)
                            .mask(Circle())
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.black.opacity(0.8),lineWidth: 6)
                            .blur(radius: 5)
                            .offset(x: -2, y: -2)
                            .mask(Circle())
                    )
                    .frame(width: 90, height: 90)
                
                KnobTopCircles()
                
            }
            
            .offset(x: isRotating ? -30 : 0.0)
            .rotationEffect(.degrees(Double(angleValue)))
            
            
           
            
            IndicatorView(isRotating: $isRotating, angleValue: $angleValue)
                
            
            Circle()
                .fill(Color.white.opacity(0.001))
                .frame(width: 30, height: 300)
                .gesture(
                    DragGesture(minimumDistance: 0.0)
                        .onChanged({value in
                            self.change(location: value.location)
                        })
                        .onEnded({_ in
                                 isRotating = false
                        })
                )
            
            Text("\(String.init(format: "%.0f", angleValue))")
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .offset(y: 300)
           
            
                
        }
    }
    
    
    private func change(location: CGPoint) {
        let vector1 = CGVector(dx: location.x - 150, dy: location.y - 150)
        let vector2 = CGVector(dx: 0 - 150, dy: location.y - 150)
        
        let angleV1V2 = atan2(vector2.dy, vector2.dx) - atan2(vector1.dy, vector1.dx)
        
        var degree = angleV1V2 * CGFloat(180.0 / .pi)
        
        if degree < 0 { degree += 360.0 }
        
        isRotating = true
        angleValue =  360 - degree
    }
   
    
}

struct IndicatorView :View {
    
    @Binding var isRotating: Bool
    @Binding var angleValue: CGFloat
    
    
    var body: some View {
        
        ZStack{
            
            Circle()
                .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, dash: [1, 40], dashPhase: 20))
                .frame(width: 250, height: 250)
            
            Circle()
                .trim(from: 0.0, to: 1.0)
                .stroke(
                    RadialGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0.001)]), center: .top, startRadius: 0, endRadius: 100),style: StrokeStyle(lineWidth: 6, lineCap: .round)
                    
                )
                .frame(width: 250, height: 250)
                .opacity(isRotating ? 1.0 : 0.0)
                .rotationEffect(.degrees(-90))
                .rotationEffect(isRotating ? .degrees(Double(angleValue)) : .degrees(0))
                .clipShape(
                    Circle()
                    .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, dash: [1, 40], dashPhase: 20))
                )
            
            
        }
       
        
        
    }
    
}

struct KnobTopCircles: View {
    var body: some View {
        ZStack{
            
            KnobView()
                .offset(x: 30)
            KnobView()
                .offset(x: -30)
            KnobView()
                .offset(y: 30)
            KnobView()
                .offset(y: -30)
            
        }
    }
}

struct KnobView: View {
    var body: some View{
        Circle()
            .fill(Color.clear)
            .overlay(
                Circle()
                    .stroke(Color.lightShadow,lineWidth: 4)
                    .blur(radius: 5)
                    .offset(x: 2, y: 2)
                    .mask(Circle())
            )
            .overlay(
                Circle()
                    .stroke(Color.darkShadow,lineWidth: 4)
                    .blur(radius: 5)
                    .offset(x: -2, y: -2)
                    .mask(Circle())
            )
            .frame(width: 8, height: 8)
        
    }
}

extension Color {
    static let viewbackground = Color.init(red: 42/255, green: 51/255, blue: 67/255)
    static let lightShadow = Color.init(red: 47/255, green: 56/255, blue: 74/255)
    static let darkShadow = Color.init(red: 13/255, green: 16/255, blue: 24/255)
    
    static let dipCircle = LinearGradient ( gradient: Gradient(colors: [lightShadow.opacity(0.3),darkShadow.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomLeading)
    
    static let dipCircle1 = LinearGradient (gradient: Gradient(colors: [lightShadow,darkShadow]), startPoint: .topLeading, endPoint: .bottomLeading)
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct JoyStickBackgroundView: View {
    var body: some View {
        Circle()
            
            .fill(Color.lightShadow)
            .overlay(
                Circle()
                    .stroke(Color.dipCircle,lineWidth: 50)
            )
            .overlay(
                Circle()
                    .stroke(Color.dipCircle,lineWidth: 35)
                    .blur(radius: 10)
                    .offset(x: 10.0, y: 10.0)
                    .mask(Circle().stroke(lineWidth: 40))
            )
            .overlay(
                Circle()
                    .stroke(Color.darkShadow.opacity(0.8),lineWidth: 35)
                    .blur(radius: 10)
                    .offset(x: -10.0, y: -10.0)
                    .mask(Circle().stroke(lineWidth: 40))
            )
            .overlay(
                Circle()
                    .stroke(Color.lightShadow.opacity(0.9),lineWidth: 35)
                    .blur(radius: 10)
                    .offset(x: 5.0, y: 5.0)
                    .mask(Circle().stroke(lineWidth: 40))
            )
            .overlay(
                Circle()
                    .stroke(Color.darkShadow.opacity(0.8),lineWidth: 35)
                    .blur(radius: 10)
                    .offset(x: -5.0, y: -5.0)
                    .mask(Circle().stroke(lineWidth: 40))
            )
            .overlay(
                Circle()
                    .stroke(Color.lightShadow,lineWidth: 6)
                    .blur(radius: 4)
                    .offset(x: 2.0, y: 2.0)
                
            )
            .overlay(
                Circle()
                    .stroke(Color.darkShadow,lineWidth: 6)
                    .blur(radius: 4)
                    .offset(x: -2.0, y: -2.0)
                
            )
            .frame(width: 120, height: 120)
    }
}
