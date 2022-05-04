import SwiftUI
import Foundation

struct CountdownContentView: View {
    @ObservedObject var xurVM : XurViewModel
    @State var nextUpdate: Date
    @ObservedObject var timeLeft = dhms()
    @State var loading: Bool = false
    
    // var for d : h : m : s in countdown
    class dhms: ObservableObject{
        @Published var days: Int = 0
        @Published var hours: Int = 0
        @Published var minutes: Int = 0
        @Published var seconds: Int = 0
    }
    
    var body: some View {

        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second, .month, .year, .day], from: now as Date)
        let currentDate = calendar.date(from: components)
        let updateDate = calendar.dateComponents([.hour, .minute, .second, .month, .year, .day], from: self.nextUpdate as Date)
        let userCalendar = Calendar.current
        let completionDate =  userCalendar.date(from: updateDate as DateComponents)!
        let difference = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate!, to: completionDate)
        
        // Timer publisher that publish every 1 second
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        return ZStack {
            
            Color.almostBlack
                .opacity(0.86)
                .fixedSize(horizontal: false, vertical: false)
                .frame(width: screenSize.width * 0.86, height: 140, alignment: .center)
                .cornerRadius(20)
            
            // Klokke vises så lenge den ikke har telt ned til 0
            
            VStack(alignment: .center){
                    
                    if xurVM.xur.isHere! == "0" {
                        Text("XÛR WILL ARRIVE IN").font(.system(size: 18, weight: .light)).bold().tracking(4).padding(.top, 0).padding(.bottom, 2)
                    } else {
                        Text("XUR WILL LEAVE IN").font(.system(.headline)).bold().tracking(0).padding(.top, 0).padding(.bottom, 2)
                    }
                    
                    HStack(alignment: .top) {
                        VStack {
                            Text(formatTime(nr: self.timeLeft.days)).font(.system(size: 36)).bold()
                            Text("DAYS").font(.system(size: 10)).tracking(2)
                        }
                        Text(":").font(.system(size: 32)).padding(.horizontal, -2)
                        VStack {
                            Text(formatTime(nr: self.timeLeft.hours)).font(.system(size: 36)).bold()
                            Text("HOURS").font(.system(size: 10)).tracking(2)
                        }
                        Text(":").font(.system(size: 32)).padding(.horizontal, -2)
                        VStack {
                            Text(formatTime(nr: self.timeLeft.minutes)).font(.system(size:36)).bold()
                            Text("MINUTES").font(.system(size: 10)).tracking(2)
                        }
                        Text(":").font(.system(size: 32)).padding(.horizontal, -2)
                        VStack {
                            Text(formatTime(nr: self.timeLeft.seconds)).font(.system(size: 36)).bold()
                            Text("SECONDS").font(.system(size: 10)).tracking(2)
                        }
                        
                    }
                    
                }.foregroundColor(Color.white)
            if (timeLeft.days == 0 && timeLeft.hours == 0 && timeLeft.minutes == 0 && timeLeft.seconds == 0) {
                LoadingSpinner(loading: loading, text: "Updating")
            }
            
        }
        .onReceive(timer) { _ in
             //here we set the variable to our remaining time
             self.timeLeft.days = difference.day!
             self.timeLeft.hours = difference.hour!
             self.timeLeft.minutes = difference.minute!
             self.timeLeft.seconds = difference.second!
        }
        .onAppear() {
            // Oppdaterer timeleft en ekstra gang nar view blir synlig
            // for aa unnga at klokken viser 00 : 00 : 00 : 00 før den får sin
            // første verdi etter ett sekund.
            // (legger også til ett sekund for å rette opp i at funk blir kalt dobbelt)
            self.timeLeft.days = difference.day!
            self.timeLeft.hours = difference.hour!
            self.timeLeft.minutes = difference.minute!
            self.timeLeft.seconds = difference.second! + 1
        }
    }
}

struct CountdownContentView_Previews: PreviewProvider {
    static var previews: some View {
        let xurPreviewVM = XurViewModel(testData: true)
        let nextUpdate = Date()
        return CountdownContentView(xurVM: xurPreviewVM, nextUpdate: nextUpdate)
    }
}

private func formatTime(nr: Int)-> String {
    var temp = ""
    if nr >= 10 {
        temp = String(nr)
    } else if nr <= 0 {
        temp = String("0\(0)")
    } else {
        temp = String("0\(nr)")
    }
    return temp
}


