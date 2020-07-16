//
//  LoginNavigator.swift
//  Calendar
//
//  Created by Vy Le on 7/15/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class DailyTaskNavigator: Navigator {
    enum Destination {
        case userSettings
        case calendar
        case newEvent
    }
    weak var navigationController: UINavigationController?
    
    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Navigator
    func navigate(to destination: Destination) {
        let viewController = makeViewController(for: destination)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Private
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .userSettings:
            return UserSettingsViewController()
        case .calendar:
            return CalendarViewController()
        case .newEvent:
            return NewEventViewController()
        }
    }
}

protocol Navigator {
    associatedtype Destination
    func navigate(to destination: Destination)
}


