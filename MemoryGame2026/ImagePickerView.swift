//
//  ImagePickerView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-12.
//
//  A simple image selector that lets the user cycle through a fixed set of
//  SF Symbols using left/right arrow buttons. The current selection is bound
//  via `curIndex` so parent views can react to changes.
//

import SwiftUI

/// A lightweight picker for cycling through a set of images.
///
/// Provides left/right buttons to change `curIndex`, displaying the currently
/// selected image from `images`.
struct ImagePickerView: View {
    /// The pool of selectable SF Symbol names.
    private let images = ["pencil", "eraser", "scribble", "lasso"]
    
    /// The currently selected image index, bound to a parent view.
    @Binding var curIndex: Int
    /// Unused state placeholder (can be removed if not needed).
    @State private var Bonus: Bool = false
    /// Unused state placeholder for size (can be removed if not needed).
    @State private var size = 0
    
    /// Horizontal control with left/right buttons and a preview of the selected image.
    var body: some View {
        #if os(watchOS)
        HStack(spacing: 20) {
        Button(action: previous) {
            Image(systemName: "arrowtriangle.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40) // Fixed width so the arrow button has a large, tappable target.
                .accessibilityIdentifier("left button")
        }
        .buttonStyle(.plain)
        .foregroundStyle(.tint)
        
        // Display the currently selected symbol.
        Image(systemName: images[curIndex])
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundStyle(.primary)
            .frame(height: 60)
            .accessibilityIdentifier(images[curIndex])
        
        Button(action: next) {
            Image(systemName: "arrowtriangle.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40) // Fixed width for consistent, accessible tap target.
                .accessibilityIdentifier("Right BUtton")
        }
        .buttonStyle(.plain)
        .foregroundStyle(.tint)
    }
        #else
        // Layout: arrows on the sides with the selected image centered.
        HStack(spacing: 24) {
            Button(action: previous) {
                Image(systemName: "arrowtriangle.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60) // Fixed width so the arrow button has a large, tappable target.
                    .accessibilityIdentifier("left button")
            }
            .buttonStyle(.plain)
            .foregroundStyle(.tint)
            
            // Display the currently selected symbol.
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
                    .frame(width: 60) // Fixed width for consistent, accessible tap target.
                    .accessibilityIdentifier("Right BUtton")
            }
            .buttonStyle(.plain)
            .foregroundStyle(.tint)
        }
#endif
    }
    
    /// Selects the previous image, wrapping to the end when at the beginning.
    private func previous() {
        curIndex = (curIndex - 1 + images.count) % images.count
    }
    
    /// Selects the next image, wrapping to the beginning when at the end.
    private func next() {
        curIndex = (curIndex + 1) % images.count
    }
}

// SwiftUI preview for testing the image picker UI.
#Preview {
    ContentView()
}
       
