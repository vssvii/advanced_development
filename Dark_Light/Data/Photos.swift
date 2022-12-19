//
//  Photos.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 20.08.2022.
//

import UIKit

var dataPhotos: [UIImage?] = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"), UIImage(named: "6"), UIImage(named: "7"), UIImage(named: "8"), UIImage(named: "9"), UIImage(named: "10"), UIImage(named: "11"), UIImage(named: "12"), UIImage(named: "13"), UIImage(named: "14"), UIImage(named: "15"), UIImage(named: "16"), UIImage(named: "17"), UIImage(named: "18"), UIImage(named: "19"), UIImage(named: "20")]

var dataPhotosSafely: [UIImage] = []

func checkOptional(images: [UIImage?]) {
    images.forEach{ if $0 != nil {dataPhotosSafely.append($0!)} else {return}}
}
