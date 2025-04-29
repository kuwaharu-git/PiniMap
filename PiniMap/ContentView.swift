//
//  ContentView.swift
//  PiniMap
//
//  Created by kuwaharu on 2025/04/29.
//

import SwiftUI


struct ContentView: View {
    @State private var plans: [Plan] = []
    @State private var showingNewPlanView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach($plans) { $plan in
                    NavigationLink(destination: PlanDetailView(plan: $plan)) {
                        Text(plan.title)
                    }
                }
            }
            .navigationTitle("PiniMap")
            .navigationBarItems(trailing: Button(action: {
                showingNewPlanView = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingNewPlanView) {
                NewPlanView(plans: $plans)
            }
        }
    }
}

#Preview {
    ContentView()
}
