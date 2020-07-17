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
        case eventDetails(EventViewModel)
    }
    
    // MARK: - Initializer
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Navigator
    func navigate(to destination: Destination) {
        switch destination {
        case .dailyTask:
            navigationController?.popToRootViewController(animated: true)
        default:
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
        case .eventDetails(let viewModel):
            let viewController = EventDetailsViewController()
            viewController.viewModel = viewModel
            return viewController
        }
    }
}
