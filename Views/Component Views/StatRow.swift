import SwiftUI

struct StatRow: View {
    var stat: Stat
    
    var body: some View {
        HStack {
            Text("HASH: \(self.stat.statHash!)")
            Spacer()
            Text("VAL: \(self.stat.value!)")
        }
    }
}

/*

struct StatRow_Previews: PreviewProvider {
    static var previews: some View {
        StatRow(stat: stat)
    }
}
 
*/
