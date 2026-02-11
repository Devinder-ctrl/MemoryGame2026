//
//  Board.swift
//  MemoryGame2026
//
//  Created by  on 2026-02-02.
//
//  Observable board class for creating a board game using tiles and treasures
//  it converts 25% of tiles content into treasures


import SwiftUI
import Observation

//observable class board
@Observable class Board {
    var n : Int
    var treasure: String
    var tiles : [[Tile]] =  [[Tile]]()
    //default image
    var circleImage = "circle.dotted"
    var Bonus = "moon"
    var randomFound = false
    //image array
    private let images = ["pencil", "eraser", "scribble", "lasso"]
   
    //initialize n, treasure, board
    init(n:Int, treasure:String) {
        self.n = n
        self.treasure = treasure
        for _ in 0..<n{
            var tileRow = [Tile]()
            for _ in 0..<n{
                tileRow.append(Tile())
                
            }
            tiles.append(tileRow)
        }
    }
    
  //assign random treasures
    func assigntreasure(treasure : String){
        //25% of treasures are equal to multiple of n divided by 4
        let numberOfTreasure = (n * n) / 4
        //for storing treasures
        var count = 0
        while(count < numberOfTreasure){
                //random row and column
                let rowRandom = Int.random(in: 0..<n)
                let colRandom = Int.random(in: 0..<n)
                //random tile
            let randomTile = self.tiles[rowRandom][colRandom]
                if (randomTile.contents != treasure){
                    randomTile.contents = treasure
                    count = count + 1
                   
                }
            }
            
        
    }
   
    //assign random Bonus tile
    func assignBonusTile(treasure : String){
        while(randomFound != true){
        //random row and column
        let rowRandom = Int.random(in: 0..<n)
        let colRandom = Int.random(in: 0..<n)
        //random tile
        let randomTile = self.tiles[rowRandom][colRandom]
       
            if (randomTile.contents != treasure){
                randomTile.contents = Bonus
                randomFound = true
            }
            
        }
    }
          
      
         //function for hiding tiles
    func toggleHidden(){
        for r in tiles{
            for tile in r{
                tile.hidden = true
                }
        }
    }
  
}
#Preview{
   ContentView()
}
