//
//  Countdown.swift
//  Find Xur
//
//  Created by Magnus W. Solbakken on 09/01/2021.
//  Copyright © 2021 Magnus W. Solbakken. All rights reserved.
//

import Foundation

class TimeLeft: ObservableObject {
    var now: Date
    var reset: Date
    @Published var distance: Int = 0
    @Published var days: Int = 0
    @Published var hours: Int = 0
    @Published var minutes: Int = 0
    @Published var seconds: Int = 0
    
    
    init() {
        now = Date()
        reset = Date()
        calcDays(timeLeft: distance)
        calcHours(timeLeft: distance)
        calcMinutes(timeLeft: distance)
        calcSeconds(timeLeft: distance)
    }
    
    func update() {
        distance -= 1
        calcDays(timeLeft: distance)
        calcHours(timeLeft: distance)
        calcMinutes(timeLeft: distance)
        calcSeconds(timeLeft: distance)
        print("updated time values")
    }
    
    func calcDays(timeLeft: Int) {
        self.days = (timeLeft / (1000 * 60 * 60 * 24))
    }
    func calcHours(timeLeft: Int) {
        self.hours = ((timeLeft % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))
    }
    func calcMinutes(timeLeft: Int){
        self.minutes = ((timeLeft % (1000 * 60 * 60)) / (1000 * 60))
    }
    func calcSeconds(timeLeft: Int){
        self.seconds = ((timeLeft % (1000 * 60)) / 1000)
    }

    
}
