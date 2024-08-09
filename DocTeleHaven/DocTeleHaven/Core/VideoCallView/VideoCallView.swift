//
//  VideoCallView.swift
//  DocTeleHaven
//
//  Created by Kyaw Thant Zin(George) on 4/10/24.
//

import SwiftUI
import StreamVideo
import StreamVideoSwiftUI

struct VideoCallView: View {
    
    @ObservedObject var viewModel: CallViewModel
    
    // Declare properties for API key, token, and the Stream Video client
    private let apiKey: String = "mmhfdzb5evj2"
    private let token: String // Token will be passed externally
    private let callId: String // Call ID will be passed externally
    private let userId: String // User ID will be passed externally
    private let userName : String
    
    private let client: StreamVideo // Declare a property for the Stream Video client
    
    init(userId: String, token: String, callId: String,userName: String) {
        let user = User(
            id: userId,
            name: userName, // name and imageURL are used in the UI
            imageURL: nil)

        // Initialize Stream Video client
        self.client = StreamVideo(
            apiKey: apiKey,
            user: user, // User is not needed for token-based authentication
            token: .init(stringLiteral: token)
        )
        
        self.viewModel = .init()
        
        // Assign passed values to properties
        self.token = token
        self.callId = callId
        self.userId = userId
        self.userName = userName
    }
    
    var body: some View {
        VStack {
            if viewModel.call != nil {
                CallContainer(viewFactory: DefaultViewFactory.shared, viewModel: viewModel)
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            viewModel.joinCall(callType: .default, callId: callId)
        }
    }
}

//#Preview {
//    VideoCallView()
//}
