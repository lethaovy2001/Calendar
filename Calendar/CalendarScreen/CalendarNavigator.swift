//
//  CalendarNavigator.swift
//  Calendar
//
//  Created by Vy Le on 7/16/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class CalendarNavigator: Navigator {
    // MARK: - Properties
    private weak var navigationController: UINavigationController?
    
    // MARK: - Enum
    enum Destination {
        case searchEvent
        case newEvent
        case dailyTask
    }
    
    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Navigator
    func navigate(to destination: Destination) {
        if destination == .dailyTask {
            navigationController?.popToRootViewController(animated: true)
        } else {
            let viewController = makeViewController(for: destination)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    // MARK: - Private
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .searchEvent:
            return SearchEventViewController()
        case .newEvent:
            return NewEventViewController()
        case .dailyTask:
            return DailyTaskViewController()
        }
    }
}
