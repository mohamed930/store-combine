# 🛍️ TRU iOS Assignment – Product Demo App

This iOS app is a demo product listing application built with **Swift + UIKit**.  
It demonstrates handling API requests, switching between list & grid layouts, loading indicators, pagination, offline caching, and a product details screen with a stretchable image header.

---

## ✨ Features

- 📋 **List of Products** – fetch products from [FakeStore API](https://fakestoreapi.com/products?limit=7)  
- 🔄 **Switch Layout** – toggle between **Grid (horizontal)** and **List (vertical)** view  
- 📥 **Pagination** – loads more products as you scroll (7 items per request)  
- 🖼️ **Product Details Screen** – shows product image in a stretchable header + category, price, description, and rating  
- 📶 **Network Awareness** – shows a banner when offline, fetches cached products when possible  
- 💀 **Skeleton Loading** – shows skeleton placeholders while loading data  
- 🎨 **Responsive Design** – adapts to different screen sizes  
- 🗂️ **Clean Code** – reusable components and MVVM-ish structure  

---

## 📲 Requirements

- iOS 15.0+  
- Xcode 15+  
- Swift 5.9+  
- CocoaPods (for dependencies)  

---

## ⚙️ Installation

1. Clone the repo:
   ```bash
   git clone https://github.com/your-username/ProductDemo.git
   cd ProductDemo
   ```

2. Install pods:
   ```bash
   pod install
   ```

3. Open the workspace:
   ```bash
   open ProductDemo.xcworkspace
   ```

---

## 🚀 Running the App

1. Run on **iPhone simulator** or physical device.  
2. On launch, the app fetches the first 7 products.  
3. Use the **toggle button** in the top bar to switch between **Grid** and **List** view.  
4. Scroll to the bottom → new page loads automatically.  
5. Tap a product → navigates to the **Product Details Screen** with a stretchy header.  

---

## 📡 Internet Handling

- The app monitors connection status with `SimplePing`.  
- If offline:  
  - A **banner appears** at the bottom.  
  - Cached product list from local storage is displayed.  
- If online again:  
  - Banner disappears automatically.  
  - Fresh data is fetched from API.  

---

## 🖼️ Product Details Page

- Large **header image** that **stretches on pull-down**.  
- On scroll-up, the header **shrinks smoothly** but stays visible.  
- Details shown below:  
  - Title  
  - Category  
  - Price  
  - Rating  
  - Description  

---

## ⏳ Loading States

- Uses **[SkeletonView](https://github.com/Juanpe/SkeletonView)**  
- Displays skeleton placeholders for:  
  - Product image  
  - Title  
  - Price  
  - Rating  

---

## 📦 Caching

- The latest successfully fetched product list is cached locally.  
- When offline, cached data is shown instead of empty UI.  

---

## ⚠️ Important Note (Fix for SimplePing)

If you get a **compile error** related to `SimplePing.h`,  
please open the file located in:

```
Pods/SimplePing/SimplePing.h
```

and add the following import at the top of the file:

```objc
#import <sys/socket.h>
```

This ensures the socket API compiles correctly.

---

## 📝 Thoughts

- UIKit is used for UI because it offers fine-grained control and matches the assignment’s requirement.  
- MVVM-style architecture + Combine is used for clean separation of logic.  
- `UICollectionView` supports both **vertical list** and **horizontal grid** using a toggle.  
- For stretchable header, a **custom header view + scrollViewDidScroll** logic was implemented.  
- SkeletonView improves UX during API calls.  
- Local caching improves resilience against network loss.  

---

## 🔮 Possible Enhancements

- Unit/UI Tests (not included in this version)  
- Dark Mode support  
- Custom animations for transitions  
- Improved product caching with Core Data  

---

## 👨‍💻 Author

Mohamed Ali  
📧 mo.ali12477@gmail.com
🌐 [Your GitHub](https://github.com/mohamed930)
