//
//  TaskPersistenceManager.swift
//  WHE
//
//  Created by Pratima Pundalik on 06/02/23.
//

import Foundation

class TaskPersistenceManager {
    
    enum FileConstants {
        static let tasksFileName = "tasks.json"
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadTasks() -> [Task] {
        let documentsDirectory = getDocumentsDirectory()
        let storageURL = documentsDirectory.appendingPathComponent(FileConstants.tasksFileName)
        guard
            let taskData = try? Data(contentsOf: storageURL),
            let tasks = try? JSONDecoder().decode([Task].self, from: taskData)
        else {
            return []
        }
        
        return tasks
    }
    
    func save(tasks: [Task]) {
        do {
            let documentsDirectory = getDocumentsDirectory()
            let storageURL = documentsDirectory.appendingPathComponent(FileConstants.tasksFileName)
            let tasksData = try JSONEncoder().encode(tasks)
            do {
                try tasksData.write(to: storageURL)
            } catch {
                print("Couldn't write to File Storage")
            }
        } catch {
            print("Couldn't encode tasks data")
        }
    }
}
