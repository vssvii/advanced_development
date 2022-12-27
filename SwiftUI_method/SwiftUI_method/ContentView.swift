//
//  ContentView.swift
//  SwiftUI_method
//
//  Created by Developer on 26.12.2022.
//

import SwiftUI
import CoreData


struct ContentView: View {
    
    
    var body: some View {
        
        TabView {
            VebinarView()
                .tabItem {
                    Image(systemName: "display")
                    Text("Вебинар")
                }
            LoginView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Логин")
                }
        }
    }
}

//
//struct Title: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .font(.bold(.largeTitle)())
//            .foregroundColor(.indigo)
//    }
//}
//
//struct SubTitle: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .font(.title3)
//    }
//}

//struct ContentView: View {
//
//    @State private var isPushEnabled = false
//
//    @State private var speed = 50.0
//
//    @State private var editing = false
//
//
//    var body: some View {
//        Form {
//            VStack(alignment: .center, spacing: 10) {
//                Text("Вебинар").modifier(Title())
//                Text("Описание вебинара").modifier(SubTitle())
//            }
//            Section {
//                Toggle(isOn: $isPushEnabled) {
//                    Text("Push notifications")
//                }
//            }
//            Toggle(isOn: $isPushEnabled) {
//                Text("Push notifications")
//            }
//            Toggle(isOn: $isPushEnabled) {
//                Text("Push notifications")
//            }
//            Toggle(isOn: $isPushEnabled) {
//                Text("Push notifications")
//            }
//            VStack(alignment: .center, spacing: 20){
//                Slider(value: $speed, in: 0 ... 100) { editing in
//                    self.editing = editing
//                }
//                Text("\(speed)").foregroundColor(speed > 80 ? .red : .green)
//            }
//        }
//    }
//}
//
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
