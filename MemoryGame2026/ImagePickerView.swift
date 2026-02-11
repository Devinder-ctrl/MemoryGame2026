//
//  ImagePickerView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-12.
//
import SwiftUI

struct ImagePickerView: View {
    private let images = ["pencil", "eraser", "scribble", "lasso"]
    
    @Binding var curIndex: Int
    @State private var Bonus: Bool = false
    @State private var size = 0
    var body: some View {
        HStack(spacing: 24) {
            Button(action: previous) {
                Image(systemName: "arrowtriangle.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60)
                    .accessibilityIdentifier("left button")
            }
            .buttonStyle(.plain)
            .foregroundStyle(.tint)
            
            Image(systemName: images[curIndex])
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.primary)
                .frame(height: 120)
                .accessibilityIdentifier(images[curIndex])
            
            Button(action: next) {
                Image(systemName: "arrowtriangle.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60)
                    .accessibilityIdentifier("Right BUtton")
            }
            .buttonStyle(.plain)
            .foregroundStyle(.tint)
        }
    }
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
       
