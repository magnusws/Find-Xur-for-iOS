import SwiftUI

struct GearProgressBar: View {
    @State var value: Double
    @State var viewDidAppear: Bool = false
    
    private let maxValue: Double = 42
    private let backgroundEnabled: Bool = true
    private let backgroundColor: Color = Color.mapBgColor
    private let foregroundColor: Color = Color.primaryFontColor.opacity(0.9)
    
    var animation: Animation {
        Animation.interactiveSpring(dampingFraction: 0.8)
            .speed(0.4)
            .delay(0.003 * Double(value))
    }
    
    var body: some View {
        // 1
        ZStack {
            // 2
            GeometryReader { geometryReader in
                // 3
                if self.backgroundEnabled {
                    Capsule()
                        .foregroundColor(self.backgroundColor) // 4
                }
                    
                Capsule()
                .frame(
                    width: self.progress(
                        value: self.viewDidAppear ? self.value : 0,
                        maxValue: self.maxValue,
                        width: geometryReader.size.width
                    ),
                    alignment: .leading
                )
                .foregroundColor(self.foregroundColor)
                .animation(self.animation)
            }
        }.frame(width: screenSize.width - 200, height: 14, alignment: .trailing)
        .onAppear() {
            self.viewDidAppear = true
        }
        .onDisappear() {
            self.viewDidAppear = false
        }
    }
    
    static func backgroundColor() -> Color {
        return Color(UIColor(red: 245/255,
                             green: 245/255,
                             blue: 245/255,
                             alpha: 1.0))
    }
    
    static func foregroundColor() -> Color {
        return Color.black
    }
    
    private func progress(value: Double,
                          maxValue: Double,
                          width: CGFloat) -> CGFloat {
        let percentage = value / maxValue
        return width *  CGFloat(percentage)
    }
    
}




struct GearProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        GearProgressBar(value: 20)
    }
}
