//
//  RecordViewController.swift
//  SoundRecording
//
//  Created by Денис Магильницкий on 21/01/2020.
//  Copyright © 2020 Денис Магильницкий. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - Enum states of record and stop
private enum StateRecording {
    case record
    case stop
    
    var change: StateRecording {
        switch self {
        case .record:
            return .stop
        case .stop:
            return .record
        }
    }
}
// MARK: - Enum states of pause and resume
private enum AdditionalControl {
    case pause
    case resume
    
    var changeControl: AdditionalControl {
        switch self {
        case .pause:
            return .resume
        case .resume:
            return .pause
        }
    }
}

class RecordViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var soundRecLabel: UILabel!
    @IBOutlet private weak var visualView: UIView!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var recordButtonView: UIView!
    @IBOutlet private weak var pauseButtonView: UIView!
    
    // MARK: - Private Properties
    
    private var recordView: UIView = {
        let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
        let view = UIView(frame: rect)
        view.layer.cornerRadius = view.bounds.width / 2
        view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var pauseView: UIView = {
        let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
        let image = UIImageView(frame: rect)
        image.image = SourceImages.pauseImage
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var recordState: StateRecording = .stop
    private var controlState: AdditionalControl = .pause
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItem()
        addTapGestureRecognizer()
       
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        configureRecordButton()
        configurePauseButton()
    }

}

// MARK: - Private Functions

private extension RecordViewController {
    func configureNavigationItem() {
        navigationItem.title = "Recording"
    }
    
    func configureRecordButton() {
        recordButtonView.backgroundColor = UIColor.clear
        recordButtonView.layer.borderWidth = 2
        recordButtonView.layer.borderColor = UIColor.white.cgColor
        recordButtonView.layer.cornerRadius = recordButtonView.bounds.width / 2
        
        recordButtonView.addSubview(recordView)
        
        // recordViewConstraints
        
        recordView.topAnchor.constraint(equalTo: recordButtonView.topAnchor, constant: 5).isActive = true
        recordView.bottomAnchor.constraint(equalTo: recordButtonView.bottomAnchor, constant: -5).isActive = true
        recordView.leadingAnchor.constraint(equalTo: recordButtonView.leadingAnchor, constant: 5).isActive = true
        recordView.trailingAnchor.constraint(equalTo: recordButtonView.trailingAnchor, constant: -5).isActive = true
    }
    
    func configurePauseButton() {
        pauseButtonView.backgroundColor = UIColor.clear
        pauseButtonView.layer.borderWidth = 2
        pauseButtonView.layer.borderColor = UIColor.white.cgColor
        pauseButtonView.layer.cornerRadius = pauseButtonView.bounds.width / 2
        
        pauseButtonView.addSubview(pauseView)
        
        pauseButtonView.isHidden = true
        
        // recordViewConstraints
        
        pauseView.topAnchor.constraint(equalTo: pauseButtonView.topAnchor, constant: 5).isActive = true
        pauseView.bottomAnchor.constraint(equalTo: pauseButtonView.bottomAnchor, constant: -5).isActive = true
        pauseView.leadingAnchor.constraint(equalTo: pauseButtonView.leadingAnchor, constant: 5).isActive = true
        pauseView.trailingAnchor.constraint(equalTo: pauseButtonView.trailingAnchor, constant: -5).isActive = true
    }
    
    func addTapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let touch = sender.location(in: self.view)
        let recViewFrameInSuperView = recordView.convert(recordView.bounds, to: self.view)
        let pauseViewFrameInSuperView = pauseView.convert(pauseView.bounds, to: self.view)
        
        // TODO: - Add control of switching states
        if sender.state == .ended {
            if recViewFrameInSuperView.contains(touch) {
                toggleState()
            }
        }
    }
    
    func toggleState() {
        if recordState == .stop {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
                self.recordView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                self.recordView.layer.cornerRadius = 8
            }) { (finished) in
                self.recordState = self.recordState.change
                print("State = \(self.recordState)")
            }
        }
        if recordState == .record {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseInOut, animations: {
                self.recordView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.recordView.layer.cornerRadius = self.recordView.bounds.width / 2
            }) { (finished) in
                self.recordState = self.recordState.change
                print("State = \(self.recordState)")
            }
        }
    }
}

// MARK: - AVAudioPlayerDelegate

extension RecordViewController: AVAudioPlayerDelegate {
    
}

// MARK: - AVAudioRecorderDelegate

extension RecordViewController: AVAudioRecorderDelegate {
    
}
