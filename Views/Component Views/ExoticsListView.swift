import SwiftUI

struct ExoticsListView: View {
    @ObservedObject var xurVM: XurViewModel
    var selectedItems: [InventoryItem]
    
    var navTitle = "Possible Exotics"
    let exoticTypes = [0, 1, 2, 3, 4]
    let typeDict = [0: "View All", 1: "Titan Exotics", 2: "Hunter Exotics", 3: "Warlock Exotics", 4: "Weapon Exotics"]
    
    var body: some View {
        return ForEach(selectedItems, id: \.id) { item in
                        NavigationLink(
                            destination: ItemDetail(item: item)
                        ){
                            ItemRow(item: item)
                        }
                    }.id(UUID())
        }
}

struct ExoticsListView_Previews: PreviewProvider {
    static var previews: some View {
        let xurPreviewVM = XurViewModel(testData: true)
        return ExoticsListView(xurVM: xurPreviewVM, selectedItems: items)
    }
}
