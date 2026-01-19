//
//  GameView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-12.
//
import SwiftUI
struct GameView: View {
    private let images = ["pencil", "eraser", "scribble", "lasso"]
    
    @AppStorage("curIndex") private var curIndex = 0
    
    var body: some View {
        
        
        Image(systemName: images[curIndex])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
        
        
    }
    
}

#Preview{
    ContentView()
}
