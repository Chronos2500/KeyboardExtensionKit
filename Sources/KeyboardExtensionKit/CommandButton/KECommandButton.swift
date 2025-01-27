//
//  KECommandButton.swift
//  KeyboardExtensionKit
//
//  Created by ky0me22 on 2023/09/02.
//

import SwiftUI

public struct KECommandButton: View {
    private let image: Image?
    private let text: String?
    private let width: CGFloat?
    private let height: CGFloat?
    private let maxWidth: CGFloat?
    private let maxHeight: CGFloat?
    private let cornerRadius: CGFloat
    private let foregroundColor: Color
    private let backgroundInactiveColor: Color
    private let backgroundActiveColor: Color
    private let onCommandHandler: () -> Void

    public init(
        image: Image,
        width: CGFloat? = 40,
        height: CGFloat? = 40,
        maxWidth: CGFloat? = nil,
        maxHeight: CGFloat? = nil,
        cornerRadius: CGFloat = 8,
        foregroundColor: Color = KEColor.commandForeground,
        backgroundInactiveColor: Color = KEColor.commandBackgroundInactive,
        backgroundActiveColor: Color = KEColor.commandBackgroundActive,
        onCommandHandler: @escaping () -> Void
    ) {
        self.image = image
        self.text = nil
        self.width = maxWidth == nil ? width : nil
        self.height = maxHeight == nil ? height : nil
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
        self.cornerRadius = cornerRadius
        self.foregroundColor = foregroundColor
        self.backgroundInactiveColor = backgroundInactiveColor
        self.backgroundActiveColor = backgroundActiveColor
        self.onCommandHandler = onCommandHandler
    }

    public init(
        text: String,
        width: CGFloat? = 40,
        height: CGFloat? = 40,
        maxWidth: CGFloat? = nil,
        maxHeight: CGFloat? = nil,
        cornerRadius: CGFloat = 8,
        foregroundColor: Color = KEColor.commandForeground,
        backgroundInactiveColor: Color = KEColor.commandBackgroundInactive,
        backgroundActiveColor: Color = KEColor.commandBackgroundActive,
        onCommandHandler: @escaping () -> Void
    ) {
        self.image = nil
        self.text = text
        self.width = maxWidth == nil ? width : nil
        self.height = maxHeight == nil ? height : nil
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
        self.cornerRadius = cornerRadius
        self.foregroundColor = foregroundColor
        self.backgroundInactiveColor = backgroundInactiveColor
        self.backgroundActiveColor = backgroundActiveColor
        self.onCommandHandler = onCommandHandler
    }

    public var body: some View {
        Button {
            KEKeySound.tapModifier()
            onCommandHandler()
        } label: {
            if let text = text {
                Text(verbatim: text)
                    .font(.system(size: 15))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            } else {
                image
                    .font(.system(size: 16))
            }
        }
        .buttonStyle(.command(
            width: width,
            height: height,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            foregroundColor: foregroundColor,
            backgroundInactiveColor: backgroundInactiveColor,
            backgroundActiveColor: backgroundActiveColor,
            cornerRadius: cornerRadius
        ))
        .shadow(
            color: KEColor.commandButtonShadow,
            radius: 0.1,
            y: 1
        )
    }
}

struct KECommandButton_Previews: PreviewProvider {
    static var previews: some View {
        KECommandButton(image: Image(systemName: "command"), onCommandHandler: {})
    }
}
