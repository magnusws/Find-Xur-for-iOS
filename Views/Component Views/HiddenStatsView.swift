import SwiftUI

struct HiddenStatsView: View {
    var item: InventoryItem
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // Aim Assistance:
            if item.stats?.stats?["1345609583"]?.value != nil {
                HStack(alignment: .center) {
                    Text("\(weaponStatDict["1345609583"]!)").bold().foregroundColor(.secondary)
                    Spacer()
                    ProgressBar(value: Double(item.stats!.stats!["1345609583"]!.value!))
                    Text("\(item.stats!.stats!["1345609583"]!.value!)").frame(width: 30, alignment: .leading).foregroundColor(.secondary)
                }
            }
            
            // Recoil Direction
            if item.stats?.stats?["2715839340"]?.value != nil {
                HStack(alignment: .center) {
                    Text("\(weaponStatDict["2715839340"]!)").bold().foregroundColor(.secondary)
                    Spacer()
                    ProgressBar(value: Double(item.stats!.stats!["2715839340"]!.value!))
                    Text("\(item.stats!.stats!["2715839340"]!.value!)").frame(width: 30, alignment: .leading).foregroundColor(.secondary)
                }
                
            }
            
            // Zoom
            if item.stats?.stats?["3555269338"]?.value != nil {
                HStack(alignment: .center) {
                    Text("\(weaponStatDict["3555269338"]!)").bold().foregroundColor(.secondary)
                    Spacer()
                    ProgressBar(value: Double(item.stats!.stats!["3555269338"]!.value!))
                    Text("\(item.stats!.stats!["3555269338"]!.value!)").frame(width: 30, alignment: .leading).foregroundColor(.secondary)
                }
                
            }
            
        }.font(.system(.subheadline))
    }
}

struct HiddenStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HiddenStatsView(item: items[9])
    }
}
