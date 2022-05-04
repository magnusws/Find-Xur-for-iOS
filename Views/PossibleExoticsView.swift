//
//  PossibleExoticsView.swift
//  XurFinder
//
//  Created by Magnus W. Solbakken on 23/12/2020.
//  Copyright © 2020 Magnus W. Solbakken. All rights reserved.
//

import SwiftUI

struct PossibleExoticsView: View {
    let typeHeaderDict = [0: "All", 1: "WEAPONS", 2: "TITAN", 3: "HUNTER", 4: "WARLOCK"]
    @ObservedObject var xurVM : XurViewModel
    @State var showTypes: Dictionary<Int,Bool> = [1: true, 2: true, 3: true, 4: true]
    @State var selectedTypeDict: Dictionary = [1: weaponExotics, 2:  titanExotics, 3: hunterExotics, 4: warlockExotcs]
       
    var sections = ["first", "second", "third"]
       
    let screenWidth = screenSize.width
    let navBarColor = Color.black
       
    
    var body: some View {
        return ZStack {
            NavigationView {
                List{
                    ForEach (0..<5) { count in
                        if self.showTypes[count] == true {
                            Section(header: Text(self.typeHeaderDict[count]!)
                                .font(.system(.headline))
                                .tracking(4).bold().foregroundColor(Color.white)
                                .padding(.vertical, 4))
                            {
                                ForEach(self.selectedTypeDict[count]!, id: \.id) { item in
                                    NavigationLink(
                                        destination: ItemDetail(item: item)
                                            .statusBar(hidden: true)
                                            .navigationBarBackButtonHidden(true)
                                        ){
                                        ItemRow(item: item)
                                    }
                                }.id(UUID())
                                .statusBar(hidden: true)
                            }
                            }
                        }
                    }
                .navigationBarTitle("Possible Exotics")
            }
        }
    }
}

struct ListHeaderView: View {
    var headerText: String
    var body: some View {
        ZStack {
            Color.exoticYellow.frame(width: screenSize.width, alignment: .center).opacity(0.8)
            HStack{
                Text("\(headerText)").font(.system(.headline)).padding(.horizontal).foregroundColor(.white)
                Spacer()
            }
        }
    }
}

struct PossibleExoticsView_Previews: PreviewProvider {
    static var previews: some View {
        let xurPreviewVM = XurViewModel(testData: true)
        return ForEach(["iPhone 11"], id: \.self) { deviceName in
            PossibleExoticsView(xurVM: xurPreviewVM)
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
                .preferredColorScheme(.dark)
        }
    }
}

/*
 


 
 */


/*
 
 .navigationBarTitle("Possible Exotics")
 .navigationBarItems(trailing:
     Button("Filter") {
         if self.showPicker == true {
             self.showPicker = false
         } else {
             self.showPicker = true
         }
     }.foregroundColor(Color.exoticYellow)
 )
 .actionSheet(isPresented: $showPicker) {
     ActionSheet(
         title: Text("Filter Exotics").font(.system(.title)),
         message: Text("What item type do you want to display?"),
         buttons: [
             .default(Text("Show All"), action: {
                 print("Displaying All")
                 self.selectedType = 0
             }),
             .default(Text("Titan Exotics"), action: {
                print("Displaying Titan Exotics")
                 self.selectedType = 1
             }),
             .default(Text("Hunter Exotics"), action: {
                print("Displaying Hunter Exotics")
                 self.selectedType = 2
             }),
             .default(Text("Warlock Exotics"), action: {
                print("Displaying Warlock Exotics")
                 self.selectedType = 3
             }),
             .default(Text("Exotic Weapons"), action: {
                print("Displaying Exotic Weapons")
                 self.selectedType = 4
             }),
             .cancel(Text("Cancel"))
     ])
 }
 
 */
