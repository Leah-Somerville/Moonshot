//
//  CrewView.swift
//  Moonshot
//
//  Created by Leah Somerville on 3/13/24.
//

import SwiftUI

struct CrewView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
//
    let mission: Mission
//    
    let crew: [CrewMember]
    
    var body: some View {
        VStack{
            
            Text("Crew")
                .font(.title.bold())
                .padding(.bottom, 5)
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading){
                    ForEach(crew, id: \.role) { crewMember in
                        NavigationLink{
                            AstronautView(astronaut: crewMember.astronaut)
                        } label: {
                            HStack{
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 104, height: 72)
                                    .clipShape(.circle)
                                VStack(alignment: .leading){
                                    Text(crewMember.astronaut.name)
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                            }
                            .padding(.top, 20)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }.background(.darkBackground)
    }
    
    
    init(mission: Mission, astronauts: [String: Astronaut]){
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return CrewView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
