//
//  DataManager.swift
//  Prometheus
//
//  Created by Noah DeMent on 3/20/24.
//

import SwiftUI
import Firebase

class DataManager: ObservableObject {
    @Published var users: [User] = []
    
    private var ref = Database.database().reference()
    
    init() {
        fetchUser()
    }
    
    func fetchUser() {
        ref.child("Users").observe(.value) { snapshot, error in
            guard let usersData = snapshot.value as? [String: [String: Any]] else {
                print("Error fetching users data")
                return
            }
            
            DispatchQueue.main.async {
                self.users = usersData.compactMap { (userID, userData) -> User? in
                    guard let age = userData["Age"] as? Int,
                          let dailyCalories = userData["DailyCalories"] as? Int,
                          let firstName = userData["FirstName"] as? String,
                          let lastName = userData["LastName"] as? String,
                          let friendsData = userData["Friends"] as? [[String: Any]],
                          let savedWorkoutsData = userData["SavedWorkouts"] as? [String: [String: Any]],
                          let settingsData = userData["Settings"] as? [String: Any],
                          let notifications = settingsData["Notifs"] as? Bool,
                          let weightInPounds = userData["WeightInPounds"] as? Double,
                          let workoutHistoryData = userData["WorkoutHistory"] as? [String: [String: Any]]
                    else {
                        print("Error parsing user data for user ID \(userID)")
                        return nil
                    }
                    
                    let friends = friendsData.compactMap { friendData -> Friend? in
                        guard let userID = friendData["UserID"] as? String,
                              let nickname = friendData["Nickname"] as? String
                        else {
                            print("Error parsing friend data for user ID \(userID)")
                            return nil
                        }
                        return Friend(userID: userID, nickname: nickname)
                    }
                    
                    let savedWorkouts = savedWorkoutsData.compactMap { (workoutID, workoutData) -> (String, Workout)? in
                        guard let activity = workoutData["Activity"] as? String,
                              let caloriesBurned = workoutData["CaloriesBurned"] as? Int,
                              let type = workoutData["Type"] as? String
                        else {
                            print("Error parsing saved workout data for user ID \(userID)")
                            return nil
                        }
                        return (workoutID, Workout(activity: activity, caloriesBurned: caloriesBurned, type: type))
                    }
                    
                    guard let gainMuscle = settingsData["GainMuscle"] as? Bool,
                          let loseWeight = settingsData["LoseWeight"] as? Bool
                    else {
                        print("Error parsing settings data for user ID \(userID)")
                        return nil
                    }
                    
                    let settings = Settings(gainMuscle: gainMuscle, loseWeight: loseWeight, notifications: notifications)
                    
                    let workoutHistory = workoutHistoryData.compactMap { (date, workoutHistoryData) -> (String, WorkoutHistory)? in
                        guard let activity = workoutHistoryData["Activity"] as? String,
                              let calories = workoutHistoryData["Calories"] as? Int,
                              let favorited = workoutHistoryData["Favorited"] as? Bool,
                              let time = workoutHistoryData["Time"] as? String,
                              let type = workoutHistoryData["Type"] as? String
                        else {
                            print("Error parsing workout history data for user ID \(userID)")
                            return nil
                        }
                        return (date, WorkoutHistory(activity: activity, calories: calories, favorited: favorited, time: time, type: type))
                    }
                    
                    return User(userID: userID, age: age, dailyCalories: dailyCalories, firstName: firstName, lastName: lastName, friends: friends, savedWorkouts: Dictionary(uniqueKeysWithValues: savedWorkouts), settings: settings, notifications: notifications, weightInPounds: weightInPounds, workoutHistory: Dictionary(uniqueKeysWithValues: workoutHistory))
                }
            }
        }
    }
}
