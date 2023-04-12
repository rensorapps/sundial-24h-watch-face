//
//  ContentView.swift
//  sundial WatchKit Extension
//
//  Created by Lyndon Maydwell on 11/4/2023.
//

import SwiftUI

// Fun little watch face experiment

struct ContentView: View {
    @State var bigAngle: Double = 0
    @State var smallAngle: Double = 0

    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3, style: .continuous)
                .frame(width: 80, height: 5, alignment: .leading)
                .offset(x: 40, y: 0)
                .shadow(color: .white, radius: 8, x: 0, y: 0)
                .rotationEffect(.degrees(360 * (self.bigAngle - 0.25)))
            Rectangle().frame(width: 100, height: 2, alignment: .leading)
                .foregroundColor(.red)
                .shadow(color: .red, radius: 5, x: 0, y: 0)
                .offset(x: 50, y: 0)
                .rotationEffect(.degrees(360 * (self.smallAngle - 0.25)))
            Circle().frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(.gray)
            Circle().frame(width: 24, height: 24, alignment: .center)
                .foregroundColor(.black)
            ForEach(1...12, id: \.self) { tick in
                let tick2 = tick * 2
                Text("\(tick2)").padding()
                    .offset(x: 0, y: -60)
                    .foregroundColor(.black)
                    .rotationEffect(.degrees(360 * (Double(tick2) / 24)))
                    .shadow(color: .yellow, radius: 3, x: 1, y: 2)
            }
        }
        .onReceive(timer, perform: { _ in
            let date = Date()
            let components = Calendar.current.dateComponents(
                [.hour, .minute, .second, .nanosecond],
                from: date
            )
            let hour = components.hour ?? 0
            let minute = components.minute ?? 0
            let second = components.second ?? 0
            let nanosecond = components.nanosecond ?? 0

            self.bigAngle =
                Double(hour) / 24 +
                Double(minute) / (60 * 24) +
                Double(second) / (60 * 60 * 24) +
                Double(nanosecond) / (1000000000 * 60 * 60 * 24)
            
            self.smallAngle =
                Double(second) / (60) +
                Double(nanosecond) / (1000000000 * 60)

//             print("\(hour):\(minute):\(second):\(nanosecond) - \(self.bigAngle)")

        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
