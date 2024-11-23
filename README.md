[![Coverage](https://img.shields.io/badge/Test--Coverage-97.75%25-success)](https://github.com/Jafar-Rezazadeh/wordpress_companion/blob/develop/coverage/lcov.info)


# نرم افزار وردپرس یار (Flutter)

این اپلیکیشن به شما اجازه می‌دهد بخش‌هایی از وب‌سایت وردپرسی خود را از طریق REST API مدیریت کنید. قابلیت‌های این برنامه شامل مدیریت پست‌ها، دسته‌بندی‌ها و مدیا می‌باشد. این پروژه از **Clean Architecture** استفاده می‌کند تا توسعه و نگهداری کد را ساده‌تر کند.

<br/>
<br/>
<br/>

## ویژگی‌ها

- **تنظیمات سایت**
  <br/>
  <br/>
- **تنظیمات پروفایل**
  <br/>
  <br/>
- **مدیریت پست‌ها**:
  - افزودن پست جدید
  - ویرایش پست‌های موجود
  - حذف پست‌ها
  <br/>
- **مدیریت دسته‌بندی‌ها**:
  - افزودن دسته‌بندی جدید
  - ویرایش دسته‌بندی‌های موجود
  - حذف دسته‌بندی‌ها
  <br/>
- **مدیریت رسانه‌ها (Media)**:
  - آپلود رسانه‌های جدید
  - حذف رسانه‌های موجود
  - تغییر ویژگی ها

<br/>
<br/>
<br/>

## پیش‌نیازها

1. وب‌سایت وردپرسی فعال با نسخه حداقل ۵.۰.
2. لینک وب سایت، نام کاربری و رمز عبور برنامه برای احراز هویت.


<br/>
<br/>
<br/>

## الگو های استفاده شده(Design Patterns):
- [Builder](lib\features\profile\presentation\utils\update_my_profile_params_builder.dart)
- [Factory Method](lib\core\errors\failures.dart)
- [Chain of Responsibility](lib/features/media/presentation/widgets/media_show_box.dart)
## معماری پروژه

این پروژه از معماری **Clean Architecture** استفاده می‌کند، که شامل سه لایه اصلی است:

### لایه‌ها:

1.**دامنه (Domain)**

   - شامل منطق تجاری برنامه و موجودیت‌ها (Entities) است.
   - این لایه مستقل از هر تکنولوژی یا کتابخانه است.
   - شامل فایل‌های:
     - موجودیت‌ها (Entities): قوانین تجاری (مانند `Post`, `Category`, `Media`).
     - توافق نامه ها (abstract repositories)
     - موارد کاربرد (Use Cases): عملیات اصلی مانند `CreatePost`, `UpdateCategory`, `UploadMedia`.
<br/>
<br/>

3.**دیتا (Data)**

 - مسئول تعامل با منابع خارجی مانند REST API یا پایگاه داده است.
 - شامل:
  - مخزن Repository‌ های پیاده‌سازی‌شده (Implementation of Repositories).
  - مدل های تبدیل داده (Models)
  - منابع داده (Data Sources): ارتباط با API‌ها یا ذخیره محلی.

<br/>
<br/>

3.**رابط کابری (Presentation)**

   - رابط کاربری (UI) و مدیریت وضعیت است.
   - از ابزارهایی مانند `Provider` یا ` (cubit) Bloc` برای مدیریت وضعیت استفاده می‌شود.
   - شامل:
     - ویجت‌ها (Widgets)
     - صفحات (Screens)
     - برگه ها (Pages)

<br/>
<br/>
<br/>

## ساختار درختی پروژه


```
├───core
│   ├───constants
│   ├───contracts
│   ├───entities
│   ├───errors
│   ├───extensions
│   ├───presentation
│   │   ├───cubits
│   │   │   └───global_profile_cubit
│   │   ├───screens
│   │   └───widgets
│   ├───router
│   ├───services
│   ├───theme
│   ├───utils
│   └───widgets
└───features
    ├───categories
    │   ├───application
    │   │   ├───categories_cubit
    │   │   └───widgets
    │   ├───data
    │   │   ├───data_sources
    │   │   │   ├───abstracts
    │   │   │   └───implementations
    │   │   ├───models
    │   │   └───repositories
    │   ├───domain
    │   │   ├───entities
    │   │   ├───repositories
    │   │   └───use_cases
    │   └───presentation
    │       ├───logic_holders
    │       │   └───utils
    │       ├───pages
    │       ├───screens
    │       └───widgets
    ├───login
    │   ├───data
    │   │   ├───data_sources
    │   │   │   ├───abstracts
    │   │   │   └───implementations
    │   │   ├───models
    │   │   └───repositories
    │   ├───domain
    │   │   ├───entities
    │   │   ├───repositories
    │   │   └───use_cases
    │   └───presentation
    │       ├───logic_holder
    │       │   ├───authentication_cubit
    │       │   └───login_credentials
    │       ├───screens
    │       ├───utils
    │       └───widgets
    │           └───login_screen
    ├───media
    │   ├───application
    │   │   └───image_selector
    │   │       ├───state_management
    │   │       │   └───image_list_cubit
    │   │       ├───utils
    │   │       └───widgets
    │   ├───data
    │   │   ├───data_sources
    │   │   │   ├───abstracts
    │   │   │   └───implementations
    │   │   ├───models
    │   │   └───repositories
    │   ├───domain
    │   │   ├───entities
    │   │   ├───repositories
    │   │   └───use_cases
    │   └───presentation
    │       ├───logic_holders
    │       │   └───cubits
    │       │       ├───media_cubit
    │       │       └───upload_media_cubit
    │       ├───pages
    │       ├───screens
    │       └───widgets
    │           ├───edit_media_screen
    │           ├───media_page
    │           └───upload_media_dialog
    ├───posts
    │   ├───data
    │   │   ├───data_sources
    │   │   │   ├───abstracts
    │   │   │   └───implementations
    │   │   ├───models
    │   │   └───repositories
    │   ├───domain
    │   │   ├───entities
    │   │   ├───repositories
    │   │   └───use_cases
    │   └───presentation
    │       ├───login_holders
    │       │   ├───posts_cubit
    │       │   ├───tags_cubit
    │       │   └───utils
    │       ├───pages
    │       ├───screens
    │       └───widgets
    │           ├───create_or_edit_screen
    │           └───posts_page
    ├───profile
    │   ├───application
    │   ├───data
    │   │   ├───data_sources
    │   │   │   ├───abstracts
    │   │   │   └───implementations
    │   │   ├───models
    │   │   └───repositories
    │   ├───domain
    │   │   ├───entities
    │   │   ├───repositories
    │   │   └───use_cases
    │   └───presentation
    │       ├───screens
    │       ├───state_management
    │       │   └───profile-cubit
    │       ├───utils
    │       └───widgets
    ├───site_settings
    │   ├───data
    │   │   ├───data_sources
    │   │   │   ├───abstracts
    │   │   │   └───implementations
    │   │   ├───models
    │   │   └───repositories
    │   ├───domain
    │   │   ├───entities
    │   │   ├───repositories
    │   │   └───use_cases
    │   └───presentation
    │       ├───screens
    │       ├───state_Management
    │       │   ├───image_finder_cubit
    │       │   └───site_settings_cubit
    │       ├───utils
    │       └───widgets
    └───tags
        ├───application
        ├───data
        │   ├───data_sources
        │   │   ├───abstracts
        │   │   └───implementations
        │   ├───models
        │   └───repositories
        └───domain
            ├───entities
            ├───repositories
            └───use_cases
```
