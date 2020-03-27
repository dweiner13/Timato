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

    private let timerLength: TimeInterval = 5

    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    private let formatter = DateComponentsFormatter()

    var body: some View {
        return VStack {
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
            Button(action: pressButton) {
                isRunning ? Text("Reset timer") : Text("Start timer")
            }
        }
            .frame(width: 300, height: 300)
    }

    private func stopTimer() {
        startDate = Date()
        isRunning = false
    }

    private func pressButton() {
        isRunning = true
        startDate = Date()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
