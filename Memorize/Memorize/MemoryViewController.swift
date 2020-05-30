//
//  MemoryViewController.swift
//  Memorize
//
//  Created by Marlon Raskin on 5/30/20.
//  Copyright © 2020 Marlon Raskin. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController {

	@IBOutlet private weak var textView: UITextView!
	var item: MemoryItem!

	// Used so we know where the next word needs to be made visible
	var blankCounter = 0

	let visibleText: [NSAttributedString.Key: Any] = [
		.font: UIFont(name: "Georgia", size: 28)!,
		.foregroundColor: UIColor.label
	]

	let invisibleText: [NSAttributedString.Key: Any] = [
		.font: UIFont(name: "Georgia", size: 28)!,
		.foregroundColor: UIColor.clear,
		.strikethroughStyle: 1,
		.strikethroughColor: UIColor.label
	]

	override func viewDidLoad() {
        super.viewDidLoad()

		// Because we're implicitly unwrapping the item, we're making sure we have an actual item first.
		// We could, and I'll probably switch to dependency injection, but this is pretty neat
        assert(item != nil, "You must provide a memory item before trying to show this view controller.")
		title = item.title
		showText()

		let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(wordsTapped))
		textView.addGestureRecognizer(tapRecognizer)
    }


	private func showText() {
		let words = item.text.components(separatedBy: " ")
		let output = NSMutableAttributedString()

		let space = NSAttributedString(string: " ", attributes: visibleText)

		for (index, word) in words.enumerated() {
			if index < blankCounter {
				let attributedWord = NSAttributedString(string: word, attributes: visibleText)
				output.append(attributedWord)
			} else {
				var strippedWord = word
				var punctuation: String?

				if ".,".contains(word.last!) {
					// String init is needed to convert Character into a String
					punctuation = String(strippedWord.removeLast())
				}

				let attributedWord = NSAttributedString(string: strippedWord, attributes: invisibleText)
				output.append(attributedWord)

				if let symbol = punctuation {
					let attributedPunctuation = NSAttributedString(string: symbol, attributes: visibleText)
					output.append(attributedPunctuation)
				}
			}
			output.append(space)
		}

		textView.attributedText = output
	}


	@objc private func wordsTapped() {
		blankCounter += 1
		self.showText()
	}
}
