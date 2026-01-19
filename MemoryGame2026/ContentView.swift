
import SwiftUI


struct ContentView: View {
    private let images = ["pencil", "eraser", "scribble", "lasso"]
    
    @AppStorage("curIndex") private var curIndex = 0
    @AppStorage("Bonus") private var Bonus: Bool = false
    @AppStorage("value") private var value = 0
    var body: some View {
        SettingsView()
    }

    
    // MARK: - Actions
   
   
}


#Preview {
    ContentView()
}
       
        
 
