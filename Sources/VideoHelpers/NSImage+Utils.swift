//
//  NSImage+Utils.swift
//  VideoChannelDemo
//
//  Created by Jackson Utsch on 2/22/21.
//

import VideoToolbox
import Cocoa

extension NSImage {
    public convenience init?(pixelBuffer: CVPixelBuffer, size: NSSize) {
        var cgImage: CGImage?
        VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &cgImage)

        if cgImage == nil {
            print("cgIMg = nil")
        } else {
            print("has cgimg")
        }
        
        if let cgImage = cgImage {
            self.init(cgImage: cgImage, size: size)
        }
        return nil
    }
}

public func imageFromPixelBuffer(pixelBuffer: CVPixelBuffer) -> NSImage? {
    let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
    let pixelBufferWidth = CGFloat(CVPixelBufferGetWidth(pixelBuffer))
    let pixelBufferHeight = CGFloat(CVPixelBufferGetHeight(pixelBuffer))
    let imageRect:CGRect = CGRect(x: 0, y: 0, width: pixelBufferWidth, height: pixelBufferHeight)
    let ciContext = CIContext.init()
    guard let cgImage = ciContext.createCGImage(ciImage, from: imageRect) else {
        return nil
    }
    return NSImage(cgImage: cgImage, size: NSSize(width: pixelBufferWidth, height: pixelBufferHeight))
}
