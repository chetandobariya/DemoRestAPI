//
//  ViewController.swift
//  DemoRest
//
//  Created by Dobariya, Chetankumar || mytheresa.com on 20.10.18.
//  Copyright © 2018 Chetan Dobariya. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    private (set) var repositories = [Repositories]()
    private let refresh = UIRefreshControl()
    
    
    override func viewDidLoad() {
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = 100
        
        //tableView.rowHeight = UITableView.automaticDimension
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refresh
        } else {
            tableView.addSubview(refresh)
        }
        refresh.addTarget(self, action: #selector(refreshTableData(_:)), for: .valueChanged)
       // self.tableView?.registerNib(cellType: RepositoryCell.self)

        //TableView UITest setup
        tableView.accessibilityIdentifier = "table-repository"
        
        self.fetchOwner()
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    @objc private func refreshTableData(_ sender: Any) {
        self.reloadTableData()
    }
    
    
    private func reloadTableData(){
        
        self.refresh.endRefreshing()
        self.tableView.reloadData()
    }
    
    private func fetchOwner() {
        
        DataUpdateHelper.shared.fetchRepositoriesData { [weak self] (result) in
            
            switch result {
                
            case .failure (let error):
                print("\(#function) \(error.localizedDescription)")
                
            case .success (let repositories):
                self?.refreshRepositories(with: repositories)
            }
        }
    }
    
    private func refreshRepositories (with repositories: [Repositories]) {
        
        DispatchQueue.global(qos: .utility).sync {
            self.repositories = repositories
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


extension TableViewController  {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(cellType: RepositoryCell.self, for: indexPath)
        cell.setup(with: self.repositories[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.repositories.count
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension TableViewController  {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            
            //let webViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "webView") as? WebViewController

            let webViewController = StoryboardScene.Main.webView.instantiate()
            webViewController.repositoryItems = self.repositories[indexPath.row]
            self.navigationController?.pushViewController(webViewController, animated: true)

        }
        
    }
}
