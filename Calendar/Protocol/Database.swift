//
//  Database.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol Database {
    func save(event: Event)
    func loadTodayEvents(completion: @escaping ([Event]) -> Void)
    func loadEvents(from date: Date, completion: @escaping ([EventSection]) -> Void)
    func loadAllEvents(completion: @escaping ([Event]) -> Void)
    func deleteEvent(_ event: Event)
}
