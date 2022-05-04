import SwiftUI

struct WeaponPerk: View {
    var perk: InventoryItem
    
    var body: some View {
        HStack(alignment: .top) {
            if perk.hash != nil {
                Image("\(perk.hash!)")
                    .resizable()
                    .clipShape(Circle())
                    .clipped()
                    .frame(width: 50, height: 50, alignment: .center)
            }
            VStack(alignment: .leading) {
                Text(perk.displayProperties!.name!)
                    .font(.system(.headline))
                Text(perk.displayProperties?.displayPropertiesDescription ?? "")
                    .font(.system(.footnote))
                    .foregroundColor(.secondary)
                    .truncationMode(.tail)
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
        .lineLimit(10)
        .multilineTextAlignment(.leading)
       
    }
}


struct WeaponPerk_Previews: PreviewProvider {
    static var previews: some View {
        WeaponPerk(perk: itemPerks[3])
    }
}
