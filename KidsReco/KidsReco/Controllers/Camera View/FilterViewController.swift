//
//  FilterViewController.swift
//  IntergrateMLModel
//
//  Created by Khanh Vu on 26/03/5 Reiwa.
//

import UIKit
import SnapKit
import AVFoundation
import Vision

class FilterViewController: BaseViewController {
    
    private lazy var btnCancel: UIButton = {
        let btn = UIButton()
        btn.setImage(Constants.Image.cancelSystem, for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(btnCancelTapped(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var vTop: UIView = {
        let v = UIView()
        v.addSubview(btnCancel)
        v.backgroundColor = .clear
        return v
    }()
    
    private lazy var vContent: UIView = {
        let v = UIView()
        [cameraView, detailView].forEach { sub in
            v.addSubview(sub)
        }
        v.backgroundColor = .clear
        return v
    }()
    
    private lazy var stvBottom: UIStackView = {
        let stv = UIStackView()
        return stv
    }()
    
    private lazy var vAction: UIView = {
        let v = UIView()
        [imvLibrary, vCapture, btnReloadCamera].forEach { sub in
            v.addSubview(sub)
        }
        v.backgroundColor = .clear
        return v
    }()
    
    private lazy var vCapture: CustomCaptureButton = {
        let vCapture = CustomCaptureButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        return vCapture
    }()

    
    private lazy var imvLibrary: UIImageView = {
        let imv = UIImageView()
        imv.addConnerRadius(radius: 10)
        imv.addBorder(borderWidth: 2, borderColor: .white)
        imv.contentMode = .scaleAspectFill
        imv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(btnLibraryTapped(_:))))
        imv.isUserInteractionEnabled = true
        return imv
    }()
    
    private lazy var btnReloadCamera: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setBackgroundImage(Constants.Image.reloadSystem, for: .normal)
        btn.tintColor = .white
        btn.addConnerRadius(radius: 10)
        btn.addTarget(self, action: #selector(btnReloadTapped(_:)), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
    
    // khai báo label hiển thị tên của loài hoa
    private lazy var lbIdentifier: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.text = "Identifier"
        lb.textAlignment = .center
        return lb
    }()
    
    // khai báo label hiển thị độ tin cậy
    private lazy var lbMatch: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.text = "Math"
        lb.textAlignment = .center
        return lb
    }()
    private lazy var vIdentifier: UIView = {
        let v = UIView()
        [lbIdentifier, lbMatch].forEach { sub in
            v.addSubview(sub)
        }
        v.backgroundColor = .clear
        return v
    }()
    private lazy var stvAction: UIStackView = {
        let stv = UIStackView()
        [vAction, vIdentifier].forEach { sub in
            stv.addArrangedSubview(sub)
        }
        stv.distribution = .equalCentering
        stv.axis = .vertical
        stv.alignment = .fill
        stv.spacing = 10
        return stv
    }()
    
    private var cameraView: CameraView!
    private var detailView: DetailImageView!
    private var coremlRequest: VNCoreMLRequest?
    
    var isCaptured = false
    let viewModel = FilterViewModel()
    var leadTrailingVContentConstraint: Constraint?
    weak var tabbarDelegate: MainTabbarDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        cameraView = CameraView(cameraType: .video)
        detailView = DetailImageView()
        self.setUpView()
        self.bindEvented()
        predict()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cameraView.startSession()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.cameraView.setUpPreviewLayer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.cameraView.stopSession()
    }
    
    // set up view hiển thị
    func setUpView() {
        self.view.backgroundColor = UIColor(hexString: "#242121")
        self.cameraView.isHidden = false
        self.detailView.isHidden = true
        [vTop, vContent, stvAction].forEach { sub in
            self.view.addSubview(sub)
        }
        self.vTop.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        self.vContent.snp.makeConstraints { make in
            leadTrailingVContentConstraint = make.leading.trailing.equalToSuperview().inset(5).constraint
            make.top.equalTo(self.vTop.snp.bottom)
        }
        
        self.stvAction.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.vContent.snp.bottom).offset(20)
            make.bottom.greaterThanOrEqualTo(self.view.safeAreaLayoutGuide)
        }
        self.vAction.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
        self.lbIdentifier.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
        }
        self.lbMatch.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.lbIdentifier.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        self.btnCancel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(self.btnCancel.snp.height)
            make.trailing.equalToSuperview().offset(-10)
        }
        self.cameraView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        self.detailView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        self.vCapture.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(80)
        }
        self.btnReloadCamera.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        self.imvLibrary.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("aaa")
        let vContentSize = vContent.frame.size
        let ratio = vContentSize.height/vContentSize.width
        print("ratio", ratio)
        print(CGFloat(4.0/3.0))
        if ratio > CGFloat(4.0/3.0) {
            self.vContent.snp.makeConstraints { make in
                make.height.equalTo(self.vContent.snp.width).multipliedBy(4.0/3.0)
            }
        } else if ratio < 4.0/3.0 {
            leadTrailingVContentConstraint?.deactivate()
            self.vContent.snp.makeConstraints { make in
                make.width.equalTo(self.vContent.snp.height).multipliedBy(3.0/4.0)
                make.centerX.equalToSuperview()
            }
        }
    }
    
    func bindEvented() {
        self.requestPermissionAccessPhotos { [weak self] isAccess in
            guard let strongSelf = self else {
                return
            }
            if isAccess {
                strongSelf.viewModel.fetchFirstAssets(imageSize: strongSelf.imvLibrary.frame.size) { [weak self] image in
                    DispatchQueue.main.async {
                        self?.imvLibrary.image = image
                    }
                }
            } else {
                self?.showAlertOpenSettingPhotos()
            }
        }
        
        self.vCapture.actionTapEnter = { [weak self] in
            if self?.isCaptured == false {
                if self?.cameraView.outputType == .video {
                    self?.cameraView.isCapture = true
                } else {
                    self?.showAlertSetting(title: "App", message: "Not mode Photos")
                }
            } else {
                let webVC = WikiWebViewViewController(title: self?.lbIdentifier.text ?? "")
                let navWeb = UINavigationController(rootViewController: webVC)
                self?.present(navWeb, animated: true, completion: nil)
            }
        }
        
        self.cameraView.actionShowAlertSettingCamera = { [weak self] in
            self?.showAlertOpenSettingCamera()
        }
        
        self.cameraView.actionShowAlertWithMessage = { [weak self] message in
            self?.showAlert(title: "App", message: message)
        }
        
        self.cameraView.actionCaptureImage = { [weak self] image in
            DispatchQueue.main.async {
                self?.detailView.setImage(with: image)
                self?.updateUIWhenCaptured(isCaptured: true)
                DispatchQueue.global().sync {
                    guard let coremlRequest = self?.coremlRequest else {
                        return
                    }
                    // request handle image
                    let bufferImage = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
                    
                    do {
                        try bufferImage.perform([coremlRequest])
                    } catch {
                        print("cant perform predict: ", error)
                    }
                }
            }
        }
        
        self.cameraView.actionGetFrameCamera = { [weak self] frame in
            if self?.isCaptured == false {
                DispatchQueue.global().sync {
                    guard let coremlRequest = self?.coremlRequest else {
                        return
                    }
                    let bufferImage = VNImageRequestHandler(cvPixelBuffer: frame, options: [:])
                    
                    do {
                        try bufferImage.perform([coremlRequest])
                    } catch {
                        print("cant perform predict: ", error)
                    }
                }
            }
        }
    }
    
    // load model flower classification và thực hiện xử lí khi có kết quả trả về
    private func predict() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            // load model với VNCoreMLModel
            guard let model = try? VNCoreMLModel(for: efficientnet(configuration: MLModelConfiguration()).model) else {
                fatalError("Model initilation failed!")
            }
            // tạo request
            let coremlRequest = VNCoreMLRequest(model: model) { [weak self] request, error in
                guard let self = self else {
                    return
                }
                DispatchQueue.main.async {
                    if let results = request.results {
                        // handle khi có kết quả trả về
                        self.handleRequest(results)
                    }
                }
            }
            coremlRequest.imageCropAndScaleOption = .scaleFill
            self?.coremlRequest = coremlRequest
        }
    }
    
    // func xử lí kết quả trả về sau khi nhận diện ảnh
    func handleRequest(_ results: [Any]) {
        if let results = results as? [VNClassificationObservation] {
            print("\(results.first!.identifier) : \(results.first!.confidence)")
            let name = results.first!.identifier
            let confidence = Double(results.first!.confidence)
            // check nếu confidence < 0.7 thì hiển thị unknow còn nếu >= 0.7 hiển thị ra identifier và confidence của kết quả đó
            
            if  confidence <= 0.5{
                DispatchQueue.main.async {
                    self.lbIdentifier.text = "Unkown"
                    self.lbMatch.text = ""
                }
            } else {
                DispatchQueue.main.async {
                    self.lbIdentifier.text = name
                    self.lbMatch.text = "Match: \((confidence * 100.0).rounded(toPlaces: 2))%"
                }
            }
        }
    }
    
    override func setImageFromImagePicker(image: UIImage) {
        // hiển thị ra màn hình
        self.detailView.setImage(with: image)
        self.updateUIWhenCaptured(isCaptured: true)
        // xử lí nhận diện bằng model
        DispatchQueue.global().sync {
            guard let coremlRequest = self.coremlRequest else {
                return
            }
            let bufferImage = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
            
            do {
                try bufferImage.perform([coremlRequest])
            } catch {
                print("cant perform predict: ", error)
            }
        }
    }

    
    @objc func btnCancelTapped(_ sender: UIButton) {
        sender.dimButton()
        self.tabbarDelegate?.goToViewController(with: 0, isHideTabbar: false)
    }
    
    @objc func btnLibraryTapped(_ sender: UIButton) {
        sender.dimButton()
        self.openLibrary()
    }
    
    @objc func btnReloadTapped(_ sender: UIButton) {
        sender.dimButton()
        self.updateUIWhenCaptured(isCaptured: false)
    }
    
    func updateUIWhenCaptured(isCaptured: Bool) {
        self.cameraView.isHidden = isCaptured
        self.detailView.isHidden = !isCaptured
        self.isCaptured = isCaptured
        self.vCapture.showCheckMark(isShow: isCaptured)
        self.imvLibrary.isHidden = isCaptured
        self.btnReloadCamera.isHidden = !isCaptured
    }
}

