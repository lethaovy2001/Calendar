//
//  NotesContainerView.swift
//  Calendar
//
//  Created by Vy Le on 6/9/20.
//  Copyright © 2020 Vy Le. All rights reserved.
//

import UIKit

final class NotesContainerView: UIView {
    // MARK: - Properties
    private let bookRing = BookRingView()
    private let containerView = CustomContainerView(
        backgroundColor: .white,
        cornerRadius: 20,
        hasShadow: true
    )
    private let iconButton = IconButton(
        name: Constants.IconNames.notes,
        size: 16,
        color: AppColor.darkGray
    )
    private let noteTitle = CustomLabel(text: "Notes", textColor: AppColor.darkGray, textSize: 20, textWeight: .bold)
    private let textView: UITextView = {
        let textView = UITextView()
        textView.text = "N/A"
        textView.font = UIFont.systemFont(ofSize: 18.0)
        textView.textColor = UIColor.gray
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - Initializer
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(containerView)
        addSubview(bookRing)
        bringSubviewToFront(bookRing)
        containerView.addSubview(iconButton)
        containerView.addSubview(noteTitle)
        containerView.addSubview(textView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bookRing.topAnchor.constraint(equalTo: topAnchor),
            bookRing.rightAnchor.constraint(equalTo: rightAnchor),
            bookRing.leftAnchor.constraint(equalTo: leftAnchor)
        ])
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: bookRing.bottomAnchor, constant: -30),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            noteTitle.topAnchor.constraint(equalTo: bookRing.bottomAnchor, constant: 12),
            noteTitle.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            iconButton.centerYAnchor.constraint(equalTo: noteTitle.centerYAnchor),
            iconButton.leftAnchor.constraint(equalTo: noteTitle.rightAnchor, constant: 6),
            iconButton.widthAnchor.constraint(equalToConstant: 36)
        ])
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: noteTitle.bottomAnchor, constant: 6),
            textView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 36),
            textView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -36),
            textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24)
        ])
        NSLayoutConstraint.activate([
            self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
