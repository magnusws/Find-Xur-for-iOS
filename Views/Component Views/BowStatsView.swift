import SwiftUI

struct BowStatsView: View {
    var item: InventoryItem
    var body: some View {
        VStack(alignment: .leading) {
            
            // Accuracy:
            if item.stats?.stats?["1591432999"]?.value != nil {
                HStack(alignment: .center) {
                    Text("\(weaponStatDict["1591432999"]!)").foregroundColor(.primaryFontColor)
                    Spacer()
                    ProgressBar(value: Double(item.stats!.stats!["1591432999"]!.value!))
                    Text("\(item.stats!.stats!["1591432999"]!.value!)").frame(width: 30, alignment: .leading).foregroundColor(.primaryFontColor)
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
            }
            
            // Draw Time:
            if item.stats?.stats?["447667954"]?.value != nil {
                HStack(alignment: .center) {
                    Text("\(weaponStatDict["447667954"]!): ").bold().foregroundColor(.primaryFontColor)
                    Text("\(item.stats!.stats!["447667954"]!.value!)").frame(width: 30, alignment: .leading).foregroundColor(.primaryFontColor)
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
            }
    
        }
        
        
    }
}

struct BowStatsView_Previews: PreviewProvider {
    static var previews: some View {
        BowStatsView(item: items[88])
    }
}
