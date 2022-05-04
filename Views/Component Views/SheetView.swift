import SwiftUI

enum Position {
    case up
    case down
}

struct SheetView<Content>: View where Content: View {
    @State var showSheet: Bool
    @Binding var currentHeight: CGFloat
    @Binding var movingOffset: CGFloat
    
    var position = Position.up
    var smallHeight: CGFloat = 50
    var onDragEnd: ((_ position: Position)->()) = {_ in }
    
    var content: () -> Content
    
    var body: some View {
        
        Group(content: self.content)
            .frame(minHeight: 0.0, maxHeight: .infinity, alignment: .bottom)
                    .offset(y: self.movingOffset)
                    .gesture(
                    DragGesture().onChanged({ drag in
                        if self.movingOffset >= 0{
                            self.movingOffset =  drag.translation.height  + self.currentHeight
                        }
                    }).onEnded({ drag in
                        withAnimation( .spring(dampingFraction: 0.7) ) {
                            if  self.movingOffset > -80 {
                                self.movingOffset = 0.0
                                self.onDragEnd(.up)
                            }
                            
                            if drag.translation.height > 80 {
                                self.movingOffset =  self.smallHeight
                                self.showSheet = false
                                self.onDragEnd(.down)
                            }
                            self.currentHeight = self.movingOffset
                        }
                    })
            )
        
    }
}
/*
struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(showMap: true, currentHeight: .constant(0.0), movingOffset: .constant(0.0)) {
            Rectangle().foregroundColor(Color.red).frame(height: 500)
        }
    }
}
*/
