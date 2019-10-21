//
//  CameraViewController.swift
//  Twitter
//
//  Created by 及川ひな on 2019/10/18.
//  Copyright © 2019 oikawa. All rights reserved.
//

import AVFoundation
import UIKit
import RxCocoa
import RxSwift

class CameraViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var cameraView: UIView!
    
    let disposeBag = DisposeBag()
    
    // カメラやマイクの入出力を管理するオブジェクトを生成
    let session = AVCaptureSession()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setCamera()
        self.setAction()

    }

    func setCamera() {
        // カメラやマイクのデバイスオブジェクトを生成
        let devices: [AVCaptureDevice] = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                         mediaType: .video,
                                                                         position: .back).devices

        //　該当するデバイスのうち最初に取得したもの(背面カメラ)を利用する
        if let backCamera = devices.first {
            do {
                // QRコードの読み取りに背面カメラの映像を利用するための設定
                let deviceInput = try AVCaptureDeviceInput(device: backCamera)

                if self.session.canAddInput(deviceInput) {
                    self.session.addInput(deviceInput)

                    // 背面カメラの映像からQRコードを検出するための設定
                    let metadataOutput = AVCaptureMetadataOutput()

                    if self.session.canAddOutput(metadataOutput) {
                        self.session.addOutput(metadataOutput)

                        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                        metadataOutput.metadataObjectTypes = [.qr]

                        // 背面カメラの映像を画面に表示するためのレイヤーを生成
                        let previewLayer = AVCaptureVideoPreviewLayer(session: self.session)
                        previewLayer.frame = self.cameraView.bounds
                        previewLayer.videoGravity = .resizeAspectFill
                        self.cameraView.layer.addSublayer(previewLayer)

                        // 読み取り開始
                        self.session.startRunning()
                    }
                }
            } catch {
                print("Error occured while creating video device input: \(error)")
            }
        }
    }

    private func setAction() {
        // フローティングボタンタップ時のアクションを定義
        self.closeButton.rx.tap.subscribe { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
            }.disposed(by: self.disposeBag)
    }

}

extension CameraViewController: AVCaptureMetadataOutputObjectsDelegate {

    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {

        for metadata in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
            // QRコードのデータかどうかの確認
            if metadata.type != .qr { continue }

            // QRコードの内容が空かどうかの確認
            if metadata.stringValue == nil { continue }

            /*
             このあたりで取得したQRコードを使ってゴニョゴニョする
             読み取りの終了・再開のタイミングは用途によって制御が異なるので注意
             以下はQRコードに紐づくWebサイトをSafariで開く例
             */

            // URLかどうかの確認
            if let url = URL(string: metadata.stringValue!) {
                // 読み取り終了
                self.session.stopRunning()
                // QRコードに紐付いたURLをSafariで開く
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                self.dismiss(animated: true, completion: nil)

                break
            }
        }
    }
}
