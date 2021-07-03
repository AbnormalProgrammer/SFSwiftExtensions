//
//  PHPickerResultExtension.swift
//  LovelyPet
//
//  Created by Stroman on 2021/6/21.
//

import Foundation
import PhotosUI

extension PHPickerResult {
    /// 根据PHPickerResult的数组
    /// 获取到对应的图片
    /// - Parameter inputs: 检索出来的结果
    /// - Returns: 原图
    static func gainImagesFrom(_ inputs:[PHPickerResult]) -> [UIImage] {
        let itemProviders:[NSItemProvider] = inputs.map(\.itemProvider)
        var itemProvidersIterator:IndexingIterator<[NSItemProvider]> = itemProviders.makeIterator()
        var result:[UIImage] = [UIImage].init()
        let sem:DispatchSemaphore = DispatchSemaphore.init(value: 0)
        let dispatchGroup:DispatchGroup = DispatchGroup.init()
        while let itemProvider = itemProvidersIterator.next() {
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                DispatchQueue.global().async(group: dispatchGroup, execute: DispatchWorkItem.init(block: {
                    dispatchGroup.enter()
                    itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        if let constantImage = image as? UIImage {
                            result.append(constantImage)
                        }
                        dispatchGroup.leave()
                    }
                }))
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.global(), work: DispatchWorkItem.init(block: {
            sem.signal()
        }))
        sem.wait(timeout: DispatchTime.distantFuture)
        return result
    }
}
