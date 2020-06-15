//
//  NewEventViewController.swift
//  Calendar
//
//  Created by Vy Le on 5/31/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit
import UserNotifications

final class NewEventViewController: UIViewController {
    // MARK: - Properties
    private var database: Database
    private let mainView = NewEventView()
    private var alertOptions = Constants.setAlertOptions
    weak var keyboardDelegate: KeyboardDelegate?
    private var selectedComponent: Calendar.Component?
    private let userNotificationCenter = UNUserNotificationCenter.current()
    
    // MARK: - Initializer
    init(database: Database = FirebaseService.shared) {
        self.database = database
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        checkAuthorizationStatus()
    }
    
    // MARK: - Setup
    private func setup() {
        setupSelf()
        setupUI()
        registerCellId()
        setSelections()
        setupKeyboardObservers()
        addGestureAndDelegate()
    }
    
    private func setupSelf() {
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupUI() {
        view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func registerCellId() {
        mainView.registerCellId(viewController: self)
    }
    
    private func setSelections() {
        mainView.setSaveButtonSelector(target: self, selector: #selector(pressedSaveButton))
    }
    
    private func addGestureAndDelegate() {
        mainView.addTapGesture(target: self, selector: #selector(dismissKeyboard))
        mainView.addDelegate(viewController: self)
    }
    
    private func checkAuthorizationStatus() {
        userNotificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestNotificationAuthorization()
            default:
                break
            }
        }
    }
    
    private func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        self.userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func scheduleNotification(for event: Event) {
        guard let alertTime = event.alertTime else { return }
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = event.name
        notificationContent.categoryIdentifier = "alarm"
        notificationContent.sound = .default
        if let notes = event.notes {
            notificationContent.body = notes
        }
        let dateComponents = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: alertTime
        )
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: notificationContent,
                                            trigger: trigger)
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    // MARK: Actions
    @objc private func pressedSaveButton() {
        mainView.saveButtonTappedAnimation()
        guard let event = mainView.getSavedEvent() else { return }
        guard
            let time = mainView.getTimeSetForAlert(),
            let component = selectedComponent,
            let alertDate = Calendar.current.date(byAdding: component,
                                                  value: -time,
                                                  to: event.startTime)
        else {
            database.save(event: event)
            return
        }
        var updateEvent = event
        updateEvent.alertTime = alertDate
        scheduleNotification(for: updateEvent)
        database.save(event: updateEvent)
    }
}

extension NewEventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.CellId.notificationCellId,
            for: indexPath) as? NotificationCell
        else { return UITableViewCell() }
        cell.options = alertOptions[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

extension NewEventViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch alertOptions[indexPath.row] {
        case .minute:
            selectedComponent = .minute
        case .hour:
            selectedComponent = .hour
        case .day:
            selectedComponent = .day
        case .month:
            selectedComponent = .month
        }
        mainView.updateAlert(option: alertOptions[indexPath.row])
    }
}

// MARK: - Keyboards
extension NewEventViewController {
    private func setupKeyboardObservers() {
        let notification = NotificationCenter.default
        notification.addObserver(self,
                                 selector: #selector(handleKeyboardWillShow),
                                 name: UIResponder.keyboardWillShowNotification,
                                 object: nil)
        notification.addObserver(self,
                                 selector: #selector(handleKeyboardWillHide),
                                 name: UIResponder.keyboardWillHideNotification,
                                 object: nil)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func handleKeyboardWillHide(notification: NSNotification) {
        keyboardDelegate?.hideKeyboard()
    }
    
    @objc private func handleKeyboardWillShow(notification: NSNotification) {
        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        mainView.keyboardFrame = keyboardFrame ?? frame
        keyboardDelegate?.showKeyboard()
    }
}

// MARK: - UITextViewDelegate
extension NewEventViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        mainView.didChange()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        mainView.beginEditing()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        mainView.endEditing()
    }
}
