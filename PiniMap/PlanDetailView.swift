//
//  PlanDetailView.swift
//  PiniMap
//
//  Created by kuwaharu on 2025/04/29.
//

import SwiftUI
import MapKit

struct PlanDetailView: View {
    var plan: Plan
    
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.681236, longitude: 139.767125), // 東京駅
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )
    
    var body: some View {
        Map(position: $cameraPosition) {
            // ここにAnnotationを今後追加できる
        }
        .mapStyle(.standard) // スタイルを指定（標準地図）
        .edgesIgnoringSafeArea(.all)
        .navigationTitle(plan.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
