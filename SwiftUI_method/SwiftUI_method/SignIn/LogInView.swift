//
//  LogInView.swift
//  SwiftUI_method
//
//  Created by Developer on 26.12.2022.
//

import SwiftUI
import Firebase
import Combine

struct LoginView: View {
//    @ObservedObject var session: SessionCntroller
    @State private var email = ""
    @State private var password = ""
    @State private var presentedPasswordReset = false
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .frame(width: 120.0, height: 120.0, alignment: .center)
                VStack {
                    TextFieldView(string: self.$email,
                        passwordMode: false,
                        placeholder: "Электронная почта",
                        iconName: "envelope.fill")
                        .padding(.vertical, 8)
                        
                    VStack(alignment: .trailing) {
                        TextFieldView(string: self.$password,
                            passwordMode: true,
                            placeholder: "Пароль",
                            iconName: "lock.open.fill")
                    }
                    .padding(.vertical, 8)
                    Button(action: {}) {
                        Text("Войти")
                            .padding()
                            .frame(width: 320, height: 50, alignment: .center)
                            .background(Color.init(hex: "#0077FF")).cornerRadius(1)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
            .padding(.horizontal, 16)
        }
    }
}


//struct LogInView: View {
//
//    @State private var email: String = ""
//    @State private var password: String = ""
//
//    let verticalPaddingForForm = 40
//
//    var body: some View {
//        VStack() {
//            Image("logo")
//            VStack {
//                TextField("Логин", text: $email)
//                    .font(.headline)
//                    .padding()
//                    .background(Color.gray.opacity(0.2)).cornerRadius(10)
//                TextField("Пароль", text: $password)
//                    .font(.headline)
//                    .padding()
//                    .background(Color.gray.opacity(0.2)).cornerRadius(10)
//            }
//        }
//    }
//}

//Button(action: {}, label: {
//    Text("Войти")
//        .padding()
////                    .frame(maxWidth: .infinity)
//        .background(Color.blue.cornerRadius(10))
//        .foregroundColor(.white)
//        .font(.headline)
//})
