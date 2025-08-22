//
//  MileageRecord.swift
//  MileageTracker
//
//  Created by Ari Greene Cummings on 8/21/25.
//


import Foundation

struct MileageRecord: Identifiable {
    let id: UUID
    let date: Date
    let vehicleName: String
    let miles: Double
    let mpg: Double?
    let cost: Double?
}