//
//  VehicleListView.swift
//  MileageTracker
//
//  Created by Ari Greene Cummings on 8/21/25.
//


import SwiftUI

struct VehicleListView: View {
    @State private var vehicles: [Vehicle] = []
    @State private var showAddVehicleSheet = false

    var body: some View {
        NavigationView {
            List {
                ForEach(vehicles) { vehicle in
                    Text(vehicle.name)
                }
                .onDelete { indexSet in
                    vehicles.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("Vehicles")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddVehicleSheet = true }) {
                        Label("Add Vehicle", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddVehicleSheet) {
                AddVehicleView(vehicles: $vehicles)
            }
        }
    }
}

#Preview {
    VehicleListView()
}