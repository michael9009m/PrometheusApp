//
//  DataManager.swift
//  Prometheus
//
//  Created by Noah DeMent on 3/20/24.
//

import Foundation
import Firebase
import FirebaseDatabaseInternal

class UserFetcher: ObservableObject {
    private let ref = Database.database().reference()
    
    func fetchUser(withUserID userID: String, completion: @escaping (User?) -> Void) {
        ref.child("Users").child(userID).observeSingleEvent(of: .value) { snapshot in
            guard let userData = snapshot.value as? [String: Any],
                  let age = userData["Age"] as? Int,
                  let dailyCalories = userData["DailyCalories"] as? Int,
                  let firstName = userData["FirstName"] as? String,
                  let lastName = userData["LastName"] as? String,
                  let friendsData = userData["Friends"] as? [[String: Any]],
                  let weightInPounds = userData["WeightInPounds"] as? Double,
                  let settingsData = userData["Settings"] as? [String: Any],
                  let notifications = settingsData["notifications"] as? Bool,
                  let goal = userData["goal"] as? String,
                  let workoutHistoryData = userData["WorkoutHistory"] as? [String: [String: Any]]
            else {
                completion(nil)
                return
            }
            
            let friends = friendsData.compactMap { friendData -> Friend? in
                guard let userID = friendData["UserID"] as? String,
                      let nickname = friendData["Nickname"] as? String
                else {
                    return nil
                }
                return Friend(userID: userID, nickname: nickname)
            }
            
            let settings = Settings(notifications: notifications)
            
            // Convert workoutHistoryData to [String: WorkoutHistory]
            var workoutHistory = [String: WorkoutHistory]()
            for (date, historyData) in workoutHistoryData {
                guard let activity = historyData["Activity"] as? String,
                      let calories = historyData["Calories"] as? Int,
                      let favorited = historyData["Favorited"] as? Bool,
                      let time = historyData["Time"] as? String,
                      let type = historyData["Type"] as? String
                else {
                    continue
                }
                let workoutHistoryItem = WorkoutHistory(activity: activity, calories: calories, favorited: favorited, time: time, type: type)
                workoutHistory[date] = workoutHistoryItem
            }
            
            let user = User(userID: userID, age: age, dailyCalories: dailyCalories, firstName: firstName, lastName: lastName, friends: friends, savedWorkouts: [:], settings: settings, notifications: notifications, weightInPounds: weightInPounds, workoutHistory: workoutHistory, goal: goal)
            
            completion(user)
        }
    }
}
