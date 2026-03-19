//
//  Board.swift
//  MemoryGame2026
//
//  Created by  on 2026-02-02.
//
//  Board is an observable model representing an N x N grid of tiles.
//  It can randomly assign a set percentage of tiles as treasures and one optional
//  bonus tile. It also provides utilities to hide tiles for gameplay.
//
//  Usage:
//  let board = Board(n: 4, treasure: "star", Bonus: true)
//  board.assigntreasure(treasure: board.treasure)
//  board.assignBonusTile(treasure: board.treasure, Bonus: board.Bonus)
//  board.toggleHidden()
//

import SwiftUI
import Observation

/// An observable board model for a tile-based memory game.
/// - Parameters:
///   - n: Board dimension (creates an n x n grid).
///   - treasure: The symbol name used to mark treasure tiles.
///   - Bonus: Whether a single bonus tile should be assigned.
///
/// The board initializes an n x n array of `Tile` instances and provides methods
/// to assign treasures, optionally place a bonus tile, and hide all tiles.
@Observable class Board {
    /// Board dimension (n x n grid size).
    var n : Int
    /// The content identifier (e.g., SF Symbol name) used for treasure tiles.
    var treasure: String
    /// 2D grid of tiles laid out as rows and columns.
    var tiles : [[Tile]] =  [[Tile]]()
    /// Default image used for non-treasure, non-bonus tiles.
    var circleImage = "circle.dotted"
    /// Image identifier for the bonus tile.
    var BonusTile = "moon"
    /// Tracks whether the bonus tile has been placed.
    var randomFound = false
    /// Flag indicating whether a bonus tile should be included on the board.
    var Bonus: Bool
    /// Example image pool (currently unused) that could be used for varied tile content.
    private let images = ["pencil", "eraser", "scribble", "lasso"]
   
    /// Creates a new board.
    /// - Parameters:
    ///   - n: The board dimension; creates an `n x n` grid.
    ///   - treasure: The symbol name to assign for treasure tiles.
    ///   - Bonus: Whether to enable placement of a single bonus tile.
    init(n:Int, treasure:String, Bonus:Bool) {
        self.n = n
        self.treasure = treasure
        self.Bonus = Bonus
        // Build an n x n grid of default-initialized tiles.
        for _ in 0..<n{
            // Create a new row of tile.
            var tileRow = [Tile]()
            // Append n tiles to the current row.
            for _ in 0..<n{
                tileRow.append(Tile())
                
            }
            tiles.append(tileRow)
        }
    }
    
    /// Randomly assigns treasure to 25% of tiles on the board.
    /// - Parameter treasure: The content identifier to mark as treasure.
    ///
    /// The number of treasure tiles is computed as `(n * n) / 4`. A tile is only
    /// updated if it doesn't already contain the treasure content to avoid
    /// double-counting in the placement loop.
    func assigntreasure(treasure : String){
        // Determine the target number of treasure tiles (25% of the board).
        let numberOfTreasure = (n * n) / 4
        // Place treasures until the target count is reached.
        var count = 0
        while(count < numberOfTreasure){
            // Choose a random row and column.
            let rowRandom = Int.random(in: 0..<n)
            let colRandom = Int.random(in: 0..<n)
            //random tile
            let randomTile = self.tiles[rowRandom][colRandom]
            // Only set treasure if this tile isn't already a treasure.
            if (randomTile.contents != treasure){
                randomTile.contents = treasure
                count = count + 1
               
            }
        }
        
    }
   
    /// Assigns a single bonus tile at a random location, if enabled.
    /// - Parameters:
    ///   - treasure: The treasure content identifier to avoid overwriting.
    ///   - Bonus: A flag indicating whether a bonus tile should be placed.
    ///
    /// The bonus tile will not overwrite an existing treasure tile. The method
    /// searches randomly until it finds a non-treasure tile, then marks it with
    /// `BonusTile` and sets `randomFound` to `true`.
    func assignBonusTile(treasure : String, Bonus: Bool){
        // Only attempt placement when bonus tiles are enabled.
        if (Bonus == true){
            // Keep searching for a valid spot until the bonus tile is placed.
            while(randomFound != true){
                // Choose a random tile position.
                let rowRandom = Int.random(in: 0..<n)
                let colRandom = Int.random(in: 0..<n)
                //random tile
                let randomTile = self.tiles[rowRandom][colRandom]
                // Avoid overwriting a treasure tile.
                if (randomTile.contents != treasure){
                    randomTile.contents = BonusTile
                    randomFound = true
                }
            }
            
            
        }
    }
          
      
    /// Hides all tiles on the board by setting each tile's `hidden` property to `true`.
    func toggleHidden(){
        // Iterate over each row and tile to update visibility.
        for r in tiles{
            for tile in r{
                tile.hidden = true
                }
        }
    }
  
}
// SwiftUI preview entry point for quick UI testing in Xcode.
#Preview{
   ContentView()
}
