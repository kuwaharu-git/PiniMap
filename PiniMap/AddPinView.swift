//
//  AddPinView.swift
//  PiniMap
//
//  Created by kuwaharu on 2025/04/29.
//

import SwiftUI
import MapKit
import Contacts 

struct AddPinView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var plan: Plan
    @State private var name: String = ""
    @State private var address: String = ""
    @State private var isSearching: Bool = false
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
            })
        }
    }

    func searchLocation() {
        isSearching = true
        let geocoder = CLGeocoder()
        
        // 空の住所をチェック
        if address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            isSearching = false
            errorMessage = "住所を入力してください"
            return
        }
        
        geocoder.geocodeAddressString(address, completionHandler: { (placemarks: [CLPlacemark]?, error: Error?) in
            isSearching = false
            
            // エラーハンドリング
            if let error = error {
                print("ジオコーディングエラー: \(error.localizedDescription)")
                self.errorMessage = "住所がみつかりませんでした。より詳細な住所を入力してください"
                return
            }
            
            // 結果の検証
            if let placemark = placemarks?.first, let loc = placemark.location?.coordinate {
                self.errorMessage = nil
                
                // 念のため、取得できた住所情報をログに出力
                print("検索成功: \(placemark.name ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? "")")
                saveLocation(name: name, address: address, latitude: loc.latitude, longitude: loc.longitude)
                dismiss()
                
            } else {
                self.errorMessage = "住所が見つかりませんでした。より詳細な住所を入力してください"
            }
        })
    }
    func saveLocation(name: String, address: String, latitude: Double, longitude: Double) {
        let newPin = Pin(
            id: UUID(),
            name: name,
            address: address,
            latitude: latitude,
            longitude: longitude
        )
        plan.pins.append(newPin)
    }
}
