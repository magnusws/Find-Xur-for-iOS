import SwiftUI

let gearStatDict: Dictionary<String, String> = ["2996146975": "Mobility", "392767087": "Resilience", "1943323491": "Recovery", "1735777505": "Discipline", "144602215": "Intellect", "4244567218": "Strength"]

struct GearStatView: View {
    let item: InventoryItem
    
    var body: some View {
        let stats = item.stats?.stats!
        let mobVal = stats?["2996146975"]?.value ?? 0
        let resVal = stats?["392767087"]?.value ?? 0
        let recVal = stats?["1943323491"]?.value ?? 0
        let dicVal = stats?["1735777505"]?.value ?? 0
        let intVal = stats?["144602215"]?.value ?? 0
        let strVal = stats?["4244567218"]?.value ?? 0
        
        let totalStatValue = mobVal + resVal + recVal + dicVal + intVal + strVal

        return VStack(alignment: .leading) {
            GearStat(statHash: "2996146975", value: mobVal)
            GearStat(statHash: "392767087", value: resVal)
            GearStat(statHash: "1943323491", value: recVal)
            GearStat(statHash: "1735777505", value: dicVal)
            GearStat(statHash: "144602215", value: intVal)
            GearStat(statHash: "4244567218", value: strVal)
            
            HStack(alignment: .center) {
                Text("Total:").bold().foregroundColor(.primaryFontColor)
                Text("\(totalStatValue)").frame(width: 30, alignment: .leading).foregroundColor(.primaryFontColor)
            }
            
        }.font(.system(.subheadline))
    }
}

struct GearStatView_Previews: PreviewProvider {
    static var previews: some View {
        GearStatView(item: items[1])
    }
}
