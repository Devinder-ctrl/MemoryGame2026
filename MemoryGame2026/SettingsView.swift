//
//  SettingsView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-12.
//

import SwiftUI


struct SettingsView: View {
    private let images = ["pencil", "eraser", "scribble", "lasso"]
    
    @AppStorage("curIndex") private var curIndex = 0
    @AppStorage("Bonus") private var Bonus: Bool = false
    @Binding var size: Int
    var body: some View {
        
        VStack(spacing: 16) {
            
            ImagePickerView(curIndex: $curIndex)
            
            Stepper ("\(size) Rows/Cols" , value: $size, in: 5...10)
                
            Toggle("Bonus", isOn: $Bonus)
               
                .padding()
        }
    }
    // MARK: - Actions
   
}
    #Preview {
        ContentView()
    }
        
