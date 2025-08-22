import Foundation

struct Vehicle: Identifiable, Hashable, Equatable, Codable {
    let id: UUID
    let name: String
}
