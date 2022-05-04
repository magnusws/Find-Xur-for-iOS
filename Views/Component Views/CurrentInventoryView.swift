import SwiftUI

struct CurrentInventoryView: View {
    @ObservedObject var xurVM: XurViewModel
    
    var body: some View {
        return ForEach(xurVM.inventoryItems(), id: \.id) { item in
                    NavigationLink(
                        destination: ItemDetail(item: item)
                            .navigationBarBackButtonHidden(true)
                            .statusBar(hidden: true)
                    ){
                        InventoryItemRow(item: item)
                    }
                }.id(UUID())
    }
}

struct CurrentInventoryView_Previews: PreviewProvider {
    static var previews: some View {
        let xurPreviewVM = XurViewModel(testData: true)
        return CurrentInventoryView(xurVM: xurPreviewVM)
    }
}
