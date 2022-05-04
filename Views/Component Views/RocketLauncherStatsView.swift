import SwiftUI

struct RocketLauncherStatsView: View {
    var item: InventoryItem
    
    var body: some View {
        
        VStack(alignment: .leading) {
        // Blast radius:
        if item.stats?.stats?["3614673599"]?.value != nil {
            HStack(alignment: .center) {
                Text("\(weaponStatDict["3614673599"]!)").bold().foregroundColor(.primaryFontColor)
                Spacer()
                ProgressBar(value: Double(item.stats!.stats!["3614673599"]!.value!))
                Text("\(item.stats!.stats!["3614673599"]!.value!)").frame(width: 30, alignment: .leading).foregroundColor(.primaryFontColor)
            }
        }
        
        // Velocity:
        if item.stats?.stats?["2523465841"]?.value != nil {
            HStack(alignment: .center) {
                Text("\(weaponStatDict["2523465841"]!)").bold().foregroundColor(.primaryFontColor)
                Spacer()
                ProgressBar(value: Double(item.stats!.stats!["2523465841"]!.value!))
                Text("\(item.stats!.stats!["2523465841"]!.value!)").frame(width: 30, alignment: .leading).foregroundColor(.primaryFontColor)
            }
        }
        }.font(.system(.subheadline))
    }
}

struct RocketLauncherStatsView_Previews: PreviewProvider {
    static var previews: some View {
        RocketLauncherStatsView(item: items[90])
    }
}
