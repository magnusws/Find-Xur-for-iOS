//
//  ItemDetailView.swift
//  Find Xur
//
//  Created by Magnus W. Solbakken on 22/01/2020.
//  Copyright © 2020 Magnus W. Solbakken. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ItemDetail: View {
    var item: InventoryItem
    @State var viewState = CGSize.zero
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { (value) in
                if value.translation.width > 20{
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
    }
    
    let imageHeight: CGFloat = 300
    
    let armourElementSocketCategoryHash: Int = 760375309
    
    let ammoTypeIconNameDict: Dictionary<Int, String> = [
        1: "primaryAmmoIcon",
        2: "specialAmmoIcon",
        3: "heavyAmmoIcon"
    ]
    
    let damageTypeIconNameDict: Dictionary<Int, String> = [
        1: "kineticDamageTypeIcon",
        2: "arcDamageTypeIcon",
        3: "solarDamageTypeIcon",
        4: "voidDamageTypeIcon"
    ]
    
    let armourDamageTypeDict: Dictionary<Int, Int> = [
        0: 1,
        4248210736: 2,
        2248916764: 3, 
        4197017647: 4
    ]
    
    let damageTypeColorDict: Dictionary<Int, Color> = [
        1: Color.white,
        2: Color.blue,
        3: Color.orange,
        4: Color.purple
    ]
    
    // let ammoIconAnimation = Animation.easeIn(duration: 0.5)
    
    var ammoIconAnimation: Animation {
        Animation.interactiveSpring(dampingFraction: 0.7)
            .speed(1)
    }
    
   // MARK: - Body
    
        var body: some View {
            
            var imageName = ""
            if self.item.screenshot != nil {
                imageName = getImageName(image: self.item.screenshot!)
            } else {
                imageName = "defaultXur"
            }
            
            let screenshot = Image(imageName)
            
            var isWeapon = false
            var ammoType = 0
            var damageType = 0
            var ammoTypeIcon = Image("defaultXur")
            
            // Hvis item er class item
            if item.classType! <= 2 {
                // init var for socket indexer
                var socketIndexes: [Int] = []
                // init var for burn type hash
                var hash = 0
                
                // for kategori i socket kategorier
                for category in (item.sockets?.socketCategories)! {
                    // hvis category hash er lik element socket hash
                    if Int(category.socketCategoryHash!) == armourElementSocketCategoryHash {
                        // henter ut index
                        socketIndexes = category.socketIndexes!
                    }
                }
                // henter ut hash i index som den skal finnes i
                hash = Int(item.sockets!.socketEntries![Int(socketIndexes[0])].singleInitialItemHash!)
                
                // Av en eller annen grunn er noen item sine verdier i index - 1 mens andre i index..
                if armourDamageTypeDict[hash] == nil {
                    hash = Int(item.sockets!.socketEntries![(Int(socketIndexes[0])-1)].singleInitialItemHash!)
                }
                
                // hvis det var en hash i indexen
                if hash != 0 {
                    // damage type får verdi fra dict ved bruk av hash
                    damageType = armourDamageTypeDict[hash] ?? 0
                }
                
            // Hvis item er våpen
            } else {
                isWeapon = true
                ammoType = self.item.equippingBlock?.ammoType ?? 1
                damageType = self.item.defaultDamageType ?? 1
                ammoTypeIcon = Image(self.ammoTypeIconNameDict[ammoType] ?? "primaryAmmoIcon")
            }
            
             let gradientColors = Gradient(colors: [.black, .clear])
           
            
            return ZStack {
                
                Color.grayMidtone
                    .edgesIgnoringSafeArea(.all)
                Color.black
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.5)
                
                ScrollView(showsIndicators: false) {
                
                GeometryReader { geometry in
                    
                    ZStack() {

                        if geometry.frame(in: .global).minY < 0 {
                            screenshot
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                width: geometry.size.width,
                                height: geometry.size.height,
                                alignment: .trailing
                                )
                            .blur(radius: (-geometry.frame(in: .global).minY/60))
                            
                        } else {
                            screenshot
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(
                                    width: geometry.size.width,
                                    height: geometry.size.height + geometry.frame(in: .global).minY,
                                    alignment: .trailing
                                )
                                .clipped()
                                .offset(y: -geometry.frame(in: .global).minY)
                        }

                        // If item is a weapon (not a class item)
                        if isWeapon{
                            VStack{
                                Spacer()
                                HStack{
                                    Spacer()
                                    // Icon
                                    ammoTypeIcon
                                        .padding()
                                        .opacity(geometry.frame(in: .global).minY > CGFloat(20) ? 0 : 1)
                                        .animation(self.ammoIconAnimation)
                                }
                            }
                        }
                    }
                }
                    .frame(height: (isWeapon ? 300 : 320))
                    .statusBar(hidden: true)
                
                VStack(alignment: .leading) {
                    
                    HStack(alignment: .center){
                        
                        // NAME AND TYPE
                        VStack(alignment: .leading) {
                            // Name
                            Text(item.displayProperties!.name!)
                                .font(.title)
                                .bold()
                                .foregroundColor(Color.white)
                            // Item type and tier
                            Text(item.itemTypeAndTierDisplayName!)
                                .font(.subheadline)
                                .foregroundColor(Color.white)
                        }
                        
                        Spacer()
                        
                        // DAMAGE TYPE ICON
                        Image(self.damageTypeIconNameDict[damageType] ?? "default")
                            .frame(width: 42, height: 42, alignment: .center)
                            .scaleEffect(0.26)
                            .background(Color.mapBgColor)
                            .clipShape(Circle())
                            .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 2))
                    
                    }
                    .padding(EdgeInsets(top: 4, leading: 16, bottom: 10, trailing: 10))
                    .background(Color.exoticYellow)
                    
                    VStack(alignment: .leading) {
                    // item description
                        Text("\((item.displayProperties?.displayPropertiesDescription!)!)")
                            .font(.system(.subheadline)).foregroundColor(.secondary)
                            .italic()
                            .lineLimit(8)
                            .multilineTextAlignment(.leading)
                            .padding()
                    }
                    .frame(width: screenSize.width, alignment: .center)
                    .fixedSize()
                    .background(Color.clear)
                    .padding(.top, -11)
                    
                    if item.classType! >= 3 && item.itemType! == 3 {
                        Divider()
                        ItemStatView(item: item).padding()
                        Divider()
                        Text("WEAPON PERKS").tracking(6).font(.system(.subheadline)).padding(EdgeInsets(top: 16, leading: 16, bottom: -4, trailing: 16)).foregroundColor(Color.primaryFontColor)
                        PerksView(item: item)
                        Text("").padding()
                    } else if item.classType! <= 2  {
                        Divider()
                        GearStatView(item: item).padding()
                        Divider()
                        Text("INTRINSIC PERK").tracking(6).font(.system(.subheadline)).padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16)).foregroundColor(Color.primaryFontColor)
                        PerksView(item: item)
                        Text("").padding()
                        // Divider().background(Color.primaryFontColor)
                    }
                    
                    Spacer()
                }.padding(.top, -11)
                    
            }.edgesIgnoringSafeArea(.top)
        
                VStack {
                    Rectangle()
                        .frame(width: screenSize.width, height: 60, alignment: .top)
                        .foregroundColor(.clear)
                        .background(LinearGradient(gradient: gradientColors, startPoint: .top, endPoint: .bottom).opacity(0.7))
                        .edgesIgnoringSafeArea(.all)
                    Spacer()
                }
    
            }
            .navigationBarItems(leading: ZStack {
                VStack {
                    VisualEffectView(
                      effect: UIBlurEffect(style: .dark)
                    ).frame(width: 40, height: 40, alignment: .leading)
                    .clipShape(Circle())
                        .edgesIgnoringSafeArea(.all)
                }
                VStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("")
                            .font(.d2Symbols)
                            .foregroundColor(Color.white)
                            .padding(EdgeInsets(top: 38, leading: 10, bottom: 30, trailing: 0))
                            Spacer()
                    }
                    Spacer()
                }
            })
            .statusBar(hidden: true)
            .gesture(drag)
            
            
        }
    
    
    
    func getItemImageName()-> String? {
        return item.screenshot
    }
    
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetail(item: items[8])
            .preferredColorScheme(.dark)
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
