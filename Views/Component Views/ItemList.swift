import SwiftUI

struct ItemList: View {
    
    var body: some View {
        
        NavigationView {
            
            List(items) { inventoryItem in
                        NavigationLink(destination: ItemDetail(inventoryItem: inventoryItem)) {
                            ItemRow(item: inventoryItem)
                        }
            }.navigationBarTitle(Text("Possible Exotics"))
            
            }
        
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
            ItemList()
    }
}
