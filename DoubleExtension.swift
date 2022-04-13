//
//  DoubleExtension.swift
//  SPM_BubbleLevel
//
//  Created by Luiz Araujo on 13/04/22.
//

import Foundation

extension Double {
    func describeAsFixedLengthString(intergerDigits: Int = 2, fractionDigits: Int = 2) -> String {
        self.formatted(
            .number
                .sign(strategy: .always())
                .precision(
                    .integerAndFractionLength(integer: intergerDigits, fraction: fractionDigits)
                )
        )
    }
}
