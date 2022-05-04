//
//  AppDelegate.swift
//  Find Xur
//
//  Created by Magnus W. Solbakken on 30/12/2020.
//  Copyright © 2020 Magnus W. Solbakken. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // ber bruker om lov til aa sende push notif.
        UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate

        let authOptions: UNAuthorizationOptions = [.alert, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {granted, error in
                UserDefaults.standard.set(granted, forKey: "PushAuthGranted")
        })
        
        // Hvis bruker har godkjent aa motta push notif.
        // blir deviceToken (hvis ny token) sendt til xur db (async)
        DispatchQueue.main.async {
            application.registerForRemoteNotifications()
        }
        /*
         
         // hvis det er forste launch av app
         if defaults.bool(forKey: "notFirstLaunch") != true {
             // fetcher data fra xur db
             fetchNewData()
         }
         
         */
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("Will resign active")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        // init var for User Defaults (UD)
        let defaults = UserDefaults.standard
        
        // viser deviceToken i konsoll
        print("APNs device token is valid")
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("\(deviceTokenString)")
        
        // viser om push er gokjent i konsoll
        let pushAuthGranted = defaults.bool(forKey: "PushAuthGranted")
        print("Push Notifications Authorized: \(pushAuthGranted)")
        
        // init var for deviceToken
        var token = "0"
        
        // hvis token allerede er lagret i UD -> token = UD-token
        if defaults.string(forKey: "Token") != nil {
            token = defaults.string(forKey: "Token")!
        }
        
        // hvis token ikke finnes i fra for i UD:
        if token == "0" {
            // registrerer token i Xur Wiki DB
            sendDeviceToken(token: deviceTokenString)
            // lagrer token i UD
            defaults.set(deviceTokenString, forKey: "Token")
        } else {
            // hvis token ikke er lik den lagret i UD
            if token != deviceTokenString && pushAuthGranted {
                // registrerer oppdatert token i Xur Wiki DB
                sendDeviceToken(token: deviceTokenString)
                // lagrer ny token i UD
                defaults.set(deviceTokenString, forKey: "Token")
            }
        }
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register:", error)
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        print("Memory warning..")
    }
    
    func application(_ application: UIApplication,
    didReceiveRemoteNotification userInfo: [AnyHashable : Any],
    fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "newData")
        completionHandler(.newData)
        
    }
    
    // Func for handling user actions on push notification when app is inactive
    // ! Func works great, but could be made much shorter
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                didReceive response: UNNotificationResponse,
                withCompletionHandler completionHandler:
                   @escaping () -> Void) {
        // Get the payload from the original notification.
        let userInfo = response.notification.request.content.userInfo
        
        print("Did recieve push message.")
        print("User Info: \(userInfo)")
        
        // Fetches new data for all actions
        switch response.actionIdentifier {
        case "ACCEPT_ACTION":
            // Fetch and save new data from xur db
           fetchNewData()
           break
                  
        case "DECLINE_ACTION":
            // Fetch and save new data from xur db
           fetchNewData()
           break
                  
        case UNNotificationDefaultActionIdentifier,
             UNNotificationDismissActionIdentifier:
           // Fetch and save new data from xur db
           //  if the user does not act.
            
           fetchNewData()
           break
                  
        default:
          // Fetch and save new data from xur db
          fetchNewData()
          break
        }
            
       // Always call the completion handler when done.
       completionHandler()
    }

}

// Func: Handling push notifications when app is active (hides notif. fetches new data)
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)-> Void) {
        print("!!! Did recieve push message.")
        
        // Fetch and save new data from xur db
        fetchNewData()
        
        completionHandler([])
    }
}

// Func returning a string with current date and time with correct formatting
func getCurrentDateTimeString()-> String {
    let formatter = DateFormatter()
    //formatter.locale = Locale(identifier: "en_US")
    formatter.dateFormat = "MMMM dd yyyy HH:mm:ss ZZZZ"
    formatter.timeZone = TimeZone(secondsFromGMT: 7200)
    let now = Date()
    return formatter.string(from: now)
}

// Func fetch and save new data from xur db
private func fetchNewData()-> Void {
    let xurVM = XurViewModel()
    xurVM.fetch()
    // UserDefaults var (UD)
    let defaults = UserDefaults.standard
    
    // update UD values
    defaults.set(true, forKey: "newData")
}

