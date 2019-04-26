//
//  Created by David on 06.04.2019.
//  Copyright © 2017 DavidLaubenstein. All rights reserved.
//

import ARKit
import SceneKit
import SnapKit
import UIKit

protocol MainFlowDelegate: AnyObject {
    func connectBleDevice()
    func prepareGameStart()
    func didPrepareGameStart()
    func settings()
}

class MainViewController: UIViewController, ARSessionDelegate {
    weak var flowDelegate: MainFlowDelegate?

    lazy var startPlayButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.Vibrants.softBlue
        button.layer.cornerRadius = 50
        button.setTitle("Start", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.7
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        button.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        return button
    }()

    lazy var gameCounterView: UIView = {
        let view = UIView()
        view.addSubview(gameCounterLabel)
        view.backgroundColor = Colors.Vibrants.softBlue
        view.layer.cornerRadius = 50
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.7
        return view
    }()

    lazy var gameActionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        label.backgroundColor = Colors.Vibrants.softBlue
        label.clipsToBounds = true
        label.layer.cornerRadius = 50
        label.textColor = .white
        return label
    }()

    lazy var gameCounterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        label.textColor = .white
        label.text = "0"
        return label
    }()

    lazy var sceneView = ARSCNView()

    var contentController: VirtualContentController = TexturedFace()

    var currentFaceAnchor: ARFaceAnchor?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // view.addSubview(header)
        sceneView.addSubview(startPlayButton)
        sceneView.addSubview(gameCounterView)
        sceneView.addSubview(gameActionLabel)
        gameActionLabel.isHidden = true
        view.addSubview(sceneView)

        setupNavigationController(withBarColor: .default)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Images.settings,
            style: .plain,
            target: self,
            action: #selector(settingsPressed)
        )

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Images.signal,
            style: .plain,
            target: self,
            action: #selector(bleConnectionPressed)
        )

        setupConstraints()

        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        sceneView.delegate = self
        sceneView.session.delegate = self
        sceneView.automaticallyUpdatesLighting = true
        contentController.flowDelegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // AR experiences typically involve moving the device without
        // touch input for some time, so prevent auto screen dimming.
        UIApplication.shared.isIdleTimerDisabled = true

        // "Reset" to run the AR session for the first time.
        resetTracking()
    }

    @objc
    func settingsPressed() {
        flowDelegate?.settings()
    }

    @objc
    func bleConnectionPressed() {
        if BluetoothConnector.global.isConnected {
            // TODO: open popup which shows information about the connected Wearable
        } else {
            flowDelegate?.connectBleDevice()
        }
    }

    @objc
    func startButtonPressed() {
        flowDelegate?.prepareGameStart()
    }

    // MARK: - SnapKit Constraints
    func setupConstraints() {
        sceneView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        startPlayButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(100)
        }

        gameCounterView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(32)
            make.right.equalToSuperview().inset(32)
            make.height.width.equalTo(100)
        }

        gameCounterLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalToSuperview().inset(10)
        }

        gameActionLabel.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(250)
            make.top.equalToSuperview().offset(122)
            make.right.equalToSuperview().inset(32)
        }
    }
}
