//
//  CityTableViewController.swift
//  Weather Application
//
//  Created by Michael Liu on 2018-01-25.
//  Copyright © 2018 cs2680. All rights reserved.
//

import Foundation
import UIKit

class CityTableViewController: UITableViewController
{
	var cities: Array<String>!

	override func viewDidLoad()
	{
		cities = ["Toronto", "Hawaii", "Vancouver", "Sydney","Regina","Markham"]

		self.tableView.reloadData()
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return cities?.count ?? 0
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as! CityTableViewCell

		cell.setCity(city: cities[indexPath.row])

		return cell
	}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let forecastTableView = segue.destination as? ForecastTableView
        let cityIndexPath = self.tableView.indexPath(for: sender as! UITableViewCell)!
        forecastTableView?.setCity(city: cities[cityIndexPath.row])
    }
}
