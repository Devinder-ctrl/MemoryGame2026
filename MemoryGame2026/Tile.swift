//
//  tile.swift
//  MemoryGame2026
//
//  Created by  on 2026-02-02.

//create an @Observable class called Tile.
//Tile must contain a String called contents
import SwiftUI
import Observation

@Observable class Tile: Identifiable {
    var contents: String = "circle.dotted"
    var hidden: Bool = false
   
}

