import SwiftUI

struct WeaponStatsView: View {
    var item: InventoryItem
    
    var body: some View {
        VStack(alignment: .leading) {
            
            // Impact
                if item.stats?.stats?["4043523819"]?.value != nil {
                    HStack(alignment: .center) {
                        Text("\(weaponStatDict["4043523819"]!)").bold().foregroundColor(.primaryFontColor)
                        Spacer()
                        ProgressBar(value: Double(item.stats!.stats!["4043523819"]!.value!))
                        Text("\(item.stats!.stats!["4043523819"]!.value!)").frame(width: 30, alignment: .leading).foregroundColor(.primaryFontColor)
                    }
                    
                }
                
                // Range:
                if item.stats?.stats?["1240592695"]?.value != nil {
                    HStack(alignment: .center) {
                        Text("\(weaponStatDict["1240592695"]!)").bold().foregroundColor(.primaryFontColor)
                        Spacer()
                        ProgressBar(value: Double(item.stats!.stats!["1240592695"]!.value!))
                        Text("\(item.stats!.stats!["1240592695"]!.value!)").frame(width: 30, alignment: .leading).foregroundColor(.primaryFontColor)
                    }
                }
                
            // Stability:
            if item.stats?.stats?["155624089"]?.value != nil {
                HStack(alignment: .center) {
                    Text("\(weaponStatDict["155624089"]!)").bold().foregroundColor(.primaryFontColor)
                    Spacer()
                    ProgressBar(value: Double(item.stats!.stats!["155624089"]!.value!))
                    Text("\(item.stats!.stats!["155624089"]!.value!)").frame(width: 30, alignment: .leading).foregroundColor(.primaryFontColor)
                }
            }
            
            // Handling:
            if item.stats?.stats?["943549884"]?.value != nil {
                HStack(alignment: .center) {
                    Text("\(weaponStatDict["943549884"]!)").bold().foregroundColor(.primaryFontColor)
                    Spacer()
                    ProgressBar(value: Double(item.stats!.stats!["943549884"]!.value!))
                    Text("\(item.stats!.stats!["943549884"]!.value!)").frame(width: 30, alignment: .leading).foregroundColor(.primaryFontColor)
                }
            }
            
            // Reload Speed
            if item.stats?.stats?["4188031367"]?.value != nil {
                HStack(alignment: .center) {
                    Text("\(weaponStatDict["4188031367"]!)").bold().foregroundColor(.primaryFontColor)
                    Spacer()
                    ProgressBar(value: Double(item.stats!.stats!["4188031367"]!.value!))
                    Text("\(item.stats!.stats!["4188031367"]!.value!)").frame(width: 30, alignment: .leading).foregroundColor(.primaryFontColor)
                }
            }
            
            // Charge Time
            if item.stats?.stats?["2961396640"]?.value != nil {
                HStack(alignment: .center) {
                    Text("\(weaponStatDict["2961396640"]!): ").bold().foregroundColor(.primaryFontColor)
                    Text("\(item.stats!.stats!["2961396640"]!.value!)").frame(width: 30, alignment: .leading).foregroundColor(.primaryFontColor)
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
            }
            
            // Magazine
            if item.stats?.stats?["3871231066"]?.value != nil {
                HStack(alignment: .center) {
                    Text("\(weaponStatDict["3871231066"]!): ").bold().foregroundColor(.primaryFontColor)
                    Text("\(item.stats!.stats!["3871231066"]!.value!)").frame(width: 30, alignment: .leading).foregroundColor(.primaryFontColor)
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
            }
        
    }.font(.system(.subheadline))
    }
}

struct WeaponStatsView_Previews: PreviewProvider {
    static var previews: some View {
        WeaponStatsView(item: items[8])
    }
}
