//
//  KERepeatableCommandButton.swift
//  KeyboardExtensionKit
//
//  Created by ky0me22 on 2023/09/02.
//

import SwiftUI

public struct KERepeatableCommandButton: View {
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

    @StateObject private var model: KERepeatableCommandButtonModel

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
        model: @autoclosure @escaping () -> KERepeatableCommandButtonModel
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
        _model = StateObject(wrappedValue: model())
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
        model: @autoclosure @escaping () -> KERepeatableCommandButtonModel
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
        _model = StateObject(wrappedValue: model())
    }

    public var body: some View {
        Group {
            if let image = image {
                image
                    .font(.system(size: 18))
            } else if let text = text {
                Text(text)
                    .font(.system(size: 15))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
        }
        .frame(width: width, height: height)
        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
        .foregroundColor(foregroundColor)
        .background( model.isTouching ? backgroundActiveColor : backgroundInactiveColor)
        .cornerRadius(cornerRadius)
        .shadow(
            color: KEColor.commandButtonShadow,
            radius: 0.1,
            y: 1
        )
        .contentShape(Rectangle())
        .gesture(
            DragGesture(minimumDistance: 0.0, coordinateSpace: .global)
                .onChanged { _ in
                    model.touchDown()
                }
                .onEnded { _ in
                    model.touchUp()
                }
        )
    }
}

struct KERepeatableButton_Previews: PreviewProvider {
    static var previews: some View {
        KERepeatableCommandButton(image: Image(systemName: "return"),
                                  model: KERepeatableCommandButtonModel(onCommandHandler: {}))
    }
}
