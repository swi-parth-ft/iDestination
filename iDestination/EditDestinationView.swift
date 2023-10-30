//
//  EditDestinationView.swift
//  iDestination
//
//  Created by Parth Antala on 2023-10-09.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
    
    @Bindable var destination: Destination
    @State private var newSightName = ""
    var body: some View {
        Form {
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details, axis: .vertical)
            DatePicker("Date", selection: $destination.date)
            Section("Prioriy") {
                Picker("Priority", selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.segmented)
            }
            
            Section("Sights") {
                ForEach(destination.sights) { sight in
                    Text(sight.name)
                }
                .onDelete(perform: deleteSight)
                HStack{
                    TextField("Add new sight in \(destination.name)", text:$newSightName)
                    
                    Button("Add", action: AddSight)
                }
            
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func AddSight() {
        guard newSightName.isEmpty == false else { return }
        
        withAnimation {
            let sight = Sight(name: newSightName)
            destination.sights.append(sight)
            newSightName = ""
        }
    }
    
    func deleteSight(_ indexSet: IndexSet) {
        for index in indexSet {
            let sight = destination.sights[index]
            destination.sights.remove(at: index)
        }
        
    }

}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "Example", details: "This is example details it is gonna expand verticaly when edited")
        return EditDestinationView(destination: example)
            .modelContainer(container)
    }
    catch {
        fatalError("failed to create model container")
    }
    
}
