//
//  User.swift
//  Prometheus
//
//  Created by Chris DeMent on 3/20/24.
//

import SwiftUI

struct User {
    let userID: String
    let age: Int
    let dailyCalories: Int
    let firstName: String
    let lastName: String
    let friends: [Friend]
    let savedWorkouts: [String: Workout]
    let settings: Settings
    let notifications: Bool
    let weightInPounds: Double
    let workoutHistory: [String: WorkoutHistory]
}

struct Friend {
    let userID: String
    let nickname: String
}

struct Workout {
    let activity: String
    let caloriesBurned: Int
    let type: String
}

struct Settings {
    let gainMuscle: Bool
    let loseWeight: Bool
    let notifications: Bool
}

struct WorkoutHistory {
    let activity: String
    let calories: Int
    let favorited: Bool
    let time: String
    let type: String
}

