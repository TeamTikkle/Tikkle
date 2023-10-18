//
//  TikkleRepository.swift
//  Tikkle
//
//  Created by 김도현 on 2023/10/18.
//

import Foundation
import CoreData

class TikkleRepository {
    static let shared: TikkleRepository = TikkleRepository(type: .inMemory)
    
    enum CoreDataType {
        case inMemory
        case sqlite
    }
    
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
//        if self.type == .inMemory {
//            let description = NSPersistentStoreDescription()
//            description.url = URL(fileURLWithPath: "/dev/null")
//            container.persistentStoreDescriptions = [description]
//        }

        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unable to load core data persistent stores: \(error)")
            }
        }
        return container
    }()
    
    private let type: CoreDataType
        
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private var tikkleSheetEntityList: [TikkleSheetEntity] = []
    
    private init(type: CoreDataType) {
        self.type = type
        tikkleSheetEntityList = allFetch()
    }
    
    func create(tikkleSheet: TikkleSheet) {
        let tikkleSheetEntity = TikkleSheetEntity(context: context)
        tikkleSheetEntity.uuid = tikkleSheet.id
        tikkleSheetEntity.createDate = tikkleSheet.createDate
        tikkleSheetEntity.image = tikkleSheet.image?.pngData()
        tikkleSheetEntity.title = tikkleSheet.title
        tikkleSheetEntity.sheetDescription = tikkleSheet.description
        addStampList(tikkleSheetEntity: tikkleSheetEntity, stampList: tikkleSheet.stampList)
        save()
    }
    
    func addTikkle(tikkleSheetId: UUID, tikke: Tikkle) {
        guard let tikkleSheetEntity = fetchTikkleShetEntity(id: tikkleSheetId) else { return }
        let tikkleEntity = TikkleEntity(context: context)
        tikkleEntity.title = tikke.title
        tikkleEntity.image = tikke.image?.pngData()
        tikkleEntity.isCompletion = tikke.isCompletion
        tikkleSheetEntity.addToStampList(tikkleEntity)
        save()
    }
    
    func update(tikkleSheet: TikkleSheet) {
        guard let tikkleSheetEntity = fetchTikkleShetEntity(id: tikkleSheet.id) else { return }
        tikkleSheetEntity.image = tikkleSheet.image?.pngData()
        tikkleSheetEntity.title = tikkleSheet.title
        tikkleSheetEntity.sheetDescription = tikkleSheet.description
        addStampList(tikkleSheetEntity: tikkleSheetEntity, stampList: tikkleSheet.stampList)
        save()
    }
    
    func update(tikkle: Tikkle) {
        guard let tikkleEntity = fetchTikkleEntity(id: tikkle.id) else { return }
        tikkleEntity.image = tikkle.image?.pngData()
        tikkleEntity.title = tikkle.title
        tikkleEntity.isCompletion = tikkle.isCompletion
        save()
    }
    
    private func addStampList(tikkleSheetEntity: TikkleSheetEntity, stampList: [Tikkle]) {
        let result = [TikkleEntity]()
        stampList.forEach { tikkle in
            let tikkleEntity = TikkleEntity(context: context)
            tikkleEntity.title = tikkle.title
            tikkleEntity.image = tikkle.image?.pngData()
            tikkleEntity.isCompletion = tikkle.isCompletion
            tikkleSheetEntity.addToStampList(tikkleEntity)
        }
        save()
    }
    
    func removeTikkleSheet(tikkleSheet: TikkleSheet) {
        guard let tikkleSheetEntity = fetchTikkleShetEntity(id: tikkleSheet.id) else { return }
        context.delete(tikkleSheetEntity)
        save()
    }
    
    func removeTikkle(tikkle: Tikkle) {
        guard let tikkleEntity = fetchTikkleEntity(id: tikkle.id),
              let tikkleSheetEntity = tikkleEntity.tikkleSheet else { return }
        tikkleSheetEntity.removeFromStampList(tikkleEntity)
        context.delete(tikkleEntity)
        save()
    }
    
    private func allFetch() -> [TikkleSheetEntity] {
        let fetchRequest: NSFetchRequest<TikkleSheetEntity> = TikkleSheetEntity.fetchRequest()
        do {
            let tikkleSheetList = try context.fetch(fetchRequest)
            return tikkleSheetList
        } catch {
            print("fetch for update Person error: \(error)")
            return []
        }
    }
    
    func allFetchToStruct() -> [TikkleSheet] {
        return tikkleSheetEntityList.map { $0.toStruct }
    }
    
    func fetchTikkleShetEntity(id: UUID) -> TikkleSheetEntity? {
        guard let tikkleSheetEntity = tikkleSheetEntityList.first(where: { $0.uuid == id }) else { return nil }
        return tikkleSheetEntity
    }
    
    func fetchTikkleEntity(id: UUID) -> TikkleEntity? {
        let fetchRequest: NSFetchRequest<TikkleEntity> = TikkleEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as NSUUID)
        do {
            let tikkleList = try context.fetch(fetchRequest)
            return tikkleList.first
        } catch {
            print("fetch for update Person error: \(error)")
            return nil
        }
    }
    
    private func save() {
        do {
            try context.save()
        } catch let e {
            let error = e as NSError
            print(error.code)
            print(e.localizedDescription)
        }
    }
}
