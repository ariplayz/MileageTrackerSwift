import SwiftUI

struct MileageLogView: View {
    @Binding var records: [MileageRecord]
    var selectedVehicle: Vehicle?

    var body: some View {
        List(filteredRecords) { record in
            VStack(alignment: .leading) {
                Text(record.vehicleName)
                    .font(.headline)
                Text("Miles: \(record.miles, specifier: "%.2f")")
                if let mpg = record.mpg {
                    Text("MPG: \(mpg, specifier: "%.2f")")
                }
                if let cost = record.cost {
                    Text("Cost: $\(cost, specifier: "%.2f")")
                }
                Text(record.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Log")
    }

    private var filteredRecords: [MileageRecord] {
        guard let selectedVehicle = selectedVehicle else { return [] }
        return records.filter { $0.vehicleName == selectedVehicle.name }
    }
}

#Preview {
    MileageLogView(records: .constant([]), selectedVehicle: nil)
}
