import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MileageLogView()
                .tabItem {
                    Label("Log", systemImage: "list.bullet")
                }
            AddRecordHomeView()
                .tabItem {
                    Label("Add Record", systemImage: "plus.circle")
                }
            VehicleListView()
                .tabItem {
                    Label("Vehicles", systemImage: "car")
                }
        }
    }
}

#Preview {
    ContentView()
}
