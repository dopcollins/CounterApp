//
//  ContentView.swift
//  CounterApp
//
//  Created by Collins Roy on 23/12/25.
//

import SwiftUI
import AVKit



struct ContentView: View {
    @State private var count = 0
    
    var body: some View {
        ZStack {
//            Image("img2")
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
//                .opacity(0.80)

            
            VideoPlayerView(videoName: "video")  
                .ignoresSafeArea()
                
            
            
            
            VStack {
        
                Text("Counter")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                Spacer()
                
                
                Text("Number :")
                Text("\(count)")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white, .white.opacity(0.8)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 200, height: 100)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.ultraThinMaterial)
                            .shadow(color: .black.opacity(0.6), radius: 15, x: 0, y: 8)
                    )
                   
                
                Buttonside(count: $count)
                
                Spacer()
            }
        }
    }
}


#Preview {
    ContentView()
}
