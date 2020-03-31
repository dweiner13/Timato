//
//  ContentView.swift
//  timer
//
//  Created by Dan Weiner on 3/27/20.
//  Copyright © 2020 Dan Weiner. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var currentDate = Date()
    @State private var startDate = Date()
    @State private var isRunning = false
    @State private var timerLength: TimeInterval = 60 * 25

    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    private let formatter = DateComponentsFormatter()

    var body: some View {
        return VStack {
            HStack {
                Text(formatter.string(from: timerLength - currentDate.timeIntervalSince(startDate)) ?? "nil")
                    .font(Font.largeTitle.monospacedDigit())
                    .fontWeight(.heavy)
                    .onReceive(timer) { (input) in
                        if self.timerLength - self.currentDate.timeIntervalSince(self.startDate) <= 0 {
                            self.stopTimer()
                        }
                        if self.isRunning {
                            self.currentDate = input
                        }
                    }
                isRunning ? nil : Stepper("", value: $timerLength, in: 60...(60 * 60), step: 60)
            }
            HStack {
                Button(action: pressBigButton) {
                    isRunning ? Text("Reset") : Text("Start")
                }
            }
            Divider()
                .padding(.vertical, 15.0)
            HStack {
                Text("Set to:")
                Button(action: { self.timerLength = 60 * 25 }) {
                    Text("25 minutes")
                }
                Button(action: { self.timerLength = 60 * 5 }) {
                    Text("5 minutes")
                }
            }
            .padding(0.0)
                .disabled(isRunning)
        }
        .frame(width: 250, height: 300.0)
    }

    func stopTimer() {
        startDate = Date()
        isRunning = false
        NotificationManager.shared.sendLocalNotification(title: "Timer finished!")
    }

    func pressBigButton() {
        isRunning = !isRunning
        startDate = Date()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
