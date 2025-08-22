//
//  MileageLogView.swift
//  MileageTracker
//
//  Created by Ari Greene Cummings on 8/21/25.
//


import SwiftUI

struct MileageLogView: View {
    @State private var records: [MileageRecord] = []
    @State private var showAddRecordSheet = false

    var body: some View {
        NavigationView {
            List {
                ForEach(records) { record in
                    VStack(alignment: .leading) {
                        Text("Date: \(record.date, format: .dateTime)")
                        Text("Vehicle: \(record.vehicleName)")
                        Text("Miles: \(record.miles)")
                        if let mpg = record.mpg {
                            Text("MPG: \(mpg, specifier: "%.2f")")
                        }
                        if let cost = record.cost {
                            Text("Cost: $\(cost, specifier: "%.2f")")
                        }
                    }
                }
                .onDelete { indexSet in
                    records.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("Mileage Log")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddRecordSheet = true }) {
                        Label("Add Record", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddRecordSheet) {
                AddRecordView(records: $records)
            }
        }
    }
}

#Preview {
    MileageLogView()
}