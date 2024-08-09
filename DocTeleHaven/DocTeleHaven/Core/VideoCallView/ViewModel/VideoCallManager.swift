//
//  VideoCallManager.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/10/24.
//


import Foundation
import StreamVideo
import StreamVideoSwiftUI

//class VideoCallManager {
//    private let streamVideoClient: StreamVideo
//    private let apiKey = "YOUR_API_KEY"
//    private let userId = "YOUR_USER_ID"
//    private var token: String? // Token for authentication
//    
//    init() {
//        let user = User(id: userId)
//        self.streamVideoClient = StreamVideo(apiKey: apiKey, user: user)
//    }
//    
//    func startVideoCall() {
//        guard let token = self.token else {
//            // Fetch or generate token first
//            return
//        }
//        
//        // Connect to video call using the generated token
//        streamVideoClient.connect(token: token)
//    }
//    
//    func fetchToken() {
//        // Fetch token from your backend service or generate it locally
//        // Update the 'token' property with the fetched/generated token
//        self.token = "YOUR_GENERATED_TOKEN"
//    }
//}
