
# PullToRefreshKit

A lightweight, **SwiftUI-only Pull-to-Refresh control** for **iOS 14+** that supports:

* Pull gesture refresh
* Centered loading indicator
* Programmatic start & stop
* Custom threshold and colors
* No UIKit views
* No `.refreshable`
* Dependency-friendly design

---

## ✨ Features

* ✅ Pure SwiftUI (no UIKit views)
* ✅ Works with `ScrollView`, `LazyVStack`, `LazyVGrid`
* ✅ Programmatic refresh start & stop
* ✅ Customizable threshold and colors
* ✅ Haptic feedback on trigger
* ✅ Minimal & production-ready

---

## 📦 Installation (Swift Package Manager)

### Add via Xcode

1. Open your Xcode project
2. Go to **File → Add Packages…**
3. Paste the repository URL:

```
https://github.com/Excelsior-Technologies-Community/PullToRefreshKit
```

4. Select the latest version
5. Click **Add Package**

---

## 📥 Import

In any SwiftUI file where you want to use Pull-to-Refresh:

```swift
import PullToRefreshKit
```

---

## ⚠️ Important Requirement

Your `ScrollView` **MUST** have this coordinate space:

```swift
.coordinateSpace(name: "pullToRefresh")
```

Without this, the refresh control will not work.

---

## 🚀 Basic Usage

```swift
PullToRefresh(isRefreshing: $isRefreshing) {
    loadData()
}
```

---

## 🔁 Programmatic Refresh

### Start refresh manually

```swift
isRefreshing = true
loadData()
```

### Stop refresh

```swift
isRefreshing = false
```

This allows:

* Auto refresh on appear
* Retry button refresh
* Background refresh logic

---

## 🎨 Customization

```swift
PullToRefresh(
    isRefreshing: $isRefreshing,
    threshold: 70,
    loaderColor: .indigo,
    arrowColor: .indigo
) {
    loadData()
}
```

| Parameter     | Description                               |
| ------------- | ----------------------------------------- |
| `threshold`   | Pull distance required to trigger refresh |
| `loaderColor` | Progress indicator color                  |
| `arrowColor`  | Arrow indicator color                     |

---

## 🧪 Full Working Example

```swift
import SwiftUI
import PullToRefreshKit

struct ContentView: View {

    @State private var items = ["Apple", "Banana", "Cherry"]
    @State private var isRefreshing = false

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {

                PullToRefresh(isRefreshing: $isRefreshing) {
                    refresh()
                }

                ForEach(items, id: \.self) { item in
                    Text(item)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.15))
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .coordinateSpace(name: "pullToRefresh")
    }

    private func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            items.shuffle()
            isRefreshing = false
        }
    }
}
```

---

## 🧠 Design Philosophy

* **Library handles behavior**
* **App controls UI**
* Minimal API surface
* No magic, no hidden state

---

## 📱 Platform Support

* iOS 15+
* SwiftUI only
 
## ⭐️ Final Notes

This library is ideal when:

* You need **more control than `.refreshable`**
* You support **iOS 15**
* You want a **custom refresh UI**
* You need **programmatic refresh control**
 