# SwiftyUIScrollView
A custom ScrollView wrapper that comes with Pagination and Page Control.

Wrap HStack or VStack with the custom SwiftUIScrollView to get pagination and page control features. The initializer for the wrapper is:

```swift
init(axis: DirectionX, numberOfPages: Int,
         pagingEnabled: Bool,
         pageControlEnabled: Bool,
         hideScrollIndicators: Bool,
         currentPageIndicator: UIColor? = .white,
         pageIndicatorTintColor: UIColor? = .gray,
         @ViewBuilder content: @escaping () -> Content)
```

