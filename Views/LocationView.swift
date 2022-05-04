//
//  ContentView.swift
//  XurFinder
//
//  Created by Magnus W. Solbakken on 08/12/2020.
//  Copyright © 2020 Magnus W. Solbakken. All rights reserved.

import SwiftUI

// MARK: - ContentView

struct LocationView: View {
    @ObservedObject var xurVM : XurViewModel
    
    @State private var showMap: Bool = false
    @State private var angle: Double = 0
    @State private var currentHeight: CGFloat = 0.0
    @State private var movingOffset: CGFloat = 0.0
    
    
    let calendarCurrentSession = Calendar.current
    
    var animation: Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(2)
            .delay(30)
    }
     
     var springSheet: Animation {
         Animation.interactiveSpring(dampingFraction: 0.8)
             .speed(0.4)
             .delay(0.003 * Double(1))
     }
    
        var body: some View {
            
            ZStack {
                
                locationViewBg().edgesIgnoringSafeArea(.top)
                
                VStack {
                if xurVM.xur.id! != "0" {
                    if xurVM.xur.isHere! == "1" {
                        PlanetView(xurVM: xurVM).edgesIgnoringSafeArea(.vertical)
                    } else {
                        PlanetView(xurVM: xurVM).edgesIgnoringSafeArea(.vertical)
                    }
                }
                }
                
                
                VStack(alignment: .center) {
                    
                    HStack {
                        VStack {
                        VStack(alignment: .leading) {
                            Text("LOCATION").tracking(4).foregroundColor(.primary).bold()
                            locationName(locationId: Int(xurVM.xur.locationID!)!).foregroundColor(.primary)
                        }
                        .lineLimit(6)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: false)
                        .frame(width: screenSize.width * 0.9, height: screenSize.height * 0.3, alignment: .topLeading)
                        Spacer()
                        }
                    }.padding(EdgeInsets(top: 40, leading: 16, bottom: 26, trailing: 16))
                    
                    
                }
                
                
                if xurVM.xur.isHere != nil {
                    
                    if xurVM.xur.isHere! == "1" {
                        VStack {
                            Spacer()
                            Button(action: {
                                self.showMap = true
                            })  {
                                Text("SHOW MAP").tracking(2).foregroundColor(Color.white)
                            }.buttonStyle(MapButtonStyle()).padding(.vertical, 22)
                        }
                        
                    }
                        
                    if xurVM.xur.isHere! == "0" && xurVM.xur.locationID! == "10" {
                            CountdownView(xurVM: xurVM)
                    }
                    
                }
                
            }
            // .background(Color.mainBG.edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $showMap) {
                if self.xurVM.xur.isHere != nil {
                    if self.xurVM.xur.isHere! == "1" && self.xurVM.xur.locationID! != "10" {
                        MapView(xurVM: self.xurVM)
                    }
                }
            }
    }
    
    func locationViewBg()-> some View {
        
        if xurVM.xur.isHere! == "1" {
            return Image("galaxyBG")
                .resizable()

        } else {
            return Image("locationBG08")
                .resizable()
        }
        
    }
     
    func locationViewBgGone()-> some View {
            return Image("galaxy")
                .resizable().scaleEffect(1).edgesIgnoringSafeArea(.all)
    }
}

struct LocationView_Previews: PreviewProvider{
    static var previews: some View {
        let xurPreviewVM = XurViewModel(testData: true)
        return LocationView(xurVM: xurPreviewVM)
        }
}



// MARK: - Test Data


// MARK: - LocationView Functions

// MARK: Location

private func locationName(locationId: Int) -> Text{
    
    switch locationId {
    case 1:
        return Text(("\(locationDict[locationId]! )").uppercased()).font(
        .system(size: 48, weight: .heavy))
    case 2:
        return Text(("\(locationDict[locationId]! )").uppercased()).font(
        .system(size: 78, weight: .heavy))
        .tracking(4)
    case 3:
        return Text(("\(locationDict[locationId]! )").uppercased()).font(
        .system(size: 88, weight: .heavy))
        .tracking(4)
    case 4:
        return Text(("\(locationDict[locationId]! )").uppercased()).font(
                .system(size: 78, weight: .heavy))
                .tracking(6)
    case 5:
        return Text(("\(locationDict[locationId]! )").uppercased()).font(
                .system(size: 58, weight: .heavy))
    case 0:
        return Text(("\(locationDict[locationId]! )").uppercased()).font(
                .system(size: 48, weight: .heavy))
    case 10:
        return Text(("\(locationDict[locationId]! )").uppercased()).font(
                .system(size: 38, weight: .heavy))
    default:
        return Text(("\(locationDict[locationId]! )").uppercased()).font(
                .system(size: 34, weight: .heavy))
    }
    
}
