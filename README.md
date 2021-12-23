# LeboncoinAds
Test task for Leboncoin

## Functionality
App demonstrates list of classified ads. It allows to scroll through list (urgent ads are marked), filter them by category and see detailed information about specific ad. 

## Visuals
App supports iOS and iPadOS, light and dark themes, 14 and 15 versions of respective OSs, english and french localizations.
It also provides portrait and landscape orientations and iPadOS multitasking features - split view and slide over.

---

## Further improvements

There are a number of improvements which can be applyed to enhance the app

### Persistence
* **Data Base.** This logic should be encapsulated in separate package (using SwiftPM) if possible. With that in place, before requesting a new data from network, we fetch existing data from persistent storage and send it to view layer. Once network request provides data, it passed to storage and if actual update happened (we have a new data from server) DB sends notification to update view
* **Showcase app data in Spotlight.** If we chose to use Core Data on previous step, we can show app's data in system search – Spotlight
* **Storing images on disk.** Further improvement to `ImageStore` package – save loaded images on disk to reduce network usage on subsequent app launches 

### Better usage of iPadOS features
* **Multiple similar windows.** Adding support for multiple scenes (windows) will enhance UX – a user can open windows with different ads to compare them, for example
* **Prominent window.** Second type of scene. User can open particular ad details on separate window to focus on it, like in Mail or Notes
* **Triple column split view.** Use primary column to show categories, supplementary for list and secondary for details. This will "flatten" UI just as Apple suggests – user will see more content on one screen without need to open separate modal screen
* **Enhanced visuals.** Need to apply blur effect on categories column and vibrancy effect for labels of categories. This will delight user
* **Pointer support.** Implement popup effect on hover over ads list item
* **Keyboard focus.** Implement focus movement between focus areas – categories list and ads list
* **Ads list menu.** Show menu on long tap/secondary tap on ads list item with "open in new window" and "share" commands
* **Quick notes support.** Adding a link to ad details to quick note 

### Better usage of iOS features
* **Filter menu.** Add menu to filter button. It will show a few categories and "Go to all" option if there are more categories, this option will open a modal screen of categories. First entry of the menu will contain "Show all" option
* **Catalyst.** Add a Mac Catalyst variant of the app to work on macOS
* **Handoff.** Enable Handoff between iOS/iPadOS/macOS variants of the app
* **Share.** Share details of specific ad
* **Messages extension.** Implement beautiful sharing card in Messages
