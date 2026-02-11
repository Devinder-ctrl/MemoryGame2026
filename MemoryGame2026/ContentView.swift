    
        
 

import SwiftUI


struct ContentView: View {
   
    private let images = ["pencil", "eraser", "scribble", "lasso"]
    
    @AppStorage("curIndex") private var curIndex = 0
    @AppStorage("Bonus") private var Bonus: Bool = false
    @AppStorage("value") private var size = 5
    @State var images2 = ["gear", "house"]
    @State var index = 0
    @State var treasure = "sun.max"
    
    
    var body: some View {
        
        NavigationStack{
            VStack{
                if index == 0 {
                    SettingsView(size: $size)
                    
                }else{
                    GameView(size: size, treasure: treasure)
                }
                
            }
            .toolbar{
                ToolbarItemGroup{
                    Button(action: {
                        index = (index + 1) % images2.count
                    },label: {
                        Image(systemName: images2[(index + 1) % images2.count])
                    })
                    .accessibilityIdentifier("Settings")
                    .foregroundColor(.blue)
                  
                }
            }
        }
    }
    
}
   



#Preview {
    ContentView()
}
       
        
 
