import SwiftUI

struct SettingsButton: View {

    let screenSize = UIScreen.main.bounds.size
    var color = "exoticYelllow"
    var text = "No Displayable Data"
    var isSelected = false
    var action: (()->()) = {}
    
    var body: some View {
        let screenWidth = screenSize.width
        
        return Button(action: {
            self.action()
        }) {
            HStack {
                Text(text)
                    .foregroundColor(isSelected ? Color.white : Color.exoticYellow)
                
            }.frame(width: screenWidth * 0.88 )
                .padding(.vertical)
                .background(Color.exoticYellow.opacity(isSelected ? 1 : 0.2))
                .cornerRadius(10)
        }
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton()
    }
}
