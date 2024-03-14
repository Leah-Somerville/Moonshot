//
//  AstronautView.swift
//  Moonshot
//
//  Created by Leah Somerville on 3/11/24.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    
    var body: some View {
        ScrollView{
            VStack{
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.leading)
                    .padding(.trailing)
                
                Text(astronaut.name)
                    .font(.title.bold())
                    .padding(10)
                
                Text(astronaut.description)
                    .padding(.leading)
                    .padding(.trailing)
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let astronaut: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return AstronautView(astronaut: astronaut["aldrin"]!)
        .preferredColorScheme(.dark)
}
