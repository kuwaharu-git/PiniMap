//
//  PlanDetailView.swift
//  PiniMap
//
//  Created by kuwaharu on 2025/04/29.
//

import SwiftUI
import MapKit

struct PlanDetailView: View {
    @Binding var plan: Plan
    @State private var showingAddPinView: Bool = false
    @State private var showingPinList = false
    
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.681236, longitude: 139.767125), // 東京駅
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )
    
    var body: some View {
        Map(position: $cameraPosition) {
            ForEach(plan.pins) { pin in
                Annotation(pin.name, coordinate: CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundStyle(.red)
                        .symbolEffect(.pulse)
                }
            }
        }
        .mapStyle(.standard) // スタイルを指定（標準地図）
        .edgesIgnoringSafeArea(.all)
        .navigationTitle(plan.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingPinList = true
                }) {
                    Image(systemName: "list.bullet")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingAddPinView = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddPinView) {
            AddPinView(plan: $plan)
        }
        .sheet(isPresented: $showingPinList) {
            List {
                ForEach(plan.pins) { pin in
                    VStack(alignment: .leading) {
                        Text(pin.name).bold()
                        Text(pin.address).font(.subheadline).foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
                .onDelete { indexSet in
                    plan.pins.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("ピン一覧")
        }
        .onAppear {
            if let firstPin = plan.pins.first {
                cameraPosition = .region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: firstPin.latitude, longitude: firstPin.longitude),
                        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    )
                )
            }
        }
    }
    
}
