//
//  UploadFileViewController.swift
//  NetworkLayer
//
//  Created by linto jacob on 15/07/20.
//  Copyright © 2020 linto. All rights reserved.
//

import UIKit
import LJNetworkLayer


class uploadFileViewController: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
      //  uploadSingleFile()
        //uploadMultipleFiles()
    }
    
//
//    func uploadSingleFile() {
//        let fileURL = Bundle.main.url(forResource: "sampleText", withExtension: "txt")
//        let fileInfo = Upload.FileInfo(withFileURL: fileURL, filename: "sampleText.txt", name: "uploadedFile", mimetype: "text/plain")
//
//        LJ.upload(files: <#T##[Upload.FileInfo]#>, toURL: <#T##URL#>, withHttpMethod: <#T##HTTPMethod#>, devKey: <#T##String#>, completion: <#T##(Upload.Results, [String]?) -> Void##(Upload.Results, [String]?) -> Void##(_ result: Upload.Results, _ failedFiles: [String]?) -> Void#>)
//
//
//        LJ.re.httpBodyParameters.add(value: "Hello 😀 !!!", forKey: "greeting")
//        rest.httpBodyParameters.add(value: "AppCoda", forKey: "user")
//
//        //https://angular-file-upload-cors-srv.appspot.com/upload
//        //http://localhost:3000/upload
//        upload(files: [fileInfo], toURL: URL(string: "https://angular-file-upload-cors-srv.appspot.com/upload"))
//    }
//
//
//
//    func uploadMultipleFiles() {
//        let textFileURL = Bundle.main.url(forResource: "sampleText", withExtension: "txt")
//        let textFileInfo = Upload.FileInfo(withFileURL: textFileURL, filename: "sampleText.txt", name: "uploadedFile[1]", mimetype: "text/plain")
//
//        let pdfFileURL = Bundle.main.url(forResource: "samplePDF", withExtension: "pdf")
//        let pdfFileInfo = Upload.FileInfo(withFileURL: pdfFileURL, filename: "samplePDF.pdf", name: "uploadedFile[2]", mimetype: "application/pdf")
//
//        let imageFileURL = Bundle.main.url(forResource: "sampleImage", withExtension: "jpg")
//        let imageFileInfo = Upload.FileInfo(withFileURL: imageFileURL, filename: "sampleImage.jpg", name: "uploadedFile[3]", mimetype: "image/jpg")
//
//        upload(files: [textFileInfo, pdfFileInfo, imageFileInfo], toURL: URL(string: "http://localhost:3000/multiupload"))
//    }
//
//
//
//    func upload(files: [Upload.FileInfo], toURL url: URL?) {
//        if let uploadURL = url {
//            LJ.upload(files: files, toURL: uploadURL, withHttpMethod: .post) { (results, failedFilesList) in
//                print("HTTP status code:", results.response?.httpStatusCode ?? 0)
//
//                if let error = results.error {
//                    print(error)
//                }
//
//                if let data = results.data {
//                    if let toDictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
//                        print(toDictionary)
//                    }
//                }
//
//                if let failedFiles = failedFilesList {
//                    for file in failedFiles {
//                        print(file)
//                    }
//                }
//            }
//        }
//    }
//
}


