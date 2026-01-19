
import SwiftUI


struct ContentView: View {
    private let images = ["pencil", "eraser", "scribble", "lasso"]
    
    @AppStorage("curIndex") private var curIndex = 0
    @AppStorage("Bonus") private var Bonus: Bool = false
    @AppStorage("value") private var value = 0
    @State var images2 = ["gear", "house"]
    @State var index = 0
    var body: some View {
    
        NavigationStack{
                        VStack{
                            if index == 0{
                                SettingsView()
                                
                            }else{
                                GameView()
                            }
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
        
    
   



#Preview {
    ContentView()
}
       
        
 
