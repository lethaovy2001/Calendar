//
//  Authentication.swift
//  Calendar
//
//  Created by Vy Le on 5/24/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

protocol Authentication {
    func getCurrentUserId() -> String?
    func createUser(email: String, password: String, completion: @escaping(Error?) -> Void)
    func logUserIn(withEmail email: String, password: String, completion: @escaping(Error?) -> Void)
    func logout()
}
