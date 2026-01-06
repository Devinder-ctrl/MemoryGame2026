//
//  ContentView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-05.
//

import SwiftUI

struct ContentView: View {
    let images = ["pencil", "eraser", "scribble", "lasso"]
    
    @State private var curIndex = 0
    var body: some View {
        
        VStack {
            HStack{
                Image(systemName: "arrowtriangle.left")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 60)
                    .padding(.horizontal, 17)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .onTapGesture{
                      curIndex = (curIndex - 1 + images.count) % images.count
                    }
               
                  Image(systemName: images[curIndex])
                        .resizable().aspectRatio(contentMode: .fit)
                        .imageScale(.small)
                        .foregroundStyle(.black)
                
                    
                
                Image(systemName: "arrowtriangle.right")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 60)
                    .padding(.horizontal, 17)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .onTapGesture {
                        curIndex = (curIndex + 1) % images.count
                    }
            }
                Text(images[curIndex])
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

