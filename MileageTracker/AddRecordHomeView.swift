//
//  AddRecordHomeView.swift
//  MileageTracker
//
//  Created by Ari Greene Cummings on 8/21/25.
//


import SwiftUI

struct AddRecordHomeView: View {
    @State private var showAddRecordSheet = false

    var body: some View {
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
            Spacer()
        }
        .sheet(isPresented: $showAddRecordSheet) {
            AddRecordView(records: .constant([]))
        }
    }
}

#Preview {
    AddRecordHomeView()
}