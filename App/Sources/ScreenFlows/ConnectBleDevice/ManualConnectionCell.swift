//
//  Created by David Laubenstein on 16.04.19.
//  Copyright © 2019 Jamit Labs GmbH. All rights reserved.
//

import Imperio
import SnapKit
import UIKit

struct ManualConnectionCellModel {
    var title: String?
    var subtitle: String?
}

class ManualConnectionCell: UITableViewCell {
    lazy var background: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.GrayScale.white
        return view
    }()

    lazy var elementStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.addArrangedSubview(cellLabel)
        stackView.addArrangedSubview(cellDescription)
        stackView.alignment = .center
        return stackView
    }()

    lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = Colors.GrayScale.darkGray
        return label
    }()

    lazy var cellDescription: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = Colors.GrayScale.gray
        return label
    }()

    override var isHighlighted: Bool {
        didSet {
            //            if (isHighlighted) {
            //                // set
            //            } else {
            //                // unset
            //            }
            // backgroundColor = .green
        }
    }

    var cellModel: ManualConnectionCellModel? {
        didSet {
            cellLabel.text = cellModel?.title
            cellDescription.text = cellModel?.subtitle
            if cellDescription.text?.isEmpty ?? false || cellDescription.text == nil {
                cellDescription.isHidden = true
            } else {
                cellDescription.isHidden = false
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(background)
        background.addSubview(elementStackView)
        backgroundColor = .clear
        setupConstraints()
    }

    func setupConstraints() {
        background.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2.5)
            make.bottom.equalToSuperview().inset(2.5)
            make.left.right.equalToSuperview().inset(10)
        }

        elementStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.height.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }

        cellLabel.snp.makeConstraints { make in
            make.left.equalTo(elementStackView.snp.left)
            make.right.equalTo(elementStackView.snp.right)
        }

        cellDescription.snp.makeConstraints { make in
            make.left.equalTo(elementStackView.snp.left)
            make.right.equalTo(elementStackView.snp.right)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
