//
//  Database.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

protocol Database {
    func save(event: Event)
    func loadTodayEvents(completion: @escaping ([Event]) -> Void)
    func loadAllEvents(completion: @escaping ([Event]) -> Void)
}
