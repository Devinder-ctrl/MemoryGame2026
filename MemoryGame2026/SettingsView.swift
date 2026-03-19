//
//  SettingsView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-12.
//
//  A settings screen that lets the user choose the hidden tile image, adjust the
//  board size, and toggle the bonus tile feature. Values are persisted via
//  `@AppStorage` so they carry across app launches.
//

import SwiftUI

/// The settings interface for configuring game options.
///
/// Allows selecting the placeholder image (via `ImagePickerView`), choosing the
/// board size, and toggling the bonus tile feature. The selected values are
/// persisted with `@AppStorage`.
struct SettingsView: View {
    /// Available placeholder image names (not directly used here).
    private let images = ["pencil", "eraser", "scribble", "lasso"]
    
    /// Persisted index for the selected placeholder image.
    @AppStorage("curIndex") private var curIndex = 0
    /// Persisted flag indicating whether the bonus tile feature is enabled.
    @AppStorage("Bonus") private var Bonus: Bool = false
    /// Bound board size value shared with the parent view.
    @Binding var size: Int
    /// Layout with an image picker, size stepper, and bonus toggle.
    var body: some View {
        #if os(watchOS)
        VStack(spacing: 8) {
            // Choose the placeholder image shown for hidden tiles.
            ImagePickerView(curIndex: $curIndex)
            // Adjust the board dimension between 5 and 10.
            // Enable or disable the bonus tile mechanic.
            Toggle("Bonus", isOn: $Bonus)
                .frame(width:150,height:30)
                .padding()
                .accessibilityIdentifier("bonus")
        }
        #else
        
        
        // Stack controls with comfortable spacing.
        VStack(spacing: 16) {
            // Choose the placeholder image shown for hidden tiles.
            ImagePickerView(curIndex: $curIndex)
            // Adjust the board dimension between 5 and 10.
            Stepper ("\(size) Rows/Cols" , value: $size, in: 5...10)
            // Enable or disable the bonus tile mechanic.
            Toggle("Bonus", isOn: $Bonus)
                .padding()
                .accessibilityIdentifier("bonus")
        }
#endif
    }
    // MARK: - Actions
   
}
    
// SwiftUI preview for testing the settings screen.
#Preview {
    ContentView()
}
        
