import SwiftUI

struct ItemStatView: View {
    var item: InventoryItem
    
    var body: some View {
        // MARK: Item Stats List
        VStack(alignment: .leading) {
            if item.classType == 3 {
                RocketLauncherStatsView(item: item).padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                WeaponStatsView(item: item)
                BowStatsView(item: item)
                HiddenStatsView(item: item).padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            } else {
                GearStatView(item: item)
            }
        }
       
    }
    
   
}

struct ItemStatView_Previews: PreviewProvider {
    static var previews: some View {
        ItemStatView(item: items[1])
    }
}
