//
//  AutoHeightTextEditor.swift
//  SpendSmart
//
//  Created by dtrognn on 08/04/2024.
//

import SwiftUI

struct AutoHeightEditor: View {
    enum RegExpUse {
        case use(pattern: String, isMatched: Binding<Bool>)
        case none
    }

    // MARK: - Property

    private let const = TextEditorConst.self

    private let text: Binding<String>
    private let font: Font
    private let teHeight: CGFloat
    private let lineSpace: CGFloat
    private let isEnabled: Binding<Bool>
    private let hasBorder: Bool
    private let placerholder: String
    private let regExpUse: RegExpUse

    // MARK: Initializer에서 계산을 통해 결정되는 프로퍼티

    private let maxLineCount: CGFloat
    private let uiFont: UIFont
    private let maxHeight: CGFloat

    @State private var currentTextEditorHeight: CGFloat = 0
    @State private var maxTextWidth: CGFloat = 0

    // MARK: - Initializer

    /// 파라미터 font = .body, lineSpace = 2 기본값 지정
    init(
        text: Binding<String>,
        font: Font = Font.regular(ofSize: 16),
        teHeight: CGFloat = 70,
        lineSpace: CGFloat = 2,
        maxLine: Int,
        hasBorder: Bool,
        isEnabled: Binding<Bool>,
        disabledPlaceholder: String,
        regExpUse: RegExpUse)
    {
        // MARK: Required

        self.text = text
        self.font = font
        self.teHeight = teHeight
        self.lineSpace = lineSpace
        self.isEnabled = isEnabled
        self.hasBorder = hasBorder
        self.placerholder = disabledPlaceholder
        self.regExpUse = regExpUse

        // MARK: Calculated

        self.maxLineCount = (maxLine < 1 ? 1 : maxLine).asFloat
        self.uiFont = UIFont.fontToUIFont(from: font)
        self.maxHeight = (maxLineCount * (uiFont.lineHeight + lineSpace)) + const.TEXTEDITOR_FRAME_HEIGHT_FREESPACE
    }

    // MARK: - View

    var body: some View {
        if isEnabled.wrappedValue {
            enabledEditor
        } else {
            disabledEditor
        }
    }
}

// MARK: - Calculate Line

private extension AutoHeightEditor {
    /// 현재 text에 개행문자에 의한 라인 갯수가 몇 줄인지 계산합니다.
    var newLineCount: CGFloat {
        let currentText: String = text.wrappedValue
        let currentLineCount: Int = currentText
            .filter { $0 == "\n" }
            .count + 1
        let newLineCount: CGFloat = currentLineCount > maxLineCount.asInt
            ? maxLineCount
            : currentLineCount.asFloat

        return newLineCount
    }

    /// 개행 문자 기준으로 텍스트를 분리하고, 각 텍스트 길이가 Editor 길이를 초과하는지 체크하여 필요한 줄바꿈 수를 계산합니다.
    var autoLineCount: CGFloat {
        var counter = 0
        text
            .wrappedValue
            .components(separatedBy: "\n")
            .forEach { line in
                let label = UILabel()
                label.font = .fontToUIFont(from: font)
                label.text = line
                label.sizeToFit()
                let currentTextWidth = label.frame.width
                counter += (currentTextWidth / maxTextWidth).asInt
            }

        return counter.asFloat
    }
}

// MARK: - Calculate Width / Height

private extension AutoHeightEditor {
    /// textEditor 시작 높이를 설정합니다.
    func setTextEditorStartHeight() {
//        currentTextEditorHeight = uiFont.lineHeight + const.TEXTEDITOR_FRAME_HEIGHT_FREESPACE
        currentTextEditorHeight = teHeight
    }

    /// text가 가질 수 있는 최대 길이를 설정합니다.
    func setMaxTextWidth(proxy: GeometryProxy) {
        maxTextWidth = proxy.size.width - (const.TEXTEDITOR_INSET_HORIZONTAL * 2 + const.TEXTEDITOR_WIDTH_HORIZONTAL_BUFFER)
    }

    /// line count를 통해 textEditor 현재 높이를 계산해서 업데이트합니다.
    func updateTextEditorCurrentHeight() {
        // 총 라인 갯수
        let totalLineCount = newLineCount + autoLineCount

        // 총 라인 갯수가 maxCount 이상이면 최대 높이로 고정
        guard totalLineCount < maxLineCount else {
            currentTextEditorHeight = maxHeight
            return
        }

        // 라인 갯수로 계산한 현재 Editor 높이
        let currentHeight = (totalLineCount * (uiFont.lineHeight + lineSpace))
            - lineSpace + teHeight

        // View의 높이를 결정하는 State 변수에 계산된 현재 높이를 할당하여 뷰에 반영
        currentTextEditorHeight = currentHeight
    }
}

// MARK: - Regular Expression

private extension AutoHeightEditor {
    /// 정규식 프로퍼티와 현재 텍스트가 일치하는지 제공하는 인터페이스 프로퍼티
    private var isPatternMatched: Bool {
        switch regExpUse {
        case .use(let pattern, _):
            guard text.wrappedValue.isEmpty == false else {
                return false
            }

            let isMathed: Bool = text.wrappedValue.range(
                of: pattern,
                options: .regularExpression) != nil

            return isMathed

        case .none:
            return true
        }
    }

    /// 바인딩 되어있는 isPatternMatched에 정규식 패턴 매치 여부를 업데이트합니다.
    func updatePatternMatched() {
        switch regExpUse {
        case .use(_, let isMatched):
            isMatched.wrappedValue = isPatternMatched

        case .none:
            break
        }
    }
}

// MARK: - Editor View

private extension AutoHeightEditor {
    var placeholderText: some View {
        return Text(placerholder)
            .font(AppStyle.font.regular16)
            .foregroundColor(AppStyle.theme.textNoteColor)
            .padding([.leading, .top], AppStyle.layout.standardSpace)
    }

    var enabledEditor: some View {
        GeometryReader { proxy in
            ZStack {
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: AppStyle.layout.standardCornerRadius)
                        .fill(AppStyle.theme.tfFillNormalColor)

                    TextEditor(text: text)
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                        .modifier(
                            AutoHeightEditorLayoutModifier(
                                font: font,
                                color: .primary,
                                lineSpace: lineSpace,
                                maxHeight: currentTextEditorHeight,
                                horizontalInset: const.TEXTEDITOR_INSET_HORIZONTAL,
                                bottomInset: const.TEXTEDITOR_INSET_BOTTOM))
                        .padding(.top, AppStyle.layout.mediumSpace)

                    if text.wrappedValue.isEmpty {
                        placeholderText
                    }
                }

                if hasBorder {
                    RoundedRectangle(cornerRadius: const.TEXTEDITOR_STROKE_CORNER_RADIUS)
                        .stroke(AppStyle.theme.tfBorderNormalColor, lineWidth: 1)
                }
            }
            .onAppear {
                setTextEditorStartHeight()
                setMaxTextWidth(proxy: proxy)
            }
            .onChange(of: text.wrappedValue) { _ in
                updateTextEditorCurrentHeight()
                updatePatternMatched()
            }
        }
        .frame(maxHeight: currentTextEditorHeight)
        .background(AppStyle.theme.backgroundColor)
    }

    var disabledEditor: some View {
        ZStack {
            TextEditor(
                text: .constant(placerholder)
            )
            .modifier(
                AutoHeightEditorLayoutModifier(
                    font: font,
                    color: .primary,
                    lineSpace: lineSpace,
                    maxHeight: currentTextEditorHeight,
                    horizontalInset: const.TEXTEDITOR_INSET_HORIZONTAL,
                    bottomInset: const.TEXTEDITOR_INSET_BOTTOM))
            .disabled(true)

            if hasBorder {
                RoundedRectangle(cornerRadius: const.TEXTEDITOR_STROKE_CORNER_RADIUS)
                    .stroke()
                    .foregroundColor(.gray)
                    .background(
                        Color.gray.opacity(0.7))
                    .cornerRadius(const.TEXTEDITOR_STROKE_CORNER_RADIUS)
            }
        }
        .frame(maxHeight: currentTextEditorHeight)
        .onAppear {
            setTextEditorStartHeight()
        }
    }
}

private struct AutoHeightEditorLayoutModifier: ViewModifier {
    let font: Font
    let color: Color
    let lineSpace: CGFloat
    let maxHeight: CGFloat
    let horizontalInset: CGFloat
    let bottomInset: CGFloat

    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(color)
            .lineSpacing(lineSpace)
            .frame(maxHeight: maxHeight)
            .padding(.horizontal, horizontalInset)
            .padding(.bottom, bottomInset)
    }
}

extension CGFloat {
    var asInt: Int {
        switch self {
        case .infinity, .nan:
            return 0
        default:
            return Int(self)
        }
    }
}

extension Int {
    var asFloat: CGFloat {
        return CGFloat(self)
    }
}

extension UIFont {
    /// SwiftUI Font를 UIFont 타입으로 변환합니다.
    static func fontToUIFont(from font: Font) -> UIFont {
        let style: UIFont.TextStyle

        switch font {
        case .largeTitle: style = .largeTitle
        case .title: style = .title1
        case .title2: style = .title2
        case .title3: style = .title3
        case .headline: style = .headline
        case .subheadline: style = .subheadline
        case .callout: style = .callout
        case .caption: style = .caption1
        case .caption2: style = .caption2
        case .footnote: style = .footnote
        case .body: style = .body
        default: style = .body
        }

        return UIFont.preferredFont(forTextStyle: style)
    }
}
