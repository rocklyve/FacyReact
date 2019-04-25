//
//  Created by David Laubenstein on 15.04.19.
//  Copyright © 2019 DavidLaubenstein. All rights reserved.
//

import HandySwift
import Imperio
import SnapKit
import UIKit

struct SettingsCellModel {
    var title: String?
    var subtitle: String?
    var icon: UIImage?
}

class SettingsCell: UITableViewCell {
    lazy var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = Colors.Vibrants.orange
        return imageView
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
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = Colors.GrayScale.darkGray
        return label
    }()

    lazy var cellDescription: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = Colors.Vibrants.orange
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

    var cellModel: SettingsCellModel? {
        didSet {
            icon.image = cellModel?.icon
            cellLabel.isHidden = cellModel?.title?.isBlank ?? true
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
        addSubview(icon)
        addSubview(elementStackView)
        setupConstraints()
    }

    func setupConstraints() {
        icon.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }

        elementStackView.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(16)
            make.height.equalToSuperview().inset(5)
            make.centerY.equalTo(icon.snp.centerY).inset(20)
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
