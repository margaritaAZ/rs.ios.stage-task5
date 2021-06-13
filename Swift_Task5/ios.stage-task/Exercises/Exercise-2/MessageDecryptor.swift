import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        guard message.count >= 1 && message.count <= 60 else {
            return ""
        }
        
        var decryptedMessage = message
        while let range = decryptedMessage.range(of: #"[0-9]+\[[a-z]+\]"#, options: .regularExpression){
            var index = range.lowerBound
            var countStr = ""
            var word = ""
            
            while index != range.upperBound {
                if decryptedMessage[index].isNumber {
                    countStr.append(decryptedMessage[index])
                } else if decryptedMessage[index].isLetter {
                    word.append(decryptedMessage[index])
                }
                index = decryptedMessage.index(after: index)
            }
            let count = Int(countStr) ?? 0
            if count < 1 || count > 300  {
                return ""
            }
            decryptedMessage.removeSubrange(range)
            decryptedMessage.insert(contentsOf: String.init(repeating: word, count: count), at: range.lowerBound)
        }
        if let range = decryptedMessage.range(of: #"[a-z]+"#, options: .regularExpression) {
            return String(decryptedMessage[range.lowerBound ... decryptedMessage.index(before: (range.upperBound))])
        }
        return ""
    }
}
