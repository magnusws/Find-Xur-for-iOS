import SwiftUI
import Foundation

struct CountdownView: View {
    @ObservedObject var xurVM : XurViewModel
    
    var body: some View {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US")
        df.dateFormat = "MMMM d yyyy HH:mm:ss ZZZZ"
        df.timeZone = TimeZone(secondsFromGMT: 7200)
        var nextUpdateIso = "December 24 2020 19:00:00 GMT+0200"
        var nextDate = Date()

        
        if self.xurVM.xur.nextUpdate != nil {

            nextUpdateIso = self.xurVM.xur.nextUpdate!
            
            if nextUpdateIso.contains("GMT+02:00") == false {
                       nextUpdateIso.insert(contentsOf: ":", at: nextUpdateIso.index(nextUpdateIso.endIndex, offsetBy: -2))
                   }
                   
                   nextDate = df.date(from: nextUpdateIso)!
                   
                   
                   return VStack(alignment: .center){
                       
                    CountdownContentView(xurVM: xurVM, nextUpdate: nextDate)
                       
                   }
            
        } else {
            return VStack(alignment: .center){
                CountdownContentView(xurVM: XurViewModel(testData: true), nextUpdate: nextDate)
                
            }
        }
        
        

    }

    
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        let xurPreviewVM = XurViewModel(testData: true)
        return CountdownView(xurVM: xurPreviewVM)
    }
}



