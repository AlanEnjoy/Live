//
//  ViewController.swift
//  VidioCapture
//
//  Created by Alan's Macbook on 2017/8/24.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
   fileprivate lazy var videoQueue = DispatchQueue.global()
   fileprivate lazy var audioQueue = DispatchQueue.global()
    
   fileprivate lazy var session : AVCaptureSession = AVCaptureSession()
   fileprivate lazy var previewLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session:self.session)
    
   fileprivate var videoOutput : AVCaptureVideoDataOutput?
   fileprivate var videoInput : AVCaptureDeviceInput?

    }

//MARK:- 视频开始采集和停止采集
extension ViewController {
    
    @IBAction func startCapture() {
        //1.设置视频的输入输出
        setupVideo()
        
        //2.设置音频的输入和输出
        setupAudio()
        
        //3.给用户看到一个预览图层
        previewLayer.frame = view.bounds
        view.layer.insertSublayer(previewLayer, at: 0)
        
        //4.开始采集
        session.startRunning()
        
    }
    
   @IBAction func stopCapture() {
        removeVideo()
        session.stopRunning()

        previewLayer.removeFromSuperlayer()

    
    }
    
    @IBAction func switchScence() {
        //1.获取之前的镜头
        guard var position = videoInput?.device.position else { return }
        
        //2.获取当前应该显示的镜头
        position = position == .front ? .back : .front
        
        //3.根据当前镜头创建新的device
        let devices = 
        guard let device = devices?.filter({$0.position == position}).first else { return }
        
        //4.根据新的device创建新的input
        guard let videoInput =  try? AVCaptureDeviceInput(device: device) else { return }
        
        //5.在session中切换Input
        session.beginConfiguration()
        session.removeInput(self.videoInput)
        session.addInput(videoInput)
        session.commitConfiguration()
        self.videoInput = videoInput
        
    }
}

extension ViewController {
    fileprivate func setupVideo() {
       
        guard let device = AVCaptureDevice.defaultDevice(withDeviceType: AVCaptureDeviceType.builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .front) else { return }
        
        
        //2.2 通过device创建AVCaptureInput对象
        guard let videoInput = try? AVCaptureDeviceInput(device: device) else { return }
        self.videoInput = videoInput
        
        //2.3 将input添加到会话中
        session.addInput(videoInput)
        
        //3.给捕捉会话设置输出源
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        session.addOutput(videoOutput)
        
        //4.获取Video对应的Connection
        self.videoOutput = videoOutput

        
    }
    fileprivate func removeVideo() {
        
        guard let device = AVCaptureDevice.defaultDevice(withDeviceType: AVCaptureDeviceType.builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .front) else { return }
        
        
        //2.2 通过device创建AVCaptureInput对象
        guard let vedioInput = try? AVCaptureDeviceInput(device: device) else { return }
        
        //2.3 将input移除
        session.removeInput(vedioInput)
        
        //3.给捕捉会话设置输出源
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        session.removeOutput(videoOutput)
        
        }
    fileprivate func setupAudio() {
        //1.设置音频的输入
        //1.1 获取话筒设备
        guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio) else { return }
        
        //1.2 根据device创建AVCaputureInput
        guard let audioInput = try? AVCaptureDeviceInput(device:device) else { return }
        
        //1.3 将input添加到会话中
        session.addInput(audioInput)
        
        //2.给会话设置音频输出源
        let audioOutput = AVCaptureAudioDataOutput()
        audioOutput.setSampleBufferDelegate(self, queue: audioQueue)
        session.addOutput(audioOutput)
    
    }
}

//MARK: 获取数据
extension ViewController : AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        if connection == videoOutput?.connection(withMediaType: AVMediaTypeVideo){
            print("采集到视频数据")
        }
        else {
            print("采集到音频数据")
        }
    }
}




