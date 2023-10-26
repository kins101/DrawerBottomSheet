import SwiftUI

public struct SizeReader<Content: View>: View {
    @Binding var size: CGSize
    public let content: () -> Content

    public init(size: Binding<CGSize>, @ViewBuilder content: @escaping () -> Content) {
        self._size = size
        self.content = content
    }

    public var body: some View {
        ZStack {
            content().background(
                GeometryReader { proxy in
                    Color.clear.preference(
                        key: SizePreferenceKey.self,
                        value: proxy.size
                    )
                }
            )
        }
        .onPreferenceChange(SizePreferenceKey.self) { preferences in
            self.size = preferences
        }
    }
}

struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: Value = .zero

    static func reduce(value _: inout Value, nextValue: () -> Value) {
        _ = nextValue()
    }
}
