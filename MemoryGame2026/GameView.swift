//
//  GameView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-12.
//
//displays the current number of unrevealed treasure


import SwiftUI
import Combine

struct GameView: View {
    
    var size : Int
    var treasure : String
    private let images = ["pencil", "eraser", "scribble", "lasso"]
    var circleImage = "circle.dotted"
    var Bonus = "moon"
    @AppStorage("curIndex") private var curIndex = 0
    @State private var board = Board(n: 5, treasure: "sun.max")
    @State private var tapCount: Int = 0
    @State private var treasureCount: Int = 0
    @State var timer = Timer.publish(every: 4, on:.main, in:.common).autoconnect()
    @State var repeatTimer = false
    @State var tappedTile = false
    var body: some View {
        VStack{
            ForEach(board.tiles, id: \.first!.id){
                row in HStack{
                    ForEach(row){
                        tile in
                        Image(systemName: tile.hidden == true ? images[curIndex]  : tile.contents)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.primary)
                            .frame(width: 45, height: 100)
                            .accessibilityIdentifier(images[curIndex])
                            .onTapGesture {
                                
                                    handleTap(on: tile)
                                    
                                
                            }
                     
                    }
                }
                
            }
           
        }.padding()
  
        HStack{
            Text("No. of Unrevealed Treasure Count:  \(treasureCount)")
                .font(.system(size: 12, weight: .bold))
                    
            Text("Tap Count:  \(tapCount)")
                .font(.system(size: 12, weight: .bold))
        }
        .onReceive(timer){_ in
            guard !repeatTimer else {return}
            repeatTimer = true
            self.board.toggleHidden()
            
        }
        .onAppear(){
            
            self.board = Board(n: size, treasure: treasure)
            self.board.assigntreasure(treasure: treasure)
            self.board.assignBonusTile(treasure: treasure)
          
            for row in board.tiles {
                for tile in row{
                    if tile.contents == treasure{
                        treasureCount += 1
                    }
                }
            }
            
            
        }
    }
    
    private func handleTap(on tile: Tile) {
        
        guard tile.hidden else {return}
        // Reveal the tapped tile
        tile.hidden = false
       
        tapCount += 1
        if (tile.contents == treasure ) {
            treasureCount -= 1
        }
        if(tile.contents == Bonus){
            tapCount = 0
        }
    }
    
}

#Preview{
    ContentView()
}
