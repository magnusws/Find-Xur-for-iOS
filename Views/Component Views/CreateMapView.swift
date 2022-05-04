import SwiftUI

struct MapView: View {
    @ObservedObject var xurVM : XurViewModel
    let screenSize = UIScreen.main.bounds.size
    @State private var textTitle = ""
    
    var body: some View {
        
        let screenWidth = screenSize.width
        var xurLocation = 10
        if xurVM.xur.locationID != nil {
            xurLocation = Int(xurVM.xur.locationID!)!
        }
        
        let mapFileName: Dictionary<Int, String> = [0: "mapDefault", 1: "mapTower", 2: "mapEDZ", 3: "mapIO", 4: "mapTitan", 5: "mapNessus", 10: "mapDefault"]
        let frameWidth: Dictionary<Int, CGFloat> = [0: 14, 1: 350, 2: 0, 3: 260, 4: 50, 5: 200, 10: 0]
        let frameHeight: Dictionary<Int, CGFloat> = [0: 300, 1: 300, 2: 300, 3: 300, 4: 300, 5: 300, 10: 300]
        
        return VStack() {
                    ZStack {
                        
                        // map image: scrollable
                        Image("\(mapFileName[xurLocation]!)")
                                .resizable()
                                .scaledToFill()
                                .scaleEffect(2.8)
                                .position(x: screenSize.width / 2, y: xurLocation > 3 ? 60 : 0)
                                .frame(width: frameWidth[xurLocation]!, height: frameHeight[xurLocation]!, alignment: .topLeading)
                                .edgesIgnoringSafeArea(.all)
                        
                        
                        VStack(spacing: 20) {
                            Rectangle()
                                .frame(width: 60, height: 6)
                                .cornerRadius(3)
                                .foregroundColor(Color.gray.opacity(0.7))
                            
                            Spacer()
                            
                            // Divider()
                            Text("\(locDict[xurLocation]!)").font(.body).foregroundColor(Color.primaryFontColor).bold()
                            Text("\(guideDict[xurLocation]!)")
                                .font(.footnote)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .frame(width: screenWidth * 0.8 )
                                .foregroundColor(Color.primaryFontColor)
                                .padding(.bottom)
                        }.padding(.vertical, 20)
            }
            }.edgesIgnoringSafeArea(.top)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let xurPreviewVM = XurViewModel(testData: true)
        return ForEach(["iPhone SE", "iPhone XS", "iPhone XR"], id: \.self) { deviceName in
            MapView(xurVM: xurPreviewVM)
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
                .preferredColorScheme(.light)
        }
    }
}
