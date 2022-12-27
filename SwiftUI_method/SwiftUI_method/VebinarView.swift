//
//  VebinarView.swift
//  SwiftUI_method
//
//  Created by Developer on 27.12.2022.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.bold(.largeTitle)())
            .foregroundColor(.indigo)
    }
}

struct SubTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
    }
}

struct VebinarView: View {

    @State private var isPushEnabled = false

    @State private var speed = 50.0

    @State private var editing = false


    var body: some View {
        Form {
            VStack(alignment: .center, spacing: 10) {
                Text("Вебинар").modifier(Title())
                Text("Описание вебинара").modifier(SubTitle())
            }
            Section {
                Toggle(isOn: $isPushEnabled) {
                    Text("Push notifications")
                }
            }
            Toggle(isOn: $isPushEnabled) {
                Text("Push notifications")
            }
            Toggle(isOn: $isPushEnabled) {
                Text("Push notifications")
            }
            Toggle(isOn: $isPushEnabled) {
                Text("Push notifications")
            }
            VStack(alignment: .center, spacing: 20){
                Slider(value: $speed, in: 0 ... 100) { editing in
                    self.editing = editing
                }
                Text("\(speed)").foregroundColor(speed > 80 ? .red : .green)
            }
        }
    }
}
