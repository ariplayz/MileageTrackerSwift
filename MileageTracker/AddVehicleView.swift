import SwiftUI

struct AddVehicleView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var vehicles: [Vehicle]
    @State private var vehicleName = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Vehicle Details")) {
                    TextField("Name", text: $vehicleName)
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
        StorageManager.saveVehicles(vehicles)
    }
}

#Preview {
    AddVehicleView(vehicles: .constant([]))
}
