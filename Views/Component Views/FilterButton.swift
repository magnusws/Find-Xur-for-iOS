import SwiftUI
import Foundation

struct FilterButton: View {
    
    @Binding var showFilters: Bool
    
        var body: some View {
            Button(action: { self.showFilters.toggle() }) {
                    Image(systemName: "slider.horizontal.3").resizable()
                    .frame(width: 22.0, height: 16.0)
            }.accentColor(showFilters ? .gray : .xurTab)
        }
}

/*
struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        FilterButton()
    }
}
*/
