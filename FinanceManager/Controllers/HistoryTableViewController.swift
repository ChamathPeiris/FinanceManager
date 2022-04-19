//
//  HistoryTableViewController.swift
//  FinanceManager
//
//  Created by Chamath Peiris on 2022-04-09.
//

import Foundation
import UIKit

class HistoryTableViewController: UITableViewController {
    
    ///initialization of the history string array
    var recordedHistoryArray : [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initHistoryInfo()
    }
    
    func initHistoryInfo() {
        if let vcs = self.navigationController?.viewControllers {
            let previousViewController = vcs[vcs.count - 2]
            
            if previousViewController is MortgageViewController {
                loadDefaultsData("MortgageHistory")
            } else if previousViewController is LoansViewController {
                loadDefaultsData("LoansHistory")
            } else if previousViewController is SavingsViewController {
                loadDefaultsData("SavingsHistory")
            }
        }
    }
    
    func loadDefaultsData(_ historyKey :String) {
        let defaults = UserDefaults.standard
        recordedHistoryArray = defaults.object(forKey: historyKey) as? [String] ?? [String]()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordedHistoryArray.count
    }
    
    ///populates the history table
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableHistoryCell")!
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = recordedHistoryArray[indexPath.row]
        return cell
    }
    
    
}
