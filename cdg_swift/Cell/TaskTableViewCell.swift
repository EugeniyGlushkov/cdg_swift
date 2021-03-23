//
//  TaskTableViewCell.swift
//  cdg_swift
//
//  Created by evgen on 11.02.2021.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var deleteTaskButton: UIButton!

    @IBAction func deleteTaskButtonTouched(_ sender: Any) {
        guard let handler = deleteTaskButtonTouchedHandler else {
            return
        }
        handler()
    }

    var deleteTaskButtonTouchedHandler: (() -> ())?
    var cellTappedHandler: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func addSwipeHandles() {
        isUserInteractionEnabled = true
        addLeftSwipeHandle()
        addRightSwipeHandle()
    }

    private func addLeftSwipeHandle() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleLeftSwipe(_:)))
        swipe.direction = .left
        addGestureRecognizer(swipe)
    }

    private func addRightSwipeHandle() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleRightSwipe(_:)))
        swipe.direction = .right
        addGestureRecognizer(swipe)
    }

    @objc private func handleLeftSwipe(_ sender: UISwipeGestureRecognizer) {
        deleteTaskButton.isHidden = !deleteTaskButton.isHidden
    }

    @objc private func handleRightSwipe(_ sender: UISwipeGestureRecognizer) {
        deleteTaskButton.isHidden = !deleteTaskButton.isHidden
    }

    func addTapHandle() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        addGestureRecognizer(tap)
    }

    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        guard let handler = cellTappedHandler else {
            return
        }

        handler()
    }
}

extension UITableViewCell: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
