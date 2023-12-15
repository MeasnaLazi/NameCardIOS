//
//  DetectViewModel.swift
//  NameCardIOS
//
//  Created by Measna on 14/12/23.
//

import Foundation
import Vision
import UIKit

class DetectViewModel : BaseViewModel, ObservableObject {
    
    private let queue = DispatchQueue(label: "com.appskhmers.namecard", qos: .default, attributes: [], autoreleaseFrequency: .workItem)
    private var image: UIImage?
    
    func getTextFromImage(image: UIImage) throws {
        
        guard let cgImage = image.cgImage else {
            return
        }
        
        self.image = image
        
        queue.async {[weak self] in
            
            let requestHandler = VNImageRequestHandler(cgImage: cgImage)
            let request = VNRecognizeTextRequest(completionHandler: self?._recognizeTextHandler)
            request.recognitionLanguages = ["en"]
            request.recognitionLevel = .accurate
            request.usesLanguageCorrection = false
            
            do {
                try requestHandler.perform([request])
            } catch {
                print("Unable to perform the requests: \(error).")
            }
        }
    }
    
    private func _recognizeTextHandler(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            return
        }
        
        let recognizeStrings = observations.compactMap { observation in
            return observation.topCandidates(1).first?.string
        }
        
        let boundingRects: [CGRect] = observations.compactMap { [weak self] observation in


            // Find the top observation.
            guard let candidate = observation.topCandidates(1).first else { return .zero }
            
            // Find the bounding-box observation for the string range.
            let stringRange = candidate.string.startIndex..<candidate.string.endIndex
            let boxObservation = try? candidate.boundingBox(for: stringRange)
            
            // Get the normalized CGRect value.
            let boundingBox = boxObservation?.boundingBox ?? .zero
            
            // Convert the rectangle from normalized coordinates to image coordinates.
            return VNImageRectForNormalizedRect(boundingBox,
                                                Int(self?.image?.size.width ?? 0),
                                                Int(self?.image?.size.height ?? 0))
        }
        
        recognizeStrings.forEach { item in
            _detectSubject(item)
        }
        
        print("recognizeString: \(recognizeStrings)")
        print("boundingRects: \(boundingRects)")
    }
    
    private func _detectSubject(_ text: String) {
        print("try detect: \(text)")
        
        if _isValidEmail(value: text) {
            print("This is email")
        }
        
        if _isValidPhone(value: text) {
            print("This is phone")
        }
        
        if _isValidAddress(value: text) {
            print("This is address")
        }
        
        if _isValidWebsite(value: text) {
            print("This is website")
        }
        
        let tagger = NSLinguisticTagger(tagSchemes: [.nameType], options: 0)
        tagger.string = text
//        let range = NSRange(location: 0, length: text.utf16.count)
//        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
//        let tags: [NSLinguisticTag] = [.personalName, .placeName, .organizationName]
        let range = NSRange(location: 0, length: text.utf16.count)
        let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]
        
        tagger.enumerateTags(in: range, unit: .sentence, scheme: .nameType, options: options) { tag, tokenRange, stop in
            if let tag = tag  {
                if let range = Range(tokenRange, in: text) {
                    let name = text[range]
                    print("\(name): \(tag)")
                }
            }
        }
    }
    
    private func _isValidEmail(value: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let test = NSPredicate(format:"SELF MATCHES %@", regex)
        
        return test.evaluate(with: value.filter { !$0.isWhitespace })
    }
    
    private func _isValidPhone(value: String) -> Bool {
        let regex = "^(0|\\+855)\\d{8,9}$"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return test.evaluate(with: value.filter { !$0.isWhitespace })
    }
    
    private func _isValidAddress(value: String) -> Bool {
        let count = value.filter { $0 == "," }.count
        
        return count > 2
    }
    
    private func _isValidWebsite(value: String) -> Bool {
        let regex = "(https?:\\/\\/(?:www\\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\\.[^\\s]{2,}|www\\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\\.[^\\s]{2,}|https?:\\/\\/(?:www\\.|(?!www))[a-zA-Z0-9]+\\.[^\\s]{2,}|www\\.[a-zA-Z0-9]+\\.[^\\s]{2,})"
        let test = NSPredicate(format:"SELF MATCHES %@", regex)
        
        return test.evaluate(with: value.filter { !$0.isWhitespace })
    }
    
    private func _isValidPosition(value: String) -> Bool {
        // TODO
        return value.hasSuffix("Manager")
    }
    
    private func _isValidCompanyName(value: String) -> Bool {
        // TODO: could be count text that contain more than 2
        return value.hasSuffix("Manager")
    }
}
