//
//  ContentView.swift
//  XurFinder
//
//  Created by Magnus W. Solbakken on 08/12/2020.
//  Copyright © 2020 Magnus W. Solbakken. All rights reserved.
//

import SwiftUI
import UIKit
import Foundation

// let inventory = getInventory()

// MARK: - ContentView


struct InventoryView: View {
    @ObservedObject var xurVM: XurViewModel
    
        var body: some View {
            
            ZStack {
                
                NavigationView {
                    
// XUR IS HERE
                    
                    if  xurVM.xur.isHere == "1" {
                        
                        List{
                            Section {
                                ExoticEngramView()
                            }
                            Section {
                                CurrentInventoryView(xurVM: xurVM)
                            }
                        }
                        .id(UUID())
                        .listStyle(GroupedListStyle())
                        .navigationBarTitle("Inventory")
                    
// XUR IS GONE
                        
                    } else {
                        
                        VStack() {
                                ZStack {
                                    
                                    // map image: scrollable
                                    Image("mapDefault")
                                            .resizable()
                                            .scaledToFill()
                                            .scaleEffect(3)
                                        .position(x: screenSize.width + 10, y: -160)
                                            .frame(width: screenSize.width, height: 30, alignment: .topLeading)
                                            .edgesIgnoringSafeArea(.all)
                                            .foregroundColor(Color.exoticYellow)
                                    
                                    VStack(spacing: 20) {
                                        
                                        Spacer()
                                        
                                        // Divider()
                                        Text("Xur is currently not in our galaxy").font(.body).foregroundColor(Color.primaryFontColor).bold()
                                        Text("Xur will arrive again this friday after reset selling you some precious exotic loot.")
                                            .font(.footnote)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(3)
                                            .frame(width: screenSize.width * 0.8 )
                                            .foregroundColor(Color.primaryFontColor)
                                        
                                    }
                                    .padding(.vertical, 50)
                                    .navigationBarTitle("Inventory")
                                }
                        }
                        .edgesIgnoringSafeArea(.top)
                    }
                }
                
            }
    }
            
    
    func isXurHere()-> Bool{
        return Bool(xurVM.xur.isHere! == "1")
    }
        
}
    
    struct InventoryView_Previews: PreviewProvider {
        static var previews: some View {
            let xurPreviewVM = XurViewModel(testData: true)
            return ForEach(["iPhone SE", "iPhone XS"], id: \.self) { deviceName in
                InventoryView(xurVM: xurPreviewVM)
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
                    .preferredColorScheme(.dark)
            }
        }
    }

// MARK: - Test Data

// MARK: Item Data functions

// MARK: BungieManifest Update Data
