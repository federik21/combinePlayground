//
//  ViewController.swift
//  CombineShowcase
//
//  Created by Piccirilli Federico on 9/22/21.
//

import UIKit
import Combine

class ViewController: UIViewController {

    var observables: [AnyCancellable] = []

    var datasource: [String] = []

    enum CellReuseIdentifier {
        static let id = "myCell"
    }

    var tableView: UITableView = {
        let tv = UITableView()
        tv.register(TableViewCell.self, forCellReuseIdentifier: "myCell")
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = view.bounds
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ApiModel().getStuff()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { received in
                switch received {
                case .finished:
                    break
                case .failure(let error):
                    fatalError(error.localizedDescription)
                }}, receiveValue: {
                [weak self] value in
                self?.datasource = value
                self?.tableView.reloadData()
                }).store(in: &observables)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.id, for: indexPath) as! TableViewCell
        cell.button.setTitle(datasource[indexPath.row], for: .normal)
        cell.actionPublisher
            .sink(receiveValue: { action in
                switch action {
                case .print(let message):
                    print(message)
                case .void:
                    print("no message")
                }
            }).store(in: &observables)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

}
