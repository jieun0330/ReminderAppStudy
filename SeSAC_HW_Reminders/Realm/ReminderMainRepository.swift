//
//  ToDoRepository.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/16/24.
//

import Foundation
import RealmSwift

class ReminderMainRepository {
    
    // open a realm
    let realm = try! Realm()
    
    // "C"RUD
    func createRecord(_ data: ReminderMainModel) {
        do {
            try realm.write {
                realm.add(data)
//                print(realm.configuration.fileURL)
            }
        } catch {
            print(error)
        }
    }
    
    // C"R"UD
    // false: 할일 못한 거
    func readRecordAllFilter() -> Results<ReminderMainModel> {
        return realm.objects(ReminderMainModel.self).where {
            $0.complete == false
        }
        // ascending: 내림차순, 올림차순 정렬
    }
    
    // true: 할일 완료한거!
    func readRecordCompletedFilter() -> Results<ReminderMainModel> {
        return realm.objects(ReminderMainModel.self).where {
            $0.complete == true
        }
    }
    
    // 날짜 입력안했을 경우 + 완료 못한 일 -> 오늘
    func todayScheduleFilter() -> Results<ReminderMainModel> {
        return realm.objects(ReminderMainModel.self).where {
            $0.date == "" && $0.complete == false
        }
    }
    
    // 예정
    func beScheduleFilter() -> Results<ReminderMainModel> {
        return realm.objects(ReminderMainModel.self).where {
            $0.date != "" && $0.complete == false
        }
    }
    
    func searchFilter(_ item: ReminderMainModel) -> Results<ReminderMainModel> {
        return realm.objects(ReminderMainModel.self).where {
            $0.title.contains(item.title, options: .caseInsensitive) // caseInsensitive: 대소문자 구별 없음
        }
    }
    
    func flagFilter() -> Results<ReminderMainModel> {
        return realm.objects(ReminderMainModel.self).where {
            $0.flag == true
        }
    }
    
    // CR"U"D
    // checkBox 선택 시 -> 할일 완료 업데이트
    func updateComplete(_ item: ReminderMainModel) {
        do {
            try realm.write {
                item.complete.toggle()
            }
        } catch {
            print(error)
        }
    }
    
    // 깃발 선택 시
    func updateFlag(_ item: ReminderMainModel) {
        do {
            try realm.write {
                item.flag.toggle()
            }
        } catch {
            
        }
    }
    
    // CRU"D"
    func deleteRecord(_ item: ReminderMainModel) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
}
