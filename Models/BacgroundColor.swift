//
//  BacgroundColor.swift
//  Find Xur
//
//  Created by Magnus W. Solbakken on 02/01/2021.
//  Copyright © 2020 Magnus W. Solbakken. All rights reserved.
//

import SwiftUI

func backgroundColor(name: String)-> some View {
    switch name {
        case "location":
            return Rectangle()
                    .foregroundColor(.clear)
                    .background(Color.defaultLocationBg).edgesIgnoringSafeArea(.all)
        default:
            return Rectangle()
                    .foregroundColor(.clear)
                    .background(Color.clear).edgesIgnoringSafeArea(.all)
    }
    
}
