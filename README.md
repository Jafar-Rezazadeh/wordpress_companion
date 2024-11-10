![Coverage](https://img.shields.io/badge/Coverage-0.0-lightgrey)

# WordPress Companion

This is a Flutter application that interacts with the WordPress REST API to display and manage WordPress content, such as posts, categories, tags, comments, users, media, pages, and menus.

## used Design patterns

- [Builder](lib\features\profile\presentation\utils\update_my_profile_params_builder.dart)
- [Factory Method](lib\core\errors\failures.dart)
- [Chain of Responsibility](lib/features/media/presentation/widgets/media_show_box.dart)

## Features

- Display list of posts
- Display post details
- Create and edit posts
- List categories and filter posts by category
- List tags and filter posts by tag
- Display and manage comments
- Display user profiles and edit profiles
- User authentication (login, logout, registration)
- Display and upload media files
- Display pages and page details
- Display and customize menus
- View and edit site settings (admin functionalities)
- Manage plugins and themes (admin functionalities)

## Project Structure

```plaintext
lib/
├── api/
│   ├── wordpress_service.dart   // HTTP service definitions
├── models/
│   ├── post.dart                // Data class for posts
│   ├── category.dart            // Data class for categories
│   ├── tag.dart                 // Data class for tags
│   ├── comment.dart             // Data class for comments
│   ├── user.dart                // Data class for users
│   ├── media.dart               // Data class for media
│   ├── page.dart                // Data class for pages
│   ├── menu.dart                // Data class for menus
│   ├── settings.dart            // Data class for settings
├── repositories/
│   ├── wordpress_repository.dart// Repository handling data operations
├── ui/
│   ├── screens/
│   │   ├── main_screen.dart      // Main screen
│   │   ├── post_list_screen.dart // Screen to display list of posts
│   │   ├── post_detail_screen.dart// Screen to display post details
│   │   ├── category_list_screen.dart// Screen to display list of categories
│   │   ├── tag_list_screen.dart  // Screen to display list of tags
│   │   ├── comment_list_screen.dart// Screen to display list of comments
│   │   ├── user_profile_screen.dart// Screen to display user profile
│   │   ├── media_library_screen.dart// Screen to display media library
│   │   ├── page_list_screen.dart // Screen to display list of pages
│   │   ├── menu_list_screen.dart // Screen to display list of menus
│   │   ├── settings_screen.dart  // Screen to display settings
│   ├── widgets/
│       ├── post_card.dart        // Widget to display post card
│       ├── category_card.dart    // Widget to display category card
│       ├── tag_chip.dart         // Widget to display tag chip
│       ├── comment_tile.dart     // Widget to display comment tile
│       ├── user_avatar.dart      // Widget to display user avatar
│       ├── media_item.dart       // Widget to display media item
│       ├── page_tile.dart        // Widget to display page tile
│       ├── menu_item_tile.dart   // Widget to display menu item
├── viewmodels/
│   ├── post_viewmodel.dart       // ViewModel for posts
│   ├── category_viewmodel.dart   // ViewModel for categories
│   ├── tag_viewmodel.dart        // ViewModel for tags
│   ├── comment_viewmodel.dart    // ViewModel for comments
│   ├── user_viewmodel.dart       // ViewModel for users
│   ├── media_viewmodel.dart      // ViewModel for media
│   ├── page_viewmodel.dart       // ViewModel for pages
│   ├── menu_viewmodel.dart       // ViewModel for menus
│   ├── settings_viewmodel.dart   // ViewModel for settings
├── utils/
│   ├── network_utils.dart        // Utility functions for networking
│   ├── constants.dart            // Constant values
```
