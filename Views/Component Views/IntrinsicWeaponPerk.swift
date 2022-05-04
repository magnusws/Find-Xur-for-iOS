import SwiftUI

struct IntrinsicWeaponPerk: View {
    var perk: InventoryItem
    
    var body: some View {
        HStack(alignment: .center) {
            Image("default")
                .resizable()
                .clipShape(Circle())
                .clipped()
                .frame(width: 80, height: 80, alignment: .center)
            
            VStack(alignment: .leading) {
                Text(perk.displayProperties!.name!)
                    .font(.system(.headline))
                Text(perk.displayProperties?.displayPropertiesDescription ?? "")
                    .font(.system(.footnote))
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .lineLimit(10)
        .multilineTextAlignment(.leading)
       
    }
}


struct IntrinsicWeaponPerk_Previews: PreviewProvider {
    static var previews: some View {
        IntrinsicWeaponPerk(perk: itemPerks[2])
    }
}
