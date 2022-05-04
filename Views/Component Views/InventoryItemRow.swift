import SwiftUI

struct InventoryItemRow: View {
    
    var item: InventoryItem
    
  var body: some View {
      
      VStack() {
        
        HStack(alignment: .center) {

            displayIcon(hash: item.hash!, name: getImageName(image: item.displayProperties!.icon!)).padding(4)
            
            VStack(alignment: .leading) {
                displayItemName(title: item.displayProperties!.name!)
                
                HStack() { 
                    displaySubHeadline(subHeadline: item.itemTypeAndTierDisplayName!)
                    //Spacer()
                    
                    // displaySubHeadline(subHeadline: getItemClassType(type: inventoryItem.classType!))
                }
            }
        Spacer()
            // For alle items i inventory bortsett fra FOS
            if (item.displayProperties!.name! != "Five of Swords" ) {
                        HStack {
                            // Legendary Shard icon
                            Image("ls").resizable().frame(width: 24.0, height: 24.0)
                            // Hvis item er ett vaapen: pris 29
                            if(item.classType == 3) {
                                Text("29").font(.system(size: 14, weight: .regular))
                            // Ellers: pris 23
                            } else {
                                Text("23").font(.system(size: 14, weight: .regular))
                            }
                        }.padding()
            }
        }
        
      }
      
    }
}

struct InventoryItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InventoryItemRow(item: items[0])
            InventoryItemRow(item: items[49])
            InventoryItemRow(item: items[56])
        }
        .previewLayout(.fixed(width:360, height: 70))
    }
}

// MARK: Template: Item card

// Display icon

func displayIcon(hash: Int, name: String)-> some View {
    // Format for alle ikoner bortsett fra engram
    if(hash != 3875551374) {
        return Image("\(name)").resizable()
            .frame(width: 60.0, height: 60.0)
            .cornerRadius(0)
            .overlay(RoundedRectangle(cornerRadius: 0).stroke(Color.white, lineWidth: 2))
            .shadow(color: Color(UIColor(displayP3Red: 0.000, green: 0.000, blue: 0.000, alpha: 0.260)) ,radius: 5)
    } else {
        // Engram har ingen hvit ramme
        return Image("\(name)").resizable()
            .frame(width: 78.0, height: 78.0)
            .cornerRadius(0)
            .overlay(RoundedRectangle(cornerRadius: 0).stroke(Color.white, lineWidth: 0))
            .shadow(color: Color(UIColor(displayP3Red: 0.000, green: 0.000, blue: 0.000, alpha: 0.260)) ,radius: 5)
    }
}
// Display name
