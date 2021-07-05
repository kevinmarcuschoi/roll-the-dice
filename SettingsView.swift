//
//  SettingsView.swift
//  RollTheDice
//
//  Created by Kevin Choi on 2020-08-16.
//  Copyright © 2020 Kevin Choi. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var diceSelection: Int
    @Binding var numberOfDice: Int
    let diceChoices = ["4-sided", "6-sided", "8-sided", "10-sided", "12-sided", "20-sided", "100-sided"]
    let amountOfDiceSelections = ["1", "2", "3", "4"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $diceSelection, label: Text("What type of die?")) {
                        ForEach(0..<diceChoices.count) { index in
                            Text("\(self.diceChoices[index])")
                        }
                    }
                    Picker(selection: $numberOfDice, label: Text("How many dice?")) {
                        ForEach(0..<amountOfDiceSelections.count) { index in
                            Text("\(self.amountOfDiceSelections[index])")
                        }
                    }
                }
            }
            .navigationBarItems(leading:
                Button("Done", action: {
                    self.presentationMode.wrappedValue.dismiss()
                }))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    @State static var type = 1
    @State static var number = 1
    
    static var previews: some View {
        SettingsView(diceSelection: $type, numberOfDice: $number)
    }
}
