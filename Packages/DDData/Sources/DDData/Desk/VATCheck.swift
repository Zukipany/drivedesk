// Source code is private. This file shows only its types and signatures.

import DDCore
import Foundation

/// Input VAT checks on receipts (US-31, plan section 21). Up to 250 € gross a receipt is a
/// small-amount invoice (§ 33 UStDV) and needn't name the buyer; above that, the company's
/// name and address must be on it, or the input VAT can't be claimed. A card payment without
/// any receipt loses its input VAT altogether.
public nonisolated enum VATCheck {
    /// 250 € gross.
    public static let smallAmountLimitCents

    public enum Recipient: Equatable, Sendable {
        /// Up to 250 €: the receipt counts as it is.
        case smallAmount
        /// The company's name and address are on it.
        case named
        /// Above 250 € without the company's name or address.
        case missing
    }

    /// What a receipt of `grossCents` with this text says about the company as its buyer.
    public static func recipient(grossCents: Int, lines: [String], company: Company) -> Recipient { /* private */ }

    public static func recipient(grossCents: Int, lines: [String], name: String, street: String?, postalCode: String?) -> Recipient { /* private */ }

    /// The input VAT at stake on a fill-up, in cents: its own VAT, else 19 % from the gross
    /// (fuel and charging are taxed at the full rate in Germany).
    public static func vatCents(of fillUp: FillUp) -> Int { /* private */ }

    /// Card payments in `interval` with no receipt yet, and the input VAT they lose.
    public static func withoutReceipt(_ fillUps: [FillUp], in interval: DateInterval) -> (count: Int, vatCents: Int) { /* private */ }

    /// The words that make a company's name, without its legal form: "Elektro Huber GmbH &
    /// Co. KG" is "elektro huber".
    static func coreWords(of name: String) -> [String] { /* private */ }

    /// Lowercase, without accents, letters and digits only: "Leopoldstraße 52" is
    /// "leopoldstrasse 52", and "Huber-GmbH" is "huber gmbh".
    static func fold(_ text: String) -> String { /* private */ }
}
