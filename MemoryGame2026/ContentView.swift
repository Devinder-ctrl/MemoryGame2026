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
                    .foregroundStyle(.tint)
                    .onTapGesture{
                       
                            if curIndex == 0{
                                curIndex = 3
                            }
                            else if curIndex != 2 || curIndex != 1 || curIndex != 0{                                curIndex = curIndex - 1
                            
                        }
                    }
               
                  Image(systemName: images[curIndex])
                        .resizable().aspectRatio(contentMode: .fit)
                        .foregroundStyle(.black)
                
                    
                
                Image(systemName: "arrowtriangle.right")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 60)
                     .foregroundStyle(.tint)
                    .onTapGesture {
                           
                            if curIndex == 0 || curIndex == 1 || curIndex == 2{
                                curIndex = curIndex + 1
                            }
                            else if curIndex == 3{
                                curIndex = 0
                            }
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

