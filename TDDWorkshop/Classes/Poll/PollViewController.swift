//
//  PollViewController.swift
//  TDD Workshop
//
//  Created by Maciej Oczko on 03.07.2015.
//  Copyright © 2017 Mobile Academy. All rights reserved.
//

import UIKit
import Eureka

class PollViewController: FormViewController {
    let sections = ["Intro", "Testing techniques", "Red Green Refactor", "Working with Legacy Code"]
    var pollManager: PollUploader? = PollManager()
    var pollBuilder: PollBuilder? = PollBuilder()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        title = "Feedback"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureForm()
    }

	override func viewWillAppear(_ animated: Bool) {
        guard let pollUploader = pollManager else { fatalError() }
        navigationItem.rightBarButtonItem = pollUploader.isPollAlreadySent
                ? nil
                : UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(didTapSend))
    }

	func didTapSend() {
        composePoll()
        guard let pollBuilder = pollBuilder, pollBuilder.isValid() else {
            showInvalidPollAlert()
			return
		}
		showConfirmationDialog {
			[weak self] in
			self?.sendPoll()
		}
	}

	func sendPoll() {
        guard let pollUploader = pollManager else { fatalError() }
        guard let pollBuilder = pollBuilder else { fatalError() }
        let poll = pollBuilder.create()
        pollUploader.sendPoll(poll) {
            [weak self] success in
            if success {
                self?.navigationItem.setRightBarButton(nil, animated: true)
                self?.configureForm()
            }
        }
    }

    func composePoll() {
        guard let pollBuilder = pollBuilder else { fatalError() }
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
        guard let pollUploader = pollManager else { fatalError() }
        if pollUploader.isPollAlreadySent {
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

    // TODO: Extract and test validation logic (to make it more reusable, reliable and testable).
    // Hint 1: To simulate input on form cell use this code: `simulateTextInput(forRowIdentifier:, text:)`.
    //          E.g.: simulateTextInput(forRowIdentifier: "feedback", text: "test string")
    //          List of identifiers is in `PollViewController+FormConfiguration.swift` file or in `composePoll` method.
    //
    // Hint 2: Possible solution:
    //      - Create common Validator protocol
    //      - Create different validators
    //      - Create validators factory (remember about tests)

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
