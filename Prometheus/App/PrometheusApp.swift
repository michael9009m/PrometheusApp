//
//  PrometheusApp.swift
//  Prometheus
//
//  Created by Michael Martinez on 3/11/24.
//

import SwiftUI
import Firebase

@main
struct PrometheusApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            Welcome()
            SurveyProgressionView()
                .environmentObject(SurveyViewModel()) //franchescos code
        }
    }
}
