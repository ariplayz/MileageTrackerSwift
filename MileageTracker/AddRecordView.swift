//
//  AddRecordView.swift
//  MileageTracker
//
//  Created by Ari Greene Cummings on 8/21/25.
//


import SwiftUI

struct AddRecordView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var records: [MileageRecord]
    @State private var vehicleName = ""
    @State private var miles = ""
    @State private var fuelMode = false
    @State private var gallons = ""
    @State private var pricePerGallon = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Vehicle")) {
                    TextField("Vehicle Name", text: $vehicleName)
                }
                Section(header: Text("Miles")) {
                    TextField("Miles Driven", text: $miles)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Fuel Mode")) {
                    Toggle("Fuel Mode", isOn: $fuelMode)
                    if fuelMode {
                        TextField("Gallons", text: $gallons)
                            .keyboardType(.decimalPad)
                        TextField("Price per Gallon", text: $pricePerGallon)
                            .keyboardType(.decimalPad)
                    }
                }
            }
            .navigationTitle("Add Record")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveRecord()
                        dismiss()
                    }
                }
            }
        }
    }

    private func saveRecord() {
        guard let miles = Double(miles) else { return }
        var mpg: Double? = nil
        var cost: Double? = nil

        if fuelMode, let gallons = Double(gallons), let price = Double(pricePerGallon) {
            mpg = miles / gallons
            cost = gallons * price
        }

        let newRecord = MileageRecord(
            id: UUID(),
            date: Date(),
            vehicleName: vehicleName,
            miles: miles,
            mpg: mpg,
            cost: cost
        )
        records.append(newRecord)
    }
}

#Preview {
    AddRecordView(records: .constant([]))
}