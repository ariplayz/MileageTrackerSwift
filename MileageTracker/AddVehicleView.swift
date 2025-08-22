import SwiftUI

struct AddVehicleView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var vehicles: [Vehicle]
    @State private var vehicleName = ""
    @State private var make = ""
    @State private var model = ""
    @State private var year = ""
    @State private var details = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Vehicle Details")) {
                    TextField("Name", text: $vehicleName)
                    TextField("Make", text: $make)
                    TextField("Model", text: $model)
                    TextField("Year", text: $year)
                        .keyboardType(.numberPad)
                    TextField("Other Details", text: $details)
                }
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
        let newVehicle = Vehicle(
            id: UUID(),
            name: vehicleName.isEmpty ? "Unnamed Vehicle" : vehicleName
        )
        vehicles.append(newVehicle)
    }
}

#Preview {
    AddVehicleView(vehicles: .constant([]))
}
