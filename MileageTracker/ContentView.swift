import SwiftUI

struct ContentView: View {
    @State private var showAddRecordSheet = false
    @State private var selectedVehicle: Vehicle?
    @State private var showAddVehicleSheet = false
    @State private var vehicles: [Vehicle] = [
        Vehicle(id: UUID(), name: "Select Vehicle") // Example vehicle
    ]

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Button(action: {
                    showAddRecordSheet = true
                }) {
                    Text("Add Record")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Picker("Select Vehicle", selection: $selectedVehicle) {
                    ForEach(vehicles) { vehicle in
                        Text(vehicle.name).tag(vehicle as Vehicle?)
                    }
                    Text("Create New Vehicle").tag(nil as Vehicle?)
                }
                .onChange(of: selectedVehicle) { _, _ in
                    if selectedVehicle == nil {
                        showAddVehicleSheet = true
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()

                Spacer()
            }
            .navigationTitle("Mileage Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: MileageLogView()) {
                        Text("Log")
                    }
                }
            }
            .sheet(isPresented: $showAddRecordSheet) {
                AddRecordView(records: .constant([]))
            }
            .sheet(isPresented: $showAddVehicleSheet) {
                AddVehicleView(vehicles: $vehicles)
            }
        }
    }
}

#Preview {
    ContentView()
}
