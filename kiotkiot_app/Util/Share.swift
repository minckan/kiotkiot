//
//  Share.swift
//  kiotkiot_app
//
//  Created by MZ01-MINCKAN on 2023/06/20.
//

import UIKit
import LinkPresentation
import Foundation

class LinkPresentationItemSource: NSObject, UIActivityItemSource {
    var linkMetaData = LPLinkMetadata()
    
    // Prepare data to share
    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        return linkMetaData
    }
    
    // Placeholder for real data, we don't care in this example so just return a simple string
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return "Placeholder"
    }
    
    // Return the data will be shared
    // - Parameters:
    //  - activityType: Ex: mail, message, airdrop, etc...
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return linkMetaData.originalURL
    }
    
    init(metadata: LPLinkMetadata) {
        self.linkMetaData = metadata
    }
    
}

func getMetadataForSharingManually(title: String, url: URL?, fileName: String?, fileType: String?, image: UIImage?) -> LPLinkMetadata {
    let linkMetaData = LPLinkMetadata()
    
    if let image = image {
        linkMetaData.iconProvider = NSItemProvider(object: image)
        linkMetaData.imageProvider = NSItemProvider(object: image)
    }
    
    if let url = url {
        linkMetaData.originalURL = url
    }

    linkMetaData.title = title
    return linkMetaData


}
