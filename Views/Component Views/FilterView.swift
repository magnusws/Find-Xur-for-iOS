import SwiftUI

struct FilterView: View {
    @ObservedObject var xurVM : XurViewModel
    @State var showTypes: Dictionary<Int,Bool>
    @State var showPicker: Bool
    
    var body: some View {
         
         return VStack(spacing: 25) {
             //                    Spacer()
             VStack(spacing: 20) {
             Rectangle()
                 .frame(width: 60, height: 6)
                 .cornerRadius(3)
                 .foregroundColor(Color.gray.opacity(0.7))
            }
            
             Text("Show Exotics")
             Spacer()
             VStack(spacing: 15){
                
                Spacer()
                
                Spacer()
                SettingsButton(color: "green", text: "Titan Exotics", isSelected: showTypes[1] == true ? true : false, action: {
                    print("Displaying titan exotics")
                    if self.showTypes[1] == false {
                        self.showTypes[1] = true
                    } else {
                        self.showTypes[1] = false
                    }
                 })

                SettingsButton(color: "green", text: "Hunter Exotics", isSelected: showTypes[2] == true ? true : false, action: {
                    print("Displaying hunter exotics")
                    if self.showTypes[2] == false {
                        self.showTypes[2] = true
                    } else {
                        self.showTypes[2] = false
                    }
                })

                SettingsButton(color: "green", text: "Warlock Exotics", isSelected: showTypes[3] == true ? true : false, action: {
                    print("Displaying warlock exotics")
                    if self.showTypes[3] == false {
                        self.showTypes[3] = true
                    } else {
                        self.showTypes[3] = false
                    }
                })
                SettingsButton(color: "green", text: "Exotic Weapons", isSelected: showTypes[4] == true ? true : false, action: {
                   print("Displaying weapon exotics")
                    if self.showTypes[4] == false {
                        self.showTypes[4] = true
                    } else {
                        self.showTypes[4] = false
                    }
                })
                
                Spacer()
                SettingsButton(color: "green", text: "Done", action: {
                   self.showPicker = false
                })
             }
            
            Spacer()
            
        }
    }
}

/*
struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        let xurPreviewVM = XurViewModel(testData: true)
        let previewTypes = [1: true, 2: true, 3: false, 4: true]
        return FilterView(xurVM: xurPreviewVM, showTypes: previewTypes , showPicker: true)
    }
}
*/
