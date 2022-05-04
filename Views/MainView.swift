//
//  MainView.swift
//  Find Xur
//
//  Created by Magnus W. Solbakken on 30/12/2020.
//  Copyright © 2020 Magnus W. Solbakken. All rights reserved.
//

import SwiftUI

let screenSize = UIScreen.main.bounds

struct MainView: View {
    
    // Observed, Environment and State variables
    @ObservedObject var xurVM = XurViewModel()
    @State var selectedView = 0
    @State var now = Date()

    let defaults = UserDefaults.standard
    let formatter = DateFormatter()
    
    // Main View: body
    var body: some View {
        
        return ZStack {
            // Main tabView
            
            TabView(selection: $selectedView) {
                ZStack {
                    // Location View tab
                    LocationView(xurVM: xurVM)
                    .onAppear() {
                        xurVM.fetch()
                    }
                    
                }
                .tabItem() {
                    Image("locationIconFill")
                    Text("Location")
                }.tag(0)
                
                InventoryView(xurVM: xurVM)         // Inventory View Tab
                .onAppear() {
                    xurVM.fetch()
                }
                .tabItem {
                    Image("ixIconHeavy")
                    Text("Inventory")
                }.tag(1)
                
                SegmentedControlNavBarDemoView()   // Exotics View Tab
                .tabItem {
                    Image("engramIconFill")
                    Text("Exotics")
                }.tag(2)
            }
            .accentColor(Color.primaryFontColor)

        }
            
    }
    
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let xurPreviewVM = XurViewModel(testData: true)
        // xurPreviewVM.fetch()
        
        return ForEach(["iPhone SE", "iPhone XS", "iPhone XR"], id: \.self) { deviceName in

            MainView(xurVM: xurPreviewVM, selectedView: 0)
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
                .preferredColorScheme(.dark)
        }
    }
}
