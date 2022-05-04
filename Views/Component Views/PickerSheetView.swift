import SwiftUI

struct PickerSheetView: View {
    @ObservedObject var xurVM : XurViewModel
    @Binding var showMap: Bool
    @Binding  var currentHeight: CGFloat
    @Binding var movingOffset: CGFloat
    @State var selected: Int
    
    var body: some View {
        SheetView(showSheet: showMap, currentHeight: self.$currentHeight, movingOffset: self.$movingOffset, smallHeight: 0, onDragEnd: { position in
            // Do things on drag End
        }) {
            ZStack(alignment: .top) {
                PickerContentView(xurVM: self.xurVM, movingOffset: self.$currentHeight, selected: self.$selected)
            }
            .background(Color.mainBG.opacity(1))
            // .clipped()
            //.shadow(color: Color.gray.opacity(0.2), radius: 6, x: 0.0, y: -5)
        }.padding(.top, 80)
    }
}
