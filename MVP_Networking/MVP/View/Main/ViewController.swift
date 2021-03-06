//
//  ViewController.swift
//  MVP_Networking
//
//  Created by Kirill Drozdov on 24.06.2022.
//

import UIKit

class ViewController: UIViewController {

    lazy var tableView: UITableView = {
        var table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()

    //
    fileprivate var users       =   [UserModel]()
    fileprivate var presenter   =   UserPresenter()
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        presenter.delegate = self
        presenter.getUsers()
        print(users)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    private func sendUserData(index: Int)->String {
        let users = users[index]
        return users.name
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = sendUserData(index: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.presentAlert(indexItem: indexPath.row, userArray: users)
    }
}


extension ViewController: MainPresentDelegate {
    func presentUser(user: [UserModel]) {
        self.users = user
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func presentetAlert(titile: String, message: String) {
        print(titile)
        let alert = UIAlertController(title: titile, message: message, preferredStyle: .actionSheet)
        present(alert, animated: true)
    }
}
