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

	var blankCounter = 0

	override func viewDidLoad() {
        super.viewDidLoad()

        assert(item != nil, "You must provide a memory item before trying to show this view controller.")
		title = item.title
		showText()

		let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(wordsTapped))
		textView.addGestureRecognizer(tapRecognizer)
    }


	private func showText() {
		let words = item.text.components(separatedBy: " ")
		var output = ""

		for (index, word) in words.enumerated() {
			if index < blankCounter {
				output += "\(word) "
			} else {
				let blank = String(repeating: "_", count: word.count)
				output += "\(blank) "
			}
		}

		textView.text = output
	}


	@objc private func wordsTapped() {
		blankCounter += 1
		self.showText()
	}
}
