import SwiftUI

let weaponSocketTypeHash =  3956125808

struct PerksView: View {
    var item: InventoryItem
    var body: some View {
        let intrinsicPerk = getIntrinsicPerk(item: item)
        let perks = getWeaponPerks(item: item)
        return VStack {
            if intrinsicPerk != nil {
                WeaponPerk(perk: intrinsicPerk!)
            }
            ForEach(perks, id: \.hash) { perk in
                WeaponPerk(perk: perk)
            }
        }
            .padding(.vertical)
            .background(Color.mapBgColor)
        
    }
}

struct PerksView_Previews: PreviewProvider {
    static var previews: some View {
        PerksView(item: exotics[88])
            .preferredColorScheme(.dark)
    }
}

func getIntrinsicPerk(item: InventoryItem)-> InventoryItem? {
    for entry in (item.sockets?.socketEntries)! {
        for perk in itemPerks {
            if entry.singleInitialItemHash == perk.hash && entry.defaultVisible == true && entry.socketTypeHash == weaponSocketTypeHash{
                return perk
            }
        }
    }
    return nil
}

func getWeaponPerks(item: InventoryItem)-> Array<InventoryItem> {
    var perks: Array<InventoryItem> = []
    for entry in (item.sockets?.socketEntries)! {
        for perk in itemPerks {
            if entry.singleInitialItemHash == perk.hash && entry.defaultVisible == true && entry.socketTypeHash != weaponSocketTypeHash{
                perks.append(perk)
            }
        }
    }
    return perks
}
