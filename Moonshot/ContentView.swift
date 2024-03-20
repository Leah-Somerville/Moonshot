//
//  ContentView.swift
//  Moonshot
//
//  Created by Leah Somerville on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingGrid = false
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        
        if showingGrid {
            NavigationStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(missions) { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronauts)
                            } label: {
                                VStack {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding()

                                    VStack {
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundStyle(.white)

                                        Text(mission.formattedLaunchDate)
                                            .font(.caption)
                                            .foregroundStyle(.white.opacity(0.5))
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.lightBackground)
                                }
                                .clipShape(.rect(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightBackground)
                                )
                            }
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                .toolbar {
                    Button {
                        withAnimation {
                            showingGrid.toggle()
                        }
                    } label: {
                        Text("List View")
                    }
                }
                .navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
            }
        } else {
            NavigationStack {
                List{
                    ScrollView{
                        
//                        CHALLENGE 3
                        NavigationStack{
                            ForEach(missions) { mission in
                                NavigationLink("\(mission.displayName)", value: mission.displayName)
                                    .navigationDestination(for: String.self) { selection in
                                        MissionView(mission: mission, astronauts: astronauts)
                                    }
                                .padding(5)
                            }
                        }
                    }
                    .listRowBackground(Color.darkBackground)
                    .foregroundColor(.white)
                }
                .toolbar {
                    Button {
                        withAnimation {
                            showingGrid.toggle()
                        }
                    } label: {
                        Text("Grid View")
                    }
                }
                .listStyle(.sidebar)
                .navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
