import SwiftUI

struct CountdownWidgetView: View {
    @ObservedObject var xurVM : XurViewModel
    @State var timeLeft: Int
    
    var body: some View {
        Text("Countdown Widget!")
    }
}

struct CountdownWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        let xurPreviewVM = XurViewModel()
        return CountdownWidgetView(xurVM: xurPreviewVM, timeLeft: 300)
    }
}
