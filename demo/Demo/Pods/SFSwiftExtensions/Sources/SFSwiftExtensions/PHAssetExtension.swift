//
//  PHAssetExtension.swift
//  LovelyPet
//
//  Created by Stroman on 2021/6/21.
//

import Foundation
import Photos
import UIKit

extension PHAsset {
    /// 根据资源获取对应的缩略图
    /// 截取中间部分
    /// - Parameter length: 给定的边长
    /// - Returns: 缩略图
    func thumbnailImage(_ length:CGFloat) -> UIImage {
        let options:PHImageRequestOptions = PHImageRequestOptions.init()
        options.isSynchronous = true
        options.deliveryMode = .fastFormat
        options.isNetworkAccessAllowed = false
        options.resizeMode = .fast
        var result:UIImage = UIImage.init()
        PHImageManager.default().requestImage(for: self, targetSize: CGSize.init(width: length, height: length), contentMode: .aspectFill, options: options) { (image, resuts) in
            if let constantImage = image {
                result = constantImage
            }
        }
        return result
    }
}
