//
//  NewPlanView.swift
//  PiniMap
//
//  Created by kuwaharu on 2025/04/29.
//

import SwiftUI

struct NewPlanView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var plans: [Plan]
    @State private var title = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("プラン名を入力", text: $title)
            }
            .navigationTitle("新しいプラン")
            .navigationBarItems(leading: Button("キャンセル") {
                dismiss()
            }, trailing: Button("保存") {
                let newPlan = Plan(id: UUID(), title: title)
                plans.append(newPlan)
                dismiss()
            }.disabled(title.isEmpty))
        }
    }
}
