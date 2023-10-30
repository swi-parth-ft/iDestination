//
//  ContentView.swift
//  iDestination
//
//  Created by Parth Antala on 2023-10-09.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelCoontext
    
    @State private var path = [Destination]()
    @State private var sortOrder = SortDescriptor(\Destination.name)
    @State private var searchText = ""
    @State private var futureDate = false
    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder, search: searchText, onlyFuture: futureDate)
                .navigationTitle("iDestination")
                .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
                .searchable(text: $searchText)
                .toolbar {
                    ToolbarItemGroup{
                        Button("New Destination", systemImage: "plus", action: addNewDestination)
                        
                        Menu("sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder){
                                Text("name")
                                    .tag(SortDescriptor(\Destination.name))
                                
                                Text("Priority")
                                    .tag(SortDescriptor(\Destination.priority, order: .reverse))
                                
                                Text("Date")
                                    .tag(SortDescriptor(\Destination.date))
                            }
                            .pickerStyle(.inline)
                        }
                        
                        Button("Only Future Dates", systemImage: "calendar") {
                            futureDate.toggle()
                        }
                    }
                }
        }
    }
    
    func addNewDestination() {
        let destination = Destination()
        modelCoontext.insert(destination)
        path = [destination]
    }
}

#Preview {
    ContentView()
}
