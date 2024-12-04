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
        if let viewController = existedViewControllerOnStack(destination: destination) {
            navigationController?.popToViewController(viewController, animated: true)
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
        case .eventDetails(let viewModel):
            let viewController = EventDetailsViewController()
            viewController.viewModel = viewModel
            return viewController
        }
    }
    
    private func existedViewControllerOnStack(destination: Destination) -> UIViewController? {
        
        let destinationVC: UIViewController.Type
        switch destination {
        case .searchEvent:
            destinationVC = SearchEventViewController.self
        case .newEvent:
            destinationVC = NewEventViewController.self
        case .dailyTask:
            destinationVC = DailyTaskViewController.self
        case .eventDetails(_):
            destinationVC = EventDetailsViewController.self
        }
        guard let stack = self.navigationController?.viewControllers else { return nil }
        for viewController in stack where viewController.isKind(of: destinationVC) {
            return viewController
        }
        return nil
    }
}
