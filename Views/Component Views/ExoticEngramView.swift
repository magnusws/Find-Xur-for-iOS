import SwiftUI

struct ExoticEngramView: View {
    var iconName = getImageName(image: exoticEngram.displayProperties!.icon!)
    
    var body: some View {
        HStack(alignment: .center) {
                displayIcon(hash: exoticEngram.hash!, name: iconName)
            
            
                VStack(alignment: .leading) {
                    displayItemName(title: exoticEngram.displayProperties!.name!)
                
                    HStack() {
                        displaySubHeadline(subHeadline: exoticEngram.itemTypeAndTierDisplayName!)
                    }
                }
                
                // Exotic Engram Legendary Shard icon and cost
                Image("ls").resizable().frame(width: 24.0, height: 24.0)
                Text("97").font(.system(size: 14, weight: .regular))
                
                Spacer()
                
            }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        }
}

struct ExoticEngramView_Previews: PreviewProvider {
    static var previews: some View {
        ExoticEngramView()
    }
}
