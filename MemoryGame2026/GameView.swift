//
//  GameView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-12.
//
//  A SwiftUI view that renders the game board and handles gameplay interactions.
//  It shows an n x n grid of tiles, reveals tiles on tap, tracks tap counts and
//  remaining treasures, and starts with a brief period where tiles are visible
//  before being hidden by a timer.
//

import SwiftUI
import Combine

/// The main gameplay screen.
///
/// Renders a grid of tiles from a `Board`, manages reveal interactions,
/// counts remaining treasures, and optionally includes a bonus tile mechanic.
struct GameView: View {
    
    /// The board dimension (n x n) provided by the parent view.
    var size : Int
    
    /// The treasure symbol name to assign to treasure tiles.
    var treasure : String
    
    /// Placeholder images used for hidden tiles (selected via `curIndex`).
    private let images = ["pencil", "eraser", "scribble", "lasso"]
    
    /// Default image for non-treasure, non-bonus tiles (currently unused here).
    var circleImage = "circle.dotted"
    
    /// Image identifier for the bonus tile.
    var BonusTile = "moon"
    
    /// Whether the bonus tile feature is enabled for this game.
    var Bonus: Bool
    
    /// Index selecting which placeholder image to show for hidden tiles.
    @AppStorage("curIndex") private var curIndex = 0
    
    /// The game board model driving the grid; initialized and replaced on appear.
    @State private var board = Board(n: 5, treasure: "sun.max", Bonus: true)
    
    /// The number of tile taps performed by the player.
    @State private var tapCount: Int = 0
    
    /// The current number of unrevealed treasure tiles remaining.
    @State private var treasureCount: Int = 0
    
    /// A one-shot 4-second timer used to hide tiles after initial display.
    @State var timer = Timer.publish(every: 4, on:.main, in:.common).autoconnect()
    
    /// Guard flag to prevent the timer from firing more than once.
    //@State var repeatTimer = false
    
    /// Tracks whether a tile has been tapped (currently unused for logic).
    @State var tappedTile = false
    
    /// The game UI: renders the grid, status counters, and manages lifecycle events.
    var body: some View {
        // Tile grid: iterate rows and tiles from the board model.
        #if os(watchOS)
        
        VStack{
            // Use the first tile's id per row as an identifier for the row.
            ForEach(board.tiles, id: \.first!.id){
                row in HStack{
                    // Render each tile in the row.
                    ForEach(row){
                        tile in
                        // Show a placeholder when hidden; otherwise the tile's contents.
                        Image(systemName: tile.hidden == true ? images[curIndex]  : tile.contents)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.primary)
                            .frame(width: 20, height: 30)
                            .accessibilityIdentifier(images[curIndex])
                            // Reveal behavior when a tile is tapped.
                            .onTapGesture {
                                
                                handleTap(on: tile)
                                
                            }
                     
                    }
                }
                
            }
            
            HStack{
                Text("Picks:  \(treasureCount)")
                    .font(.system(size: 12, weight: .bold))
                        
                Text("Left:  \(tapCount)")
                    .font(.system(size: 12, weight: .bold))
            }
        }.padding()
  
        // Status bar showing remaining treasures and total tap count.
       
        // Hide all tiles after 4 seconds (only once) to start the game.
        .onReceive(timer){_ in
            // Prevent multiple firings by guarding on a boolean flag.
//            guard !repeatTimer else {return}
//            repeatTimer = true
            timer.upstream.connect().cancel()
            self.board.toggleHidden()
            
        }
        // Initialize the board and compute the initial treasure count when the view appears.
        .onAppear(){
            tapCount = 0
            treasureCount = 0
            timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
            
            // Create a new board with the configured size, treasure, and bonus setting.
            self.board = Board(n: size, treasure: treasure, Bonus: Bonus)
            // Randomly assign treasures to 25% of the tiles.
            self.board.assigntreasure(treasure: treasure)
            // Optionally place a single bonus tile at a random non-treasure location.
            self.board.assignBonusTile(treasure: treasure, Bonus:Bonus)
          
            // Count initial number of treasure tiles to populate the counter.
            for row in board.tiles {
                for tile in row{
                    if tile.contents == treasure{
                        treasureCount += 1
                    }
                }
            }
            
            
        }
        #else
       
        VStack{
            // Use the first tile's id per row as an identifier for the row.
            ForEach(board.tiles, id: \.first!.id){
                row in HStack{
                    // Render each tile in the row.
                    ForEach(row){
                        tile in
                        // Show a placeholder when hidden; otherwise the tile's contents.
                        Image(systemName: tile.hidden == true ? images[curIndex]  : tile.contents)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.primary)
                            .frame(width: 45, height: 100)
                            .accessibilityIdentifier(images[curIndex])
                            // Reveal behavior when a tile is tapped.
                            .onTapGesture {
                                
                                handleTap(on: tile)
                                
                            }
                     
                    }
                }
                
            }
           
        }.padding()
  
        // Status bar showing remaining treasures and total tap count.
        HStack{
            Text("No. of Unrevealed Treasure Count:  \(treasureCount)")
                .font(.system(size: 12, weight: .bold))
                    
            Text("Tap Count:  \(tapCount)")
                .font(.system(size: 12, weight: .bold))
        }
        // Hide all tiles after 4 seconds (only once) to start the game.
        .onReceive(timer){_ in
            // Prevent multiple firings by guarding on a boolean flag.
//            guard !repeatTimer else {return}
//            repeatTimer = true
            timer.upstream.connect().cancel()
            self.board.toggleHidden()
            
        }
        // Initialize the board and compute the initial treasure count when the view appears.
        .onAppear(){
            //timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
            // Create a new board with the configured size, treasure, and bonus setting.
            self.board = Board(n: size, treasure: treasure, Bonus: Bonus)
            // Randomly assign treasures to 25% of the tiles.
            self.board.assigntreasure(treasure: treasure)
            // Optionally place a single bonus tile at a random non-treasure location.
            self.board.assignBonusTile(treasure: treasure, Bonus:Bonus)
          
            // Count initial number of treasure tiles to populate the counter.
            for row in board.tiles {
                for tile in row{
                    if tile.contents == treasure{
                        treasureCount += 1
                    }
                }
            }
            
            
        }
#endif
    }
    
    /// Handles a tile tap: reveals the tile, updates counters, and applies bonus effects.
    /// - Parameter tile: The tile that was tapped.
    private func handleTap(on tile: Tile) {
        // Ignore taps on already revealed tiles.
        guard tile.hidden else {return}
        // Reveal the tapped tile.
        tile.hidden = false
       
        // Increment total tap count.
        tapCount += 1
        // If the tile is a treasure, decrement the remaining count.
        if (tile.contents == treasure ) {
            treasureCount -= 1
        }
        // If the tile is the bonus tile, reset the tap counter.
        if(tile.contents == BonusTile){
            tapCount = 0
        }
    }
    
}

// SwiftUI preview for quick testing of the game screen.
#Preview{
    ContentView()
}
