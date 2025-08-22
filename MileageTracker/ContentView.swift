import SwiftUI

extension Color {
    static let darkSeafoam = Color(red: 47 / 255, green: 87 / 255, blue: 70 / 255)
    static let darkTurquoise = Color(red: 32 / 255, green: 112 / 255, blue: 104 / 255)
    static let darkBackground = Color(red: 18 / 255, green: 18 / 255, blue: 18 / 255)
}

struct ContentView: View {
    @State private var showAddRecordSheet = false
    @State private var selectedVehicle: Vehicle? = StorageManager.loadLastSelectedVehicle()
    @State private var showAddVehicleSheet = false
    @State private var vehicles: [Vehicle] = StorageManager.loadVehicles()
    @State private var records: [MileageRecord] = StorageManager.loadRecords()

    var body: some View {
        NavigationView {
            ZStack {
                // Dark background gradient
                LinearGradient(
                    gradient: Gradient(colors: [.darkSeafoam, .darkTurquoise]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()

                    // Add Record Button
                    Button(action: {
                        if selectedVehicle == nil {
                            print("Error: Please select a valid vehicle.")
                            return
                        }
                        showAddRecordSheet = true
                    }) {
                        Text("Add Record")
                            .font(.title2.bold())
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.darkTurquoise.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 3)
                    }
                    .padding(.horizontal)

                    // Vehicle Picker
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
                        } else {
                            StorageManager.saveLastSelectedVehicle(newValue)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color.darkBackground)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 3)
                    .padding(.horizontal)

                    Spacer()
                }

                // Circular Log Button
                VStack {
                    Spacer()
                    HStack {
                        NavigationLink(destination: MileageLogView(records: $records, selectedVehicle: selectedVehicle)) {
                            Image(systemName: "list.bullet")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.darkSeafoam)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: 3)
                        }
                        .padding()
                        Spacer()
                    }
                }
            }
            .navigationTitle("Mileage Tracker")
            .sheet(isPresented: $showAddRecordSheet) {
                AddRecordView(records: $records, selectedVehicle: selectedVehicle)
            }
            .sheet(isPresented: $showAddVehicleSheet) {
                AddVehicleView(vehicles: $vehicles)
            }
        }
        .onAppear {
            vehicles.removeAll { $0.name == "Default Vehicle" }
            StorageManager.saveVehicles(vehicles)
        }
        .environment(\.colorScheme, .dark) // Force dark mode
    }
}

#Preview {
    ContentView()
}
