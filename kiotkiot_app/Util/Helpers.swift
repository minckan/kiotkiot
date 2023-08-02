//
//  Helpers.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/05.
//

import UIKit
import TAKUUID

func createAndGetUUID() -> String? {
    TAKUUIDStorage.sharedInstance().migrate()
    return TAKUUIDStorage.sharedInstance().findOrCreate()
}

func getFontName() {
    for family in UIFont.familyNames {
        
        let sName: String = family as String
        print("family: \(sName)")
        
        for name in UIFont.fontNames(forFamilyName: sName) {
            print("name: \(name as String)")
        }
    }
}

// 뷰를 이미지로 저장하는 함수
func saveViewAsImage(view: UIView) {
    let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
    print("[SAVE_VIEW] 이미지 저장 호출")
    let image = renderer.image { context in
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
    }
    
    if let imageData = image.pngData() { // 또는 jpegData(compressionQuality: 1.0)로 저장할 수도 있습니다.
        // 이미지 데이터를 파일로 저장 (이 부분을 앱의 필요한 위치로 변경하세요)
        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent("todays_weather.png")
        do {
            try imageData.write(to: fileURL)
            print("[SAVE_VIEW] 이미지 저장 성공: \(fileURL.absoluteString)")
            saveData(key: Const.shared.SHARE_IMAGE, value: fileURL.absoluteString)
            
        } catch {
            print("[SAVE_VIEW] 이미지 저장 실패: \(error)")
        }
    }
    
    print("[SAVE_VIEW] 이미지 저장 종료")
}


public func printDebug(_ message: Any) {
    print("DEBUG: \(message)")
}

public func printWithLabel(label: String, message: Any) {
    print("[\(label)] \(message)")
}

public func printSuccessWithLabel(label: String, message: Any) {
    print("⭐️Success⭐️[\(label)] \(message)")
}

public func printErrorWithLabel(label: String, message: Any) {
    print("❗️Error❗️[\(label)] \(message)")
}

public func saveData(key : String, value: Any) {
    UserDefaults.standard.set(value, forKey: String(key))
}

public func getData(key:String) -> String? {

    return  UserDefaults.standard.string(forKey: key)
}
