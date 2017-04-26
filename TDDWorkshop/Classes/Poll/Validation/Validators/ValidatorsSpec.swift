//
// Created by Maciej Oczko on 23.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import TDDWorkshop

class CharactersMinimalCountValidatorSpec: QuickSpec {
    override func spec() {
        var sut: CharactersMinimalCountValidator!

        beforeEach() {
            sut = CharactersMinimalCountValidator(minimalCharactersCount: 10)
        }

        afterEach {
            sut = nil
        }

        it("should pass if more than 10 chars") {
            expect(sut.validate(text: "ten chars ten chars ten chars")).to(beTrue())
        }

        it("should pass if equal to 10 chars") {
            expect(sut.validate(text: "12345678910")).to(beTrue())
        }

        it("should fail if less than 10 chars") {
            expect(sut.validate(text: "abcd")).to(beFalse())
        }
    }
}

class EmailValidatorSpec: QuickSpec {
    override func spec() {
        var sut: EmailValidator!

        beforeEach() {
            sut = EmailValidator()
        }

        afterEach {
            sut = nil
        }

        it("should pass for valid email") {
            expect(sut.validate(text: "example@example.com")).to(beTrue())
        }

        it("should fail for invalid email") {
            expect(sut.validate(text: "bad@example")).to(beFalse())
        }
    }
}

class IllegalSymbolsValidatorSpec: QuickSpec {
    override func spec() {
        var sut: IllegalSymbolsValidator!

        beforeEach() {
            sut = IllegalSymbolsValidator()
        }

        afterEach {
            sut = nil
        }

        it("should pass for legal chars") {
            expect(sut.validate(text: "sample text")).to(beTrue())
        }

        it("should fail for illegal chars") {
            expect(sut.validate(text: "sample ^ text")).to(beFalse())
            expect(sut.validate(text: "sample - text")).to(beFalse())
            expect(sut.validate(text: "sample () text")).to(beFalse())
            expect(sut.validate(text: "sample \n text")).to(beFalse())
        }
    }
}
