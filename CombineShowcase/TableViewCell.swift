//
//  TableViewCell.swift
//  CombineShowcase
//
//  Created by Piccirilli Federico on 9/22/21.
//

import UIKit
import Combine

class TableViewCell: UITableViewCell {

    let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        return button
    }()

    enum Action {
        case print(String)
        case void
    }
    var actionPublisher = PassthroughSubject<Action, Never>()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        button.frame = contentView.bounds
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        contentView.addSubview(button)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func tapButton() {
        actionPublisher.send(.print(button.title(for: .normal) ?? "no"))
//        actionPublisher.send(.void)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
