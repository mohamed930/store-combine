// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum myStrings {
  /// الغاء الامر
  internal static let cancel = myStrings.tr("Localizable", "cancel", fallback: "الغاء الامر")
  /// هذا البريد الاكتروني غير صالح من فضلك اعد المحاوله مره اخرى
  internal static let emailVerificationError = myStrings.tr("Localizable", "emailVerificationError", fallback: "هذا البريد الاكتروني غير صالح من فضلك اعد المحاوله مره اخرى")
  /// انتبه
  internal static let errorTitle = myStrings.tr("Localizable", "ErrorTitle", fallback: "انتبه")
  /// من فضلك افتح خدمة تحديد المواقع
  internal static let locationError = myStrings.tr("Localizable", "locationError", fallback: "من فضلك افتح خدمة تحديد المواقع")
  /// نحن نحتاج الى موقعك الحالى من اجل معرفة انك تحت التغطية او لا؟
  internal static let locationMessageAlert = myStrings.tr("Localizable", "locationMessageAlert", fallback: "نحن نحتاج الى موقعك الحالى من اجل معرفة انك تحت التغطية او لا؟")
  /// البريد الاكتروني او كلمة المرور غير صالحه
  internal static let loginFailed = myStrings.tr("Localizable", "loginFailed", fallback: "البريد الاكتروني او كلمة المرور غير صالحه")
  /// كلمة السر
  internal static let password = myStrings.tr("Localizable", "password", fallback: "كلمة السر")
  /// من فضلك انتظر قليلاً
  internal static let pleaseWait = myStrings.tr("Localizable", "pleaseWait", fallback: "من فضلك انتظر قليلاً")
  /// الاعدادات
  internal static let settings = myStrings.tr("Localizable", "Settings", fallback: "الاعدادات")
  /// Localizable.strings
  ///   store
  /// 
  ///   Created by Mohamed Ali on 23/07/2023.
  internal static let userName = myStrings.tr("Localizable", "userName", fallback: "البريد الالكتروني")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension myStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
