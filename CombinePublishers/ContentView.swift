//
//  ContentView.swift
//  CombinePublishers
//
//  Created by Antoine Barrault on 15/03/2022.
//

import SwiftUI
import Combine

class User: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var protectWithTouchID = false
}

struct ContentView: View {

    @ObservedObject var user = User()

    var body: some View {
        VStack {
            HStack {
                Text("Username:")
                TextField("", text: $user.username)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            HStack {
                Text("Password:")
                SecureField("", text: $user.password)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            Toggle("Protect with Face ID", isOn: $user.protectWithTouchID)
                .padding()

        }
        .onReceive(
            Publishers.CombineLatest3(user.$username,
                                      user.$password,
                                      user.$protectWithTouchID)) { value in
            // here you can do what you want with the value
            // you will receive a tuple like this($username, $password, $protectWithTouchID)
                print(value)
        }
    }
}
