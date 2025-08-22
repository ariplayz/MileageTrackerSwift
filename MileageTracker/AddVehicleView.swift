//
//  AddVehicleView.swift
//  MileageTracker
//
//  Created by Ari Greene Cummings on 8/21/25.
//


import SwiftUI

struct AddVehicleView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var vehicles: [Vehicle]
    @State private var vehicleName = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Vehicle Name", text: $vehicleName)
            }
            .navigationTitle("Add Vehicle")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveVehicle()
                        dismiss()
                    }
                }
            }
        }
    }

    private func saveVehicle() {
        let newVehicle = Vehicle(id: UUID(), name: vehicleName)
        vehicles.append(newVehicle)
    }
}

#Preview {
    AddVehicleView(vehicles: .constant([]))
}