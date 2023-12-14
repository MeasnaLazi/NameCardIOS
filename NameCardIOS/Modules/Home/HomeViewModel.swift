//
//  HomeViewModel.swift
//  NameCardIOS
//
//  Created by Measna on 28/11/23.
//

import Foundation
import Combine
import UIKit
import Vision

class HomeViewModel : BaseViewModel, ObservableObject {
    
    private let _nameCardRepository: NameCardRepository
    
    @Published private(set) var state: ViewState = .initial
    @Published private(set) var cards: [Card] = []
    @Published private(set) var firstLoadCards: [Card] = []
    @Published private(set) var totalPage: Int = 0
    @Published private(set) var count: Int = 0
    
    override init() {
        self._nameCardRepository = NameCardRepositoryImp(requestExecute: MockAPIClient())
    }
    
    init(requestExecutor: RequestExecutor) {
        self._nameCardRepository = NameCardRepositoryImp(requestExecute: requestExecutor)
    }
    
    func onViewAppear() {
        _getAllNameCard(search: "", page: 1)
    }
    
    func onSearch(search: String, page: Int) {
        _getAllNameCard(search: search, page: page)
    }
    
    func onSearchClose() {
        self.cards = self.firstLoadCards
    }
    
    private let queue = DispatchQueue(label: "com.appskhmers.namecard", qos: .default, attributes: [], autoreleaseFrequency: .workItem)
    
    func getTextFromImage(image: UIImage) throws {
        
        guard let cgImage = image.cgImage else {
            return
        }
        
        queue.async {[weak self] in
            
            let requestHandler = VNImageRequestHandler(cgImage: cgImage)
            let request = VNRecognizeTextRequest(completionHandler: self?.recognizeTextHandler)
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
    
    private func recognizeTextHandler(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            return
        }
        
        let recognizeStrings = observations.compactMap { observation in
            return observation.topCandidates(1).first?.string
        }
        
        print("recognizeString: \(recognizeStrings)")
    }
    
    private func _getAllNameCard(search: String, page: Int) {
        
        if search.isEmpty && page == 1 && !self.firstLoadCards.isEmpty {
            self.cards = self.firstLoadCards
            return
        }
        
        state = .loading
        
        _nameCardRepository.getNameCards(search: search, page: page)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch (completion) {
                case .finished:
                    print("getAllNameCard fetcted!")
                case .failure(let err):
                    self?.state = .fail
                    print("getAllNameCard: \(err)")
            
            }
        } receiveValue: {[weak self] response in
            self?.cards = response.data ?? []
            self?.totalPage = response.totalPage
            self?.count = response.count
            self?.state = .fetched
            
            if self?.firstLoadCards.isEmpty ?? true {
                self?.firstLoadCards = self!.cards
            }
        }
        .store(in: &disposable)
    }
}
