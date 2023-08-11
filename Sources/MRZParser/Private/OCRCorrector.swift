//
//  OCRCorrector.swift
//  
//
//  Created by Roman Mazeev on 30.06.2021.
//

struct OCRCorrector {
    func correct(_ string: String, fieldType: MRZFieldType) -> String {
        let string = string.uppercased()
        switch fieldType {
        // TODO: Check correction of dates (month & day)
        case .birthdate, .expiryDate, .hash:
            return replaceLetters(in: string)
        // TODO: Check documentType, countryCode and nationality against possible (allowed) values
        case .names, .documentType, .countryCode, .nationality:
            return replaceDigits(in: string)
        // TODO: Improve correction (take into account "M" & "<" too)
        case .sex:
            return string.replace("P", with: "F")
        case .documentNumber, .personalNumber, .optionalData:
            return string
        }
    }
    
    func getCandidates(_ string: String, fieldType: MRZFieldType) -> [String] {
        let string = string.uppercased()
        switch fieldType {
            // TODO: Check correction of dates (month & day)
        case .birthdate, .expiryDate, .hash:
            return [replaceLetters(in: string)]
            // TODO: Check documentType, countryCode and nationality against possible (allowed) values
        case .names, .documentType, .countryCode, .nationality:
            return [replaceDigits(in: string)]
            // TODO: Improve correction (take into account "M" & "<" too)
        case .sex:
            return [string.replace("P", with: "F")]
        case .documentNumber, .personalNumber, .optionalData:
            return getLetterDigitCandidates(in: string)
        }
    }

    private func replaceDigits(in string: String) -> String {
        return string
            .replace("0", with: "O")
            .replace("1", with: "I")
            .replace("2", with: "Z")
            .replace("8", with: "B")
    }

    private func replaceLetters(in string: String) -> String {
        return string
            .replace("O", with: "0")
            .replace("Ö", with: "0")
            .replace("Q", with: "0")
            .replace("U", with: "0")
            .replace("Ü", with: "0")
            .replace("D", with: "0")
            .replace("I", with: "1")
            .replace("Z", with: "2")
            .replace("B", with: "8")
    }
   
    private func getLetterDigitCandidates(in string: String) -> [String] {
        var candidates = [string]
        candidates.append(string.replace("O", with: "0"))
        candidates.append(string.replace("Ö", with: "0"))
        candidates.append(string.replace("Q", with: "0"))
        candidates.append(string.replace("U", with: "0"))
        candidates.append(string.replace("Ü", with: "0"))
        candidates.append(string.replace("D", with: "0"))
        candidates.append(string.replace("I", with: "1"))
        candidates.append(string.replace("Z", with: "2"))
        candidates.append(string.replace("B", with: "8"))
        return candidates
    }
}
