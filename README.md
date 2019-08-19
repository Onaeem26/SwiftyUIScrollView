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

This is how the above custom wrapper could be used:
```swift
SwiftyUIScrollView(axis: .horizontal, numberOfPages: self.contentArray.count, pagingEnabled: true, pageControlEnabled: true, hideScrollIndicators: true) {
                    HStack(spacing: 0) {
                        ForEach(self.contentArray, id: \.id) { item in
                            TestView(data: item)
                                    .frame(width: g.size.width, height: g.size.height)
                        }
                    }
            }.frame(width: g.size.width)
```

The ```DirectionX``` enum contains two directions: 

```swift
enum DirectionX {
    case horizontal
    case vertical
}
```

If you are using ```HStack```, make sure you set the ``` axis ```  in initializer to- .horizontal, if using ``` VStack ``` make sure you use .vertical. This is madatory in order to have pagination and page controls to work for both directions. 
