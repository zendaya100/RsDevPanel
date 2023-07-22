//
//  RSDevPanelPagesView.swift
//

//import UIKit
//import SnapKit
//
//protocol RSDevPanelPagesViewDelegate: AnyObject {
//    func pagesViewDidChanged(page: Int)
//}
//
//final class RSDevPanelPagesView: RSDevPanelBaseView {
//    weak var delegate: RSDevPanelPagesViewDelegate?
//
//    private let pageControl = UIPageControl()
//
//    private var currentPage: Int = 0
//    private var numberOfPages: Int = 0
//
//    // MARK: - Overrides functions
//
//    override func addSubviews() {
//        super.addSubviews()
//        addSubview(pageControl)
//    }
//
//    override func makeConstraints() {
//        super.makeConstraints()
//        pageControl.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//    }
//
//    override func configure() {
//        super.configure()
//        pageControl.hidesForSinglePage = true
//        pageControl.addTarget(self, action: #selector(handlePageValueChanged), for: .valueChanged)
//        updateView()
//    }
//
//    // MARK: - Internal functions
//
//    func set(currentPage: Int, numberOfPages: Int) {
//        self.currentPage = currentPage
//        self.numberOfPages = numberOfPages
//        updateView()
//    }
//
//    // MARK: - Private functions
//
//    private func updateView() {
//        pageControl.currentPage = currentPage
//        pageControl.numberOfPages = numberOfPages
//    }
//
//    @objc private func handlePageValueChanged() {
//        delegate?.pagesViewDidChanged(page: pageControl.currentPage)
//    }
//
//}
