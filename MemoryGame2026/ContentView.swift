//
//  ContentView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-05.
//

import SwiftUI

struct ContentView: View {
    private let images = ["pencil", "eraser", "scribble", "lasso"]
    
    @State private var curIndex = 0
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 24) {
                Button(action: previous) {
                    Image(systemName: "arrowtriangle.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60)
                }
                .buttonStyle(.plain)
                .foregroundStyle(.tint)
                
                Image(systemName: images[curIndex])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.primary)
                    .frame(height: 120)
                
                Button(action: next) {
                    Image(systemName: "arrowtriangle.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60)
                }
                .buttonStyle(.plain)
                .foregroundStyle(.tint)
            }
            
            Text(images[curIndex])
                .font(.headline)
                .monospaced()
        }
        .padding()
    }
    
    // MARK: - Actions
    private func previous() {
        curIndex = (curIndex - 1 + images.count) % images.count
    }
    
    private func next() {
        curIndex = (curIndex + 1) % images.count
    }
}

#Preview {
    ContentView()
}

