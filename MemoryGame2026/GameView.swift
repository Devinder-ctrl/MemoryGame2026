//
//  GameView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-12.
//
import SwiftUI
struct GameView: View {
    private let images = ["pencil", "eraser", "scribble", "lasso"]
    @State var images2 = ["gear", "house"]
    @State var index = 0
    @AppStorage("curIndex") private var curIndex = 0
    
    var body: some View {
        
            NavigationStack{
                            VStack{
                                if index == 0{
                                    SettingsView()
                                    
                                }else{
                                    Image(systemName: images[curIndex])
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .padding()
                                }
                            }
                            .toolbar{
                                ToolbarItemGroup{
                                    Button(action: {
                                        index = (index + 1) % images2.count
                                    },label: {
                                        Image(systemName: images2[(index + 1) % images2.count])
                                    })
                                }
                            }
                        }
                    }
                }
            
        
       
    

#Preview{
    GameView()
}
