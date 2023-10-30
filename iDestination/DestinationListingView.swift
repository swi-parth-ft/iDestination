//
//  DestinationListingView.swift
//  iDestination
//
//  Created by Parth Antala on 2023-10-30.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
    
    @Environment(\.modelContext) var modelCoontext
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse), SortDescriptor(\Destination.name)]) var destinations: [Destination]
    
    var body: some View {
        List {
            ForEach(destinations) { destination in
                NavigationLink(value: destination){
                    VStack(alignment: .leading){
                        Text(destination.name)
                            .font(.headline)
                        
                        Text(destination.date.formatted(date: .long, time: .shortened))
                        
                        
                    }
                }
            }
            .onDelete(perform: deleteDestination)
        }
    }
    
    init(sort: SortDescriptor<Destination>, search: String, onlyFuture: Bool) {
        let now = Date.now
    
        _destinations = Query(filter: #Predicate{
            if(search.isEmpty) {
                if onlyFuture {
                    return $0.date > now
                } else {
                    return true
                }
            } else if onlyFuture && !search.isEmpty {
                
                return $0.name.localizedStandardContains(search) && $0.date > now
            } else {
                return $0.name.localizedStandardContains(search)
            }
        },sort: [sort, SortDescriptor(\Destination.name)])
        
    }
    func deleteDestination(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelCoontext.delete(destination)
        }
        
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), search: "", onlyFuture: false)
}
