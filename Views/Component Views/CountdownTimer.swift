import SwiftUI

struct CountdownTimer: View {
    @ObservedObject var xurVM : XurViewModel
    @ObservedObject var timeLeft = dhms(seconds: 3600)
    // @State var timer = Timer()
    
    // var for d : h : m : s in countdown
    class dhms: ObservableObject{
        @Published var days: Int
        @Published var hours: Int
        @Published var minutes: Int
        @Published var seconds: Int
        
        init(seconds: Int) {
            self.days = seconds / (1000 * 60 * 60 * 24)
            self.hours = (seconds % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)
            self.minutes = (seconds % (1000 * 60 * 60)) / (1000 * 60)
            self.seconds = (seconds % (1000 * 60)) / 1000
        }
        
        func dhmsFromSec(seconds: Int) {
            print("            seconds: \(seconds)")
            self.days = (seconds / (1000 * 60 * 60 * 24))
            self.hours = ((seconds % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))
            self.minutes = ((seconds % (1000 * 60 * 60)) / (1000 * 60))
            self.seconds = ((seconds % (1000 * 60)) / 1000)
            print("D: ",self.days, "H: ", self.hours, "M: ", self.minutes, "S: ", self.seconds)
        }
    }
    
    var body: some View {
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        return VStack(alignment: .center){
            
            if xurVM.xur.isHere! == "0" {
                Text("XÛR WILL ARRIVE IN").font(.system(size: 18, weight: .light)).bold().tracking(4).padding(.top, 0).padding(.bottom, 2)
            } else {
                Text("XUR WILL LEAVE IN").font(.system(.headline)).bold().tracking(0).padding(.top, 0).padding(.bottom, 2)
            }
            
            HStack(alignment: .top) {
                VStack {
                    Text("\(self.timeLeft.days)").font(.system(size: 36)).bold()
                    Text("DAYS").font(.system(size: 10)).tracking(2)
                }
                Text(":").font(.system(size: 32)).padding(.horizontal, -2)
                VStack {
                    Text("\(self.timeLeft.hours)").font(.system(size: 36)).bold()
                    Text("HOURS").font(.system(size: 10)).tracking(2)
                }
                Text(":").font(.system(size: 32)).padding(.horizontal, -2)
                VStack {
                    Text("\(self.timeLeft.minutes)").font(.system(size:36)).bold()
                    Text("MINUTES").font(.system(size: 10)).tracking(2)
                }
                Text(":").font(.system(size: 32)).padding(.horizontal, -2)
                VStack {
                    Text("\(self.timeLeft.seconds)").font(.system(size: 36)).bold()
                    Text("SECONDS").font(.system(size: 10)).tracking(2)
                }
            }
            
        }
        .onReceive(timer) { time in
            if self.xurVM.secondsUntilNext < 0 {
              // timer.upstream.connect().cancel()
            }
            
            self.timeLeft.dhmsFromSec(seconds: Int(self.xurVM.secondsUntilNext))
            print("Timer: \(self.xurVM.secondsUntilNext)")
        }
        .onAppear() {
            self.xurVM.updateSecondsUntilNext()
            // print("\(self.xurVM.secondsUntilNext)")
        }

    }
    func updateCount()-> some View {
        return HStack(alignment: .top) {
            VStack {
                Text("\(self.timeLeft.days)").font(.system(size: 36)).bold()
                Text("DAYS").font(.system(size: 10)).tracking(2)
            }
            Text(":").font(.system(size: 32)).padding(.horizontal, -2)
            VStack {
                Text("\(self.timeLeft.hours)").font(.system(size: 36)).bold()
                Text("HOURS").font(.system(size: 10)).tracking(2)
            }
            Text(":").font(.system(size: 32)).padding(.horizontal, -2)
            VStack {
                Text("\(self.timeLeft.minutes)").font(.system(size:36)).bold()
                Text("MINUTES").font(.system(size: 10)).tracking(2)
            }
            Text(":").font(.system(size: 32)).padding(.horizontal, -2)
            VStack {
                Text("\(self.timeLeft.seconds)").font(.system(size: 36)).bold()
                Text("SECONDS").font(.system(size: 10)).tracking(2)
            }
        }
    }
}

struct CountdownTimer_Previews: PreviewProvider {
    static var previews: some View {
        let xurPreviewVM = XurViewModel()
        return CountdownTimer(xurVM: xurPreviewVM)
    }
}
