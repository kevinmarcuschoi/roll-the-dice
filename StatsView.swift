//
//  StatsView.swift
//  RollTheDice
//
//  Created by Kevin Choi on 2020-08-15.
//  Copyright © 2020 Kevin Choi. All rights reserved.
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var diceStats: DiceStatistics
    
    var body: some View {
        VStack {
            Text("Rolls:")
            
            List(diceStats.rolls, id: \.self) {roll in
                Text("\(roll)")
            }
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
