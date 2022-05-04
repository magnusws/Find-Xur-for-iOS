import SwiftUI

struct GearStat: View {
    var statHash: String
    var value: Int
    
    var body: some View {
        // Impact
        HStack() {
                Text("\(gearStatDict[statHash]!)").bold().foregroundColor(.primaryFontColor)
                Spacer()
                GearProgressBar(value: Double(value))
            Text("+\(value)").frame(width: 30, alignment: .trailing).foregroundColor(.primaryFontColor)
            }
    }
}

struct GearStat_Previews: PreviewProvider {
    static var previews: some View {
        GearStat(statHash: "392767087", value: 10)
    }
}
