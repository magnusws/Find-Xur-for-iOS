import SwiftUI

let deviceScreenSize = UIScreen.main.bounds

struct LoadingSpinner: View {
    @State var loading: Bool
    var text: String?
    
    let posY = deviceScreenSize.height/2
    let posX = deviceScreenSize.width/2
    
    // spinner animation
    var spinner: Animation {
        Animation.linear.repeatForever(autoreverses: false).speed(0.2)
    }
    
    var animateInOut: Animation {
        Animation.easeInOut(duration: 0.5)
    }
    
    var fadeBackground: Animation {
        Animation.linear(duration: 0.5)
    }
    
    var body: some View {
        ZStack{
                // blur effect
                VisualEffectView(effect: UIBlurEffect(style: .dark))
                    .edgesIgnoringSafeArea(.top)
                    .opacity(loading ? 1 : 0)
                    .animation(fadeBackground)
                
                // background color
                Color.black
                    .edgesIgnoringSafeArea(.top)
                    .opacity(loading ? 0.4 : 0)
                    .animation(fadeBackground)
            
            // spinner and text
            VStack(alignment: .center) {
                
                // spinner image
                Image(systemName: "arrow.2.circlepath.circle.fill")
                    .resizable()
                    .frame(width: 34, height: 34)
                    .rotationEffect(.degrees(loading ? 359 : 0))
                    .animation(self.spinner)
                    .onAppear() {
                        self.loading.toggle()
                    }
                
                // text (optional)
                text == nil ? nil : Text(text!.uppercased())
                    .font(.system(size: 10))
                    .tracking(1)
            }
        }
    }
}
