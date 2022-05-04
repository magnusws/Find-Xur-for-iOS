import SwiftUI

struct PickerContentView: View {
    @ObservedObject var xurVM : XurViewModel
    @Binding var movingOffset: CGFloat
    @Binding var selected: Int
    let screenSize = UIScreen.main.bounds.size
    @State private var textTitle = ""
    
    var body: some View {
        let screenWidth = screenSize.width
        let exoticTypes = [0, 1, 2, 3, 4]
        let typeDict: Dictionary = [0: "All", 1: "Titan", 2: "Hunter", 3: "Warlock", 4: "Weapon"]
        
        let phoneRatio = String(format: "%.3f", screenSize.width / screenSize.height)
        let refRatio =   String(format: "%.3f",  9.0 / 16.0)
        let isXorAbove = phoneRatio != refRatio
        // let gradientColors = Gradient(colors: [.clear, .mapBgColor])
        
        return
            VStack(spacing: 20) {
            Rectangle()
                .frame(width: 60, height: 6)
                .cornerRadius(3)
                .foregroundColor(Color.gray.opacity(0.7))
            Divider()
            Picker(selection: $selected, label: EmptyView()) {
                        ForEach(0 ..< exoticTypes.count) {
                            Text("\(typeDict[exoticTypes[$0]]!)")
                        }
            }.frame(width: screenWidth * 0.8, alignment: .center)
            Spacer()
            }.padding(.bottom, isXorAbove ? 60 : 50 )
            .padding(.top, 15)
    }
}

struct PickerContentView_Previews: PreviewProvider {
    static var previews: some View {
        let xurPreviewVM = XurViewModel(testData: true)
        return PickerContentView(xurVM: xurPreviewVM, movingOffset: .constant(0.0), selected: Binding.constant(1))
    }
}
