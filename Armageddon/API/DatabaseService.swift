//
//  DatabaseService.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/23/22.
//

import UIKit
import CoreData

class DatabaseService {
    static let shared = DatabaseService()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate

    func saveAsteroid(asteroid: AsteroidInformation) {
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "BruceWillisAsteroid", in: context) else { return }
        
        let answerArray = getAsteroidInformation()
        var isAddedName = false
        
        if !answerArray.isEmpty {
            for item in answerArray {
                if asteroid.name == item.name {
                    isAddedName = true
                }
            }
        }
        
        if !isAddedName {
            let newRecord = NSManagedObject(entity: entity, insertInto: context)

            newRecord.setValue(asteroid.name, forKey: "name")
            newRecord.setValue(asteroid.closeApproachData, forKey: "closeApproachData")
            newRecord.setValue(asteroid.isPotentiallyHazardous, forKey: "isPotentiallyHazardous")
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BruceWillisAsteroid")

            do {
                try context.save()
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    func getAsteroidInformation() -> [BruceAsteroid] {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BruceWillisAsteroid")
        var resultArray = [BruceAsteroid]()

        do {
            let result = try context.fetch(fetchRequest)
            for data in result {
                if let data = data as? NSManagedObject {
                    let name = data.value(forKey: "name") as? String ?? ""
                    let date = data.value(forKey: "closeApproachData") as? String ?? ""
                    let isHazardous = data.value(forKey: "isPotentiallyHazardous") as? Bool ?? false
                    let oneAsteroid = BruceAsteroid(name: name, date: date, isHazardous: isHazardous)
                    resultArray.append(oneAsteroid)
                }
            }
        } catch let error as NSError {
            print(error)
        }
        return resultArray
    }
    
    func deleteAsteroid(asteroid: BruceAsteroid) {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BruceWillisAsteroid")
        fetchRequest.predicate = NSPredicate(format: "name == %@", asteroid.name)
        do {
            let result = try context.fetch(fetchRequest)
            guard let deleteAsteroid = result.first as? NSManagedObject else { return }
            context.delete(deleteAsteroid)
            try context.save()
        } catch {
            print(error)
        }
    }
}
