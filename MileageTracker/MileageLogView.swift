import SwiftUI

struct MileageLogView: View {
    @Binding var records: [MileageRecord]
    var selectedVehicle: Vehicle?

    var body: some View {
        List {
            ForEach(filteredRecords.indices, id: \.self) { index in
                let record = filteredRecords[index]
                let milesSinceLast = index > 0 ? record.miles - filteredRecords[index - 1].miles : 0.0

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
                    Text("Description: \(record.description)")
                    Text("Category: \(record.category)")
                    Text("Miles Since Last: \(milesSinceLast, specifier: "%.2f")")
                        .foregroundColor(.gray)
                    Text(record.date, style: .date)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(record.date, style: .time)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .onDelete { indexSet in
                records.remove(atOffsets: indexSet)
                StorageManager.saveRecords(records)
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
