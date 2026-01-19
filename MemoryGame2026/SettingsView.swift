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
    @AppStorage("value") private var value = 5
    var body: some View {
        
        VStack(spacing: 16) {
            
            ImagePickerView(curIndex: $curIndex)
            
            Stepper ("\(value) Rows/Cols" , value: $value, in: 5...10)
            
            Toggle("Bonus", isOn: $Bonus)
            
                .padding()
        }
    }
    // MARK: - Actions
   
}
    #Preview {
        ContentView()
    }
        
