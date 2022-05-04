//
//  PossibleExoticsViewSegmented.swift
//  Find Xur
//
//  Created by Magnus W. Solbakken on 23/05/2021.
//  Copyright © 2021 Magnus W. Solbakken. All rights reserved.
//

import SwiftUI
import UIKit

struct SegmentedControlNavBarDemoView: View {
    @State private var sectionIndex = 0
    var selectedTypeDict: Dictionary = [0: weaponExotics, 1:  titanExotics, 2: hunterExotics, 3: warlockExotcs]
    
    // Customize NavigationBar colors
    let navBarTitleColor = UIColor.white                    // UIColor
    let selectedSegmentColor = UIColor.white           // UIColor
    let selectetSegmentTextColor = UIColor.black            // UIColor
    let normalSegmentTextColor = UIColor.lightGray          // UIColor
    let segmentedControlBg = UIColor(                       // UIColor
        red: 0/255,
        green: 0/255,
        blue: 0/255,
        alpha: 0.1
    )
    let navBarColor = Color(UIColor(                       // UIColor
        red: 5/255,
        green: 5/255,
        blue: 5/255,
        alpha: 0.9
    ))
    
    // Section labels
    var sections = ["Weapons", "Titan", "Hunter", "Warlock"]
    
    let screenWidth = screenSize.width
    
    init() {
        // NavBar apperance
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor : navBarTitleColor]
        appearance.shadowColor = .clear
        appearance.backgroundEffect = .none
        appearance.backgroundColor = UIColor.clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        // SegmentedControl apperance
        let controlApperance = UISegmentedControl.appearance()
        controlApperance.selectedSegmentTintColor = selectedSegmentColor
        controlApperance.setTitleTextAttributes([.foregroundColor: selectetSegmentTextColor], for: .selected)
        controlApperance.setTitleTextAttributes([.foregroundColor: normalSegmentTextColor], for: .normal)
        controlApperance.backgroundColor = segmentedControlBg
        
        // Hide scroll indicator
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
    var body: some View {
        // Navigation View
        NavigationView {
            ZStack {
                // Content View
                    VStack {
                        ItemListView(items: selectedTypeDict[self.sectionIndex]!)
                    }
                    
                // Navigation Bar
                    .navigationBarTitle("Possible Exotics", displayMode: .inline)
                
                // Segmented picker
                Group {
                    ZStack {
                        
                        VStack {
                            VisualEffectView(effect: UIBlurEffect(style: .prominent))
                                .frame(width: screenWidth, height: 138)
                            Spacer()
                        }
                            .edgesIgnoringSafeArea(.all)
                        
                        VStack {
                            ZStack {
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(width: screenWidth, height: 40)
                                
                                Section {
                                    Picker(
                                        selection: $sectionIndex,
                                        label: Text("Sections")
                                    ) {
                                        ForEach(0 ..< sections.count) {
                                            Text(self.sections[$0])
                                        }
                                    }
                                        .pickerStyle(SegmentedPickerStyle())
                                }.padding(.horizontal, 10)
                            }
                            Spacer()
                        }
                        
                    }
                }

            }
        }
    }
}



struct SegmentedControlNavBarDemoView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControlNavBarDemoView()
    }
}

struct ItemListView: View {
    var items: [InventoryItem]

    var body: some View {
        List{
            VStack {
                Spacer(minLength: 40)
            }
           ForEach(items, id: \.id) { item in
              NavigationLink(
                 destination: ItemDetail(item: item)
                    .statusBar(hidden: true)
                    .navigationBarBackButtonHidden(true)
              ){
                    ItemRow(item: item)
                }
            }
                .statusBar(hidden: true)
            }.id(UUID())
    }
}
