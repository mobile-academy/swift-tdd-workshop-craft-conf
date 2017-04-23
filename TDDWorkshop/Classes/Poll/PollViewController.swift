//
//  PollViewController.swift
//  TDD Workshop
//
//  Created by Maciej Oczko on 03.07.2015.
//  Copyright © 2017 Mobile Academy. All rights reserved.
//

import UIKit
import Eureka

// TODO 1: Add spec file for PollViewController

enum ValidatorType {
    case text
    case comment
    case email
}

struct ValidationContext {
    let validator: (String?) -> Bool
    let message: String
}

class PollViewController: FormViewController {
    let sections = ["Intro", "Testing techniques", "Red Green Refactor", "Working with Legacy Code"]
    var pollBuilder: PollBuilder = PollBuilder()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        title = "Feedback"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureForm()
    }

	override func viewWillAppear(_ animated: Bool) {
        // TODO 2: Write test that checks whether `rightBarButtonItem` is being set correctly depending on `pollAlreadySent` flag.
        // Then, think what else could be tested for this class.

        navigationItem.rightBarButtonItem = PollManager.shared.isPollAlreadySent
                ? nil
                : UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(didTapSend))
    }

	func didTapSend() {
        composePoll()
        guard pollBuilder.isValid() else {
            showInvalidPollAlert()
			return
		}
		showConfirmationDialog {
			[weak self] in
			self?.sendPoll()
		}
	}

	func sendPoll() {
        let poll = pollBuilder.create()
        PollManager.shared.sendPoll(poll) {
            [weak self] success in
            if success {
                self?.navigationItem.setRightBarButton(nil, animated: true)
                self?.configureForm()
            }
        }
    }

    func composePoll() {
        let formValues = form.values()
        pollBuilder
                .with(name: formValues["name"] as? String)
                .with(email: formValues["username"] as? String)
                .with(comments: formValues["feedback"] as? String)

        for (i, section) in sections.enumerated() {
            pollBuilder
                    .with(rate: formValues["rate(\(i)"] as? Int, forTitle: section)
                    .with(comment: formValues["comment\(i)"] as? String, forTitle: section)
        }
    }

    private func showInvalidPollAlert() {
        let alert = UIAlertController(title: "Error", message: "Can't send poll.\nFields with * are required.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    private func showConfirmationDialog(withAction action: @escaping (Void) -> ()) {
        let alertAction = UIAlertAction(title: "Yes", style: .default) { _ in
            action()
        }
        let alert = UIAlertController(title: "Confirmation", message: "You can send it only once.\nDo you want to continue?", preferredStyle: .alert)
        alert.addAction(alertAction)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.preferredAction = alertAction
        present(alert, animated: true, completion: nil)
    }

    // MARK: Form configuration

    func configureForm() {
        if PollManager.shared.isPollAlreadySent {
            configureSentGeneralSection()
        } else {
            let validators = [
                    ValidatorType.text: ValidationContext(validator: validate(text:), message: "Invalid characters"),
                    ValidatorType.comment: ValidationContext(validator: validate(comment:), message: "Your comment is too short"),
                    ValidatorType.email: ValidationContext(validator: validate(email:), message: "Invalid email format")
            ]
            configureGeneralSection(with: validators)
            configureAgendaSections(with: validators)
        }
    }

    // MARK: Validation

    func validate(comment: String?) -> Bool {
        guard let comment = comment, !comment.isEmpty else { return false }
        return comment.characters.count > 10
    }

    func validate(email: String?) -> Bool {
        guard let email = email, !email.isEmpty else { return false }
        let pattern = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let regex = NSPredicate(format: "SELF MATCHES %@", pattern)
        return regex.evaluate(with: email)
    }

    func validate(text: String?) -> Bool {
        guard let text = text, !text.isEmpty else { return false }
        return [
                CharacterSet.illegalCharacters,
                CharacterSet.symbols,
                CharacterSet.punctuationCharacters,
                CharacterSet.nonBaseCharacters,
                CharacterSet.controlCharacters,
        ].reduce(true) {
            $0 || text.rangeOfCharacter(from: $1) != nil
        }
    }
}
