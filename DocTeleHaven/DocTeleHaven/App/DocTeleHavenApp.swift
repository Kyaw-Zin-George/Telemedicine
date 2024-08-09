//
//  DocTeleHavenApp.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/2/24.
//

import SwiftUI
import Firebase

//import SwiftUI
//import FirebaseCore
//
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}

@main
struct DocTeleHavenApp: App {
    @StateObject var viewModel = AuthViewModel()
    @StateObject var appointmentViewModel = AppointmentViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(appointmentViewModel)
        }
    }
}
