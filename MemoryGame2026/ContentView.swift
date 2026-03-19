//
//  ContentView.swift
//  MemoryGame2026
//
//  The root SwiftUI view that hosts either the Settings screen or the Game screen
//  and provides a toolbar button to toggle between them.
//

import SwiftUI

/// The app's main entry view.
///
/// Displays either `SettingsView` or `GameView` depending on the current index.
/// A toolbar button allows toggling between the two modes.
struct ContentView: View {
   
    /// Example image pool (currently unused in this view).
    private let images = ["pencil", "eraser", "scribble", "lasso"]
    
    /// Persisted index for other parts of the app (currently unused here).
    @AppStorage("curIndex") private var curIndex = 0
    /// Whether the bonus tile feature is enabled; stored persistently.
    @AppStorage("Bonus") private var Bonus: Bool = false
    /// Persisted board size used by `SettingsView` and passed to `GameView`.
    @AppStorage("value") private var size = 5
    /// Icons used for the toolbar toggle button (settings/game).
    @State var images2 = ["gear", "house"]
    /// Toggles between Settings (0) and Game (1) screens.
    @State var index = 0
    /// Default treasure symbol passed into the game screen.
    @State var treasure = "sun.max"
    
    
    /// Main view hierarchy containing a `NavigationStack`, a conditional content
    /// switch between Settings and Game, and a toolbar button to toggle screens.
    var body: some View {
        #if os(watchOS)

        TabView {
            SettingsView(size: $size)
                .tag(0)
            GameView(size: size, treasure: treasure, Bonus: Bonus)
                .tag(1)
        }
        .tabViewStyle(.verticalPage)
        #else

        // Wrap content in a navigation stack for toolbar and navigation support.
        NavigationStack{
            VStack{
                // Show Settings when index is 0; otherwise show the Game.
                if index == 0 {
                    // Bind the board size to settings for user adjustments.
                    SettingsView(size: $size)
                    
                }else{
                    // Pass configured values into the game screen.
                    GameView(size: size, treasure: treasure, Bonus: Bonus)
                }
                
            }
            // Toolbar with a single button to toggle between views.
            .toolbar{
                ToolbarItemGroup{
                    Button(action: {
                        // Toggle the index between 0 and 1.
                        index = (index + 1) % images2.count
                    },label: {
                        // Show the icon for the next screen (gear <-> house).
                        Image(systemName: images2[(index + 1) % images2.count])
                    })
                    .accessibilityIdentifier("Settings")
                    .foregroundColor(.blue)
                  
                }
            }
        }
#endif
    }
   
}
   
// SwiftUI preview for testing the main entry view.
#Preview {
    ContentView()
}
       
 

