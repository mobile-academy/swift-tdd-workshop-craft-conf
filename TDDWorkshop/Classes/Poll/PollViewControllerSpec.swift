//
// Created by Maciej Oczko on 23.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import TDDWorkshop


class PollViewControllerSpec: QuickSpec {
    override func spec() {
        describe("PollViewController") {
            var sut: PollViewController!

            beforeEach {
                let storyboard = UIStoryboard(name: "Poll", bundle: nil)
                sut = storyboard.instantiateViewController(withIdentifier: "Poll") as! PollViewController
            }

            afterEach {
                sut = nil
            }

            describe("default initialization") {

                it("should have a title") {
                    expect(sut.title).to(equal("Feedback"))
                }

                it("should have z poll builder") {
                    expect(sut.pollBuilder).toNot(beNil())
                }

                it("should have poll manager") {
                    expect(sut.pollManager).toNot(beNil())
                }
            }

            describe("behavior") {
                var pollUploader: PollManagerFake?
                var pollBuilder: PollBuilder?

                beforeEach {
                    pollUploader = PollManagerFake()
                    pollBuilder = PollBuilder()
                    sut.pollManager = pollUploader
                    sut.pollBuilder = pollBuilder
                }

                describe("send button availability") {
                    var navigationController: UINavigationController?

                    beforeEach {
                        navigationController = UINavigationController(rootViewController: sut)
                    }

                    afterEach {
                        navigationController = nil
                    }

                    // About `sut.view`:
                    // To simulate normal view controller life cycle you can call the `view` property on it.
                    // It's equal to call `loadView()` and `viewDidLoad()` method.

                    it("should set navigation item") {
                        pollUploader?.setPollAlreadySent(value: false)
                        let _ = sut.view
                        sut.viewWillAppear(false)
                        expect(sut.navigationItem.rightBarButtonItem).toNot(beNil())
                    }

                    it("should nil out navigation item") {
                        pollUploader?.setPollAlreadySent(value: true)
                        let _ = sut.view
                        sut.viewWillAppear(false)
                        expect(sut.navigationItem.rightBarButtonItem).to(beNil())
                    }
                }

                describe("sending poll") {
                    var navigationController: UINavigationController?

                    beforeEach {
                        navigationController = UINavigationController(rootViewController: sut)
                        pollUploader?.setPollAlreadySent(value: false)
                        sut.sendPoll()
                    }

                    afterEach {
                        navigationController = nil
                    }

                    it("should send poll with sender") {
                        expect(pollUploader?.didCallSendPoll).to(beTrue())
                    }

                    it("should nil out button item") {
                        expect(sut.navigationItem.rightBarButtonItem).to(beNil())
                    }
                }
            }
        }
    }
}
