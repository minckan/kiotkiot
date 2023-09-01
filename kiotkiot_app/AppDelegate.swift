//
//  AppDelegate.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/05.
//

import UIKit
import UserNotifications

import FirebaseCore
import FirebaseMessaging


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_ID"


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        let newNavBarAppearance = customNavBarAppearance()
//
//        let appearance = UINavigationBar.appearance()
//        appearance.scrollEdgeAppearance = newNavBarAppearance
//        appearance.compactAppearance = newNavBarAppearance
//        appearance.standardAppearance = newNavBarAppearance
//        if #available(iOS 15.0, *) {
//            appearance.compactScrollEdgeAppearance = newNavBarAppearance
//        }
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().delegate = self
        
        let authOption : UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOption, completionHandler: {_, _ in })
        
        application.registerForRemoteNotifications()
                                                                
        
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
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        // receive message while the app is in the background, this callback WILL NOT be fired.
        // TODO: Handle Data Of Notification
        
        if let messageID = userInfo[gcmMessageIDKey] {
            printDebug("[didReceiveRemoteNotification] Message ID : \(messageID)")
        }
        
        printDebug("[didReceiveRemoteNotification] userInfo is \(userInfo["message"])")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        // receive message while the app is in the background, this callback WILL NOT be fired.
        // TODO: Handle Data Of Notification
        if let messageID = userInfo[gcmMessageIDKey] {
            printDebug("[didReceiveRemoteNotification] Message ID : \(messageID)")
        }
        
        printDebug("[didReceiveRemoteNotification] userInfo is \(userInfo["message"]))")
        
        return UIBackgroundFetchResult.newData
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        printDebug("Unable to register for remote notification: \(error.localizedDescription)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //This function is added here only for debugging purpose.
        
        printDebug("APNS token retrieved: \(deviceToken)")
        Messaging.messaging().apnsToken = deviceToken
    }
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {

        
        let userInfo = notification.request.content.userInfo
        
        print("[willPresent] \(userInfo[gcmMessageIDKey])")
        
        if let messageID = userInfo[gcmMessageIDKey] {
            printDebug("[willPresent] Message ID: \(messageID)")
        }
        
        printDebug("[willPresent] userInfo is \(userInfo)")
            
        return [[.sound, .badge, .banner, .list]]
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        print("Body: \(response.notification.request.content.body)")
        print("userInfo: \(response.notification.request.content.userInfo)")

        
        let userInfo = response.notification.request.content.userInfo
        print("[didReceive] \(userInfo[gcmMessageIDKey])")
        if let messgeID = userInfo[gcmMessageIDKey] {
            printDebug("[didReceive] Message ID: \(messgeID)")
        }
        
        printDebug("[didReceive] userInfo is \(userInfo)")
    }
}

extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        printDebug("Firebase registration token: \(String(describing: fcmToken))")
        
        
        guard let deviceId = getData(key:Const.shared.UUID) else {return}
        let pushStatus = Bool(getData(key: Const.shared.PUSH_STATUS) ?? "false") ?? false
        let pushTime = getData(key: Const.shared.PUSH_TIME) ?? "08:00"
        
        if let token = fcmToken {
            saveData(key: Const.shared.PUSH_ID, value: token)
            let dict: [String: Any] = ["device_id": deviceId, "push_id": token, "is_using_push": pushStatus, "hhmm": pushTime]
            
            UserService.shared.registerPushData(dictionary: dict) {
                printDebug("[handleFCMToken] success!")
                Loading.hideLoading()
            }
        }
    }
}
