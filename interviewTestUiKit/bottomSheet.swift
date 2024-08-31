import UIKit

class BottomSheetViewController: UIViewController {

    var filteredNameList: [String] = []
    
    private let statsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        view.addSubview(statsLabel)
        NSLayoutConstraint.activate([
            statsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            statsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        updateStatistics()
    }
    
    private func updateStatistics() {
        let itemCount = filteredNameList.count
        let charCounts = countCharacters(in: filteredNameList)
        let topChars = topCharacters(from: charCounts)
        
        var statsText = "List \(itemCount) items\n"
        statsText += "Top 3 Characters:\n"
        
        for (char, count) in topChars {
            statsText += "\(char) = \(count)\n"
        }
        
        statsLabel.text = statsText
    }
    
    private func countCharacters(in list: [String]) -> [Character: Int] {
        var charCounts = [Character: Int]()
        
        for item in list {
            for char in item.lowercased() {
                if char.isLetter {
                    charCounts[char, default: 0] += 1
                }
            }
        }
        
        return charCounts
    }
    
    private func topCharacters(from counts: [Character: Int]) -> [(Character, Int)] {
        let sortedCounts = counts.sorted { $0.value > $1.value }
        let top3 = sortedCounts.prefix(3)
        return Array(top3)
    }
}
