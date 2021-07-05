//
//  RollView.swift
//  RollTheDice
//
//  Created by Kevin Choi on 2020-08-15.
//  Copyright © 2020 Kevin Choi. All rights reserved.
//

import SwiftUI

struct DieView: View {
    var number: Int
    
    var body: some View {
        VStack {
            Text("\(number)")
                .font(.largeTitle)
        }
    }
    
    func animateDie() {
        // shows random numbers before settling on the actuall number
    }
}

struct RollView: View {
    let typesOfDie = [4, 6, 8, 10, 12, 20, 100]
    
    @EnvironmentObject var diceStats: DiceStatistics
    @Environment(\.managedObjectContext) var moc
    
    @State private var isShowingSettings = false
    @State private var numberOfDice = 2
    @State private var typeOfDieSelected = 1
    @State private var numbersRolled: [Int] = [Int]()
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    @State private var sum = 0
    
    var body : some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        self.isShowingSettings = true
                    }) {
                        Image(systemName: "gear")
                            .font(.title)
                    }
                    .padding()
                    
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    ForEach(0..<numbersRolled.count, id: \.self) { index in
                        VStack {
                            Text("Die \(index + 1)")
                            DieView(number: self.numbersRolled[index])
                        }
                    }
                    .padding()
                }
                
                Text("Dice total: \(sum)")
                
                Spacer()
            }
        }
        .gesture(DragGesture()
            .onChanged { gesture in
                self.offset = gesture.translation
                self.feedback.prepare()
            }
            .onEnded { gesture in
                if self.offset.height < 40 {
                    self.feedback.notificationOccurred(.success)
                    self.rollDice()
                }
            }
        )
        .sheet(isPresented: $isShowingSettings) {
            SettingsView(diceSelection: self.$typeOfDieSelected, numberOfDice: self.$numberOfDice)
        }
        .onAppear(perform: rollDice)
    }
    
    func rollDice() {
        numbersRolled = [Int]()
        sum = 0
        for _ in 0...numberOfDice {
            let randInt = Int.random(in: 1...typesOfDie[typeOfDieSelected])
            
            sum += randInt
            numbersRolled.append(randInt)
            diceStats.rolls.append(randInt)
        }
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
