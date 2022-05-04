import SwiftUI
import UIKit
import Foundation

struct ItemRow: View {
    
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
        }
        
      }//.background(Color.gray)
      
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ItemRow(item: items[0])
            ItemRow(item: items[44])
            ItemRow(item: items[56])
        }
        .previewLayout(.fixed(width:360, height: 70))
    }
}

// MARK: Template: Item card

// Display name

func displayItemName(title: String)-> Text {
    return Text(title).font(.body).bold().tracking(0.4).foregroundColor(Color.primary)
}

func displaySubHeadline(subHeadline: String)-> Text {
    return Text(subHeadline).font(.subheadline).tracking(0.2).foregroundColor(Color.secondary)
}
