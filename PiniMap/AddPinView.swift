//
//  AddPinView.swift
//  PiniMap
//
//  Created by kuwaharu on 2025/04/29.
//

import SwiftUI
import MapKit

struct AddPinView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var plan: Plan
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var isSearching: Bool = false
    @State private var location: CLLocationCoordinate2D?
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("スポット情報")) {
                    TextField("スポット名", text: $name)
                    TextField("住所", text: $address)
                        .autocapitalization(.none)
                }

                if isSearching {
                    ProgressView()
                }
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }

                Button("ピンを追加") {
                    searchLocation()
                }
                .disabled(name.isEmpty || address.isEmpty)
            }
            .navigationTitle("新しいピンを追加")
            .navigationBarItems(leading: Button("キャンセル") {
                dismiss()
            }, trailing: Button("保存") {
                if let location = location {
                    let newPin = Pin(
                        id: UUID(),
                        name: name,
                        address: address,
                        latitude: location.latitude,
                        longitude: location.longitude
                    )
                    plan.pins.append(newPin)
                }
                dismiss()
            }.disabled(location == nil))
        }
    }

    func searchLocation() {
        isSearching = true
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            isSearching = false
            if let placemark = placemarks?.first,
               let loc = placemark.location?.coordinate {
                location = loc
                errorMessage = nil
            } else {
                location = nil
                errorMessage = "存在しない住所です"
            }
        }
    }
}
