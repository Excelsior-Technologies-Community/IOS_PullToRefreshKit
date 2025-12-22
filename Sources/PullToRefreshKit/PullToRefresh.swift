import SwiftUI


// MARK: - Empty State View
struct EmptyStateView: View {

    // MARK: - Properties
    let onRetry: () -> Void

    // MARK: - Body
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "tray")
                .font(.system(size: 60))
                .foregroundColor(.secondary)

            Text("No items yet")
                .font(.title3)
                .fontWeight(.semibold)

            Text("Pull down to refresh")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Button(action: onRetry) {
                Text("Load Data")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.indigo)
                    .cornerRadius(8)
            }
        }
        .padding(.vertical, 60)
    }
}

// MARK: - Pull To Refresh View
public struct PullToRefresh: View {

    // MARK: - Observed Object
    @ObservedObject private var controller: PullToRefreshController

    // MARK: - Callbacks
    private let onRefresh: () -> Void

    // MARK: - Configuration
    private let threshold: CGFloat
    private let loaderColor: Color
    private let arrowColor: Color

    // MARK: - Internal State
    @State private var hasTriggered = false

    // MARK: - Initializer
    public init(
        controller: PullToRefreshController,
        threshold: CGFloat = 50,
        loaderColor: Color = .blue,
        arrowColor: Color = .gray,
        onRefresh: @escaping () -> Void
    ) {
        self.controller = controller
        self.threshold = threshold
        self.loaderColor = loaderColor
        self.arrowColor = arrowColor
        self.onRefresh = onRefresh
    }

    // MARK: - Body
    public var body: some View {
        GeometryReader { geometry in
            let offset = geometry.frame(in: .named("pullToRefresh")).minY
            let progress = min(max(offset / threshold, 0), 1)

            if offset > 0 {
                ZStack {
                    if controller.isRefreshing {
                        ProgressView()
                            .tint(loaderColor)
                            .scaleEffect(1.2)
                    } else {
                        Image(systemName: "arrow.down")
                            .foregroundColor(arrowColor)
                            .opacity(Double(progress))
                            .rotationEffect(.degrees(progress >= 1 ? 180 : 0))
                    }
                }
                .frame(width: geometry.size.width, height: threshold)
                .offset(y: controller.isRefreshing ? 0 : -threshold + offset)
                .onChange(of: offset) { handleOffsetChange($0) }
            }
        }
        .frame(height: 0)
    }

    // MARK: - Offset Handling
    private func handleOffsetChange(_ offset: CGFloat) {
        if !controller.isRefreshing && !hasTriggered && offset > threshold {
            hasTriggered = true
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            controller.startLoading()
            onRefresh()
        }

        if offset < threshold / 2 {
            hasTriggered = false
        }
    }
}
