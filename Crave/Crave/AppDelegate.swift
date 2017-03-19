//
//  AppDelegate.swift
//  Crave
//
//  Created by Robert Durst on 10/15/16.
//  Copyright © 2016 Crave. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import Appsee
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import UserNotifications

//Global Variables
let requests = Requests()
var profile = Profile(id: "", email: "", gender: "", website: "", name: "", location: "")
let nearbyRestaurants = NearbyRestaurants()
let currentRestaurantMenus = CurrentRestaurantMenus()
let VCUtils = ViewControllerUtils()
var curAllItemList: [MenuItem] = []

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
	let gcmMessageIDKey = "gcm.message_id"


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
		
		FIRApp.configure()

		if #available(iOS 10.0, *) {
			let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
			UNUserNotificationCenter.current().requestAuthorization(
				options: authOptions,
				completionHandler: {_, _ in })
			
			// For iOS 10 display notification (sent via APNS)
			UNUserNotificationCenter.current().delegate = self
			// For iOS 10 data message (sent via FCM)
			FIRMessaging.messaging().remoteMessageDelegate = self
			
		} else {
			let settings: UIUserNotificationSettings =
				UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
			application.registerUserNotificationSettings(settings)
		}
		
		application.registerForRemoteNotifications()
		
		// [END register_for_notifications]
		
		// [START add_token_refresh_observer]
		// Add observer for InstanceID token refresh callback.
		NotificationCenter.default.addObserver(self,
		                                       selector: #selector(self.tokenRefreshNotification),
		                                       name: .firInstanceIDTokenRefresh,
		                                       object: nil)
        GMSServices.provideAPIKey("AIzaSyDYB7hpothkX4P8pvkuvoswkhhmciARvlY")
		        
        locationManagerClass.enableLocation()
		
		registerForRemoteNotification()
        return true
    }
	
	func registerForRemoteNotification() {
		let center  = UNUserNotificationCenter.current()
		center.delegate = self
		center.requestAuthorization(options: [.alert, .badge]) { (granted, error) in
			if error == nil{
				UIApplication.shared.registerForRemoteNotifications()
			}
		}
	}
	
	func tokenRefreshNotification(_ notification: Notification) {
		if let refreshedToken = FIRInstanceID.instanceID().token() {
			print("InstanceID token: \(refreshedToken)")
		}
		
		// Connect to FCM since connection may have failed when attempted before having a token.
		connectToFcm()
	}
	// [END refresh_token]
	// [START connect_to_fcm]
	func connectToFcm() {
		// Won't connect since there is no token
		guard FIRInstanceID.instanceID().token() != nil else {
			return;
		}
		
		// Disconnect previous FCM connection if it exists.
		FIRMessaging.messaging().disconnect()
		
		FIRMessaging.messaging().connect { (error) in
			if error != nil {
				print("Unable to connect with FCM. \(error)")
			} else {
				print("Connected to FCM.")
			}
		}
	}
	
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){		
		#if RELEASE
			FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: .prod)
			print("here1")
		#else
			FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: .sandbox)
			print("here")
		#endif
	}

	
//	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//		print("User Info = ",notification.request.content.userInfo)
//		completionHandler([.alert, .badge, .sound])
//	}
// 
//	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//		print("User Info = ",response.notification.request.content.userInfo)
//		completionHandler()
//	}

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
	
	// Receive displayed notifications for iOS 10 devices.
	func userNotificationCenter(_ center: UNUserNotificationCenter,
	                            willPresent notification: UNNotification,
	                            withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
		let userInfo = notification.request.content.userInfo
		// Print message ID.
		if let messageID = userInfo[gcmMessageIDKey] {
			print("Message ID: \(messageID)")
		}
		
		// Print full message.
		print(userInfo)
		
		// Change this to your preferred presentation option
		completionHandler([])
	}
	
	func userNotificationCenter(_ center: UNUserNotificationCenter,
	                            didReceive response: UNNotificationResponse,
	                            withCompletionHandler completionHandler: @escaping () -> Void) {
		let userInfo = response.notification.request.content.userInfo
		// Print message ID.
		if let messageID = userInfo[gcmMessageIDKey] {
			print("Message ID: \(messageID)")
		}
		
		// Print full message.
		print(userInfo)
		
		completionHandler()
	}
}

extension AppDelegate : FIRMessagingDelegate {
	// Receive data message on iOS 10 devices while app is in the foreground.
	func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
		print(remoteMessage.appData)
	}
}

