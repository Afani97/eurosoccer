//
//  ViewController.swift
//  EuroSoccer
//
//  Created by Aristotel Fani on 9/18/20.
//  Copyright © 2020 Aristotel Fani. All rights reserved.
//

import UIKit

public enum League: String, CaseIterable {
    case premierLeague = "Premier League"
    case primeraDivision = "Primera Division"
    case bundesliga = "Bundesliga"
    case seriaA = "Serie A"
    case ligueOne = "Ligue 1"
}

class ScoresTableViewController: ESLoadingViewController {
    
    let tableView = UITableView()
    var scores = [League: [Match]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        title = "Euro Scores"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(getTodaysMatches))
        
        getTodaysMatches()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame         = view.bounds
        tableView.rowHeight     = 125
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.removeExcessCells()
        tableView.separatorColor = .clear
        
        tableView.register(ScoreCell.self, forCellReuseIdentifier: ScoreCell.reuseID)
        tableView.register(ScheduledGameCell.self, forCellReuseIdentifier: ScheduledGameCell.reuseID)
    }
    
    @objc func getTodaysMatches() {
        showLoadingView()
        NetworkManager.getMatches { [weak self] result in
            guard let self = self else { return }
        
            self.dismissLoadingView()
            
            switch result {
            case .success(let scores):
                DispatchQueue.main.async {
                    self.scores = scores
                    self.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showEmptyStateView(with: error.rawValue, in: self.view)
                    self.navigationItem.rightBarButtonItem?.isEnabled = false
                }
            }
        }
    }
}

extension ScoresTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return League.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scores[League.allCases[section]]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let league = League.allCases[indexPath.section]
        if let matches = self.scores[league], matches.count > 0 {
            let match = matches[indexPath.row]
            return getCorrectCell(match, tableView: tableView)
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let league = League.allCases[section]
        if let matches = self.scores[league], matches.count > 0 {
            return 75
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 75))
        headerView.backgroundColor = .systemBackground
        
        let bottomBorder = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 1))
        bottomBorder.backgroundColor = .lightGray

        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = League.allCases[section].rawValue
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = UIColor.label
        label.textAlignment = .center

        headerView.addSubview(bottomBorder)
        headerView.addSubview(label)

        return headerView
    }
}
