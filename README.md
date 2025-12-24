# PullToRefreshKit

A lightweight, **SwiftUI-only Pull-to-Refresh control** for **iOS 14+**, designed with a **controller-based API** for clean and professional usage.

---

##  Features

* ✅ Pure SwiftUI (no UIKit views)
* ✅ Works with `ScrollView`, `LazyVStack`, `LazyVGrid`
* ✅ **Controller-based API** (`startLoading()` / `stopLoading()`)
* ✅ Programmatic refresh support
* ✅ Centered loading indicator
* ✅ Customizable threshold and colors
* ✅ Haptic feedback on trigger
* ✅ Production-ready & dependency-safe

---

##   Installation (Swift Package Manager)

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

##   Import

```swift
import PullToRefreshKit
```

---

##  Required Setup

Your `ScrollView` **MUST** define this coordinate space:

```swift
.coordinateSpace(name: "pullToRefresh")
```

Without this, the refresh control will not work.

---

##   Basic Usage

###   Create the controller

```swift
@StateObject private var refresher = PullToRefreshController()
```

---

###   Add `PullToRefresh`

```swift
PullToRefresh(controller: refresher) {
    loadData()
}
```

---

##   Programmatic Control (Main Feature)

### ▶ Start loading

```swift
refresher.startLoading()
loadData()
```

###   Stop loading

```swift
refresher.stopLoading()
```

This allows:

* Auto refresh on screen appear
* Retry button refresh
* Background refresh
* Manual trigger without user pull

---

##   Customization

```swift
PullToRefresh(
    controller: refresher,
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

##   Full Working Example

```swift
import SwiftUI
import PullToRefreshKit

struct ContentView: View {

    @StateObject private var refresher = PullToRefreshController()
    @State private var items = ["Apple", "Banana", "Cherry"]

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {

                PullToRefresh(controller: refresher) {
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
            refresher.stopLoading()
        }
    }
}
```

---

##   Design Philosophy

* **Controller manages behavior**
* **App controls UI**
* No external state bindings
* Clean, UIKit-like API
* Easy to scale and maintain

---

##   Platform Support

* iOS 15+
* SwiftUI only

 
##   Final Notes

This library is ideal when:

* You want **more control than `.refreshable`**
* You support **iOS 14+**
* You need **manual + programmatic refresh**
* You prefer **controller-based APIs**
 
 