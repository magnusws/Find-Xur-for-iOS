import SwiftUI

struct CustomSheetView: View {
    @ObservedObject var xurVM : XurViewModel
    @State var showTypes: Dictionary<Int,Bool>
    @State var showPicker: Bool
    @Binding  var currentHeight: CGFloat
    @Binding var movingOffset: CGFloat
    
    var body: some View {
        SheetView(showSheet: self.showPicker, currentHeight: self.$currentHeight, movingOffset: self.$movingOffset, smallHeight: 0, onDragEnd: { position in
            // Do things on drag End
        }) {
            ZStack(alignment: .top) {
                FilterView(xurVM: self.xurVM, showTypes: self.showTypes, showPicker: self.showPicker)
            }
            .background(Color.mapBgColor.opacity(1))
            //.shadow(color: Color.gray.opacity(0.2), radius: 6, x: 0.0, y: -5)
        }.padding(.top, 80)
    }
}

/*
struct CustomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSheetView(showMap: true, currentHeight: .constant(0.0), movingOffset: .constant(0.0))
    }
}
*/
