import SwiftUI

struct ContentView: View {
    @State private var showAddRecordSheet = false
    @State private var selectedVehicle: Vehicle? = nil
    @State private var showAddVehicleSheet = false
    @State private var vehicles: [Vehicle] = StorageManager.loadVehicles()
    @State private var records: [MileageRecord] = StorageManager.loadRecords()

    var body: some View {
        NavigationView {
            ZStack {
                // Background with liquid glass effect
                VisualEffectBlur(blurStyle: .systemMaterial)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()
                    Button(action: {
                        if selectedVehicle == nil {
                            print("Error: Please select a valid vehicle.")
                            return
                        }
                        showAddRecordSheet = true
                    }) {
                        Text("Add Record")
                            .font(.title)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()

                    Picker("Select Vehicle", selection: $selectedVehicle) {
                        Text("Select a Vehicle").tag(nil as Vehicle?)
                        ForEach(vehicles) { vehicle in
                            Text(vehicle.name).tag(vehicle as Vehicle?)
                        }
                        Text("Create New Vehicle").tag(Vehicle(id: UUID(), name: "Create New Vehicle"))
                    }
                    .onChange(of: selectedVehicle) { _, newValue in
                        if newValue?.name == "Create New Vehicle" {
                            selectedVehicle = nil
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
                        NavigationLink(destination: MileageLogView(records: $records, selectedVehicle: selectedVehicle)) {
                            Text("Log")
                        }
                    }
                }
                .sheet(isPresented: $showAddRecordSheet) {
                    AddRecordView(records: $records, selectedVehicle: selectedVehicle)
                }
                .sheet(isPresented: $showAddVehicleSheet) {
                    AddVehicleView(vehicles: $vehicles)
                }
            }
        }
        .onAppear {
            vehicles.removeAll { $0.name == "Default Vehicle" }
            StorageManager.saveVehicles(vehicles)
        }
    }
}

#Preview {
    ContentView()
}
