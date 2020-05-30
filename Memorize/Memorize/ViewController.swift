//
//  ViewController.swift
//  Memorize
//
//  Created by Marlon Raskin on 5/30/20.
//  Copyright © 2020 Marlon Raskin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

	let dataSource = MemoryDataSource()

	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Speeches"
		tableView.dataSource = dataSource
	}


	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let vc = storyboard?.instantiateViewController(identifier: "MemoryViewController") as? MemoryViewController else {
			fatalError("Unable to instantiate memory view controller.")
		}

		let item = dataSource.item(at: indexPath.row)
		vc.item = item

		navigationController?.pushViewController(vc, animated: true)
	}
}

