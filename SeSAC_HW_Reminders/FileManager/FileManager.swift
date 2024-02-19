//
//  FileManager.swift
//  SeSAC_HW_Reminders
//
//  Created by 박지은 on 2/19/24.
//

import UIKit

extension UIViewController {
    // 이미지를 앱 도큐먼트에 저장하는 경로
    // 이미지를 -> 파일 이름 정하고 -> document에 저장해야되니까
    func saveImageToDocument(image: UIImage, fileName: String) {
       // 1. 도큐먼트 파일 위치 얻는 코드
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        // 2. 그 파일에 이미지 파일 이름 지정
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).jpg")
        // 3. 이미지 파일 압축
        let data = image.jpegData(compressionQuality: 0.5)
        
        do {
            try data?.write(to: fileURL)
        } catch {
            print(error)
        }
    }

    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        } else {
            return UIImage(systemName: "")
        }
    }
    
}

