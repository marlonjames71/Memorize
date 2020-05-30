//
//  ViewController.swift
//  Memorize
//
//  Created by Marlon Raskin on 5/30/20.
//  Copyright © 2020 Marlon Raskin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

	var items = [MemoryItem]()

	override func viewDidLoad() {
		super.viewDidLoad()

		loadItems()
	}

	func loadItems() {
		guard let url = Bundle.main.url(forResource: "Items", withExtension: "json") else {
			fatalError("Can't find JSON.")
		}

		guard let data = try? Data(contentsOf: url) else {
			fatalError("Unable to load JSON.")
		}

		let decoder = JSONDecoder()

		guard let savedItems = try? decoder.decode([MemoryItem].self, from: data) else {
			fatalError("Failed to decode JSON.")
		}

		items = savedItems
	}


	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		items.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		let item = items[indexPath.row]
		cell.textLabel?.text = item.title
		cell.detailTextLabel?.text = item.text

		return cell
	}
}

