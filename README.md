[![Coverage](https://img.shields.io/badge/Test--Coverage-97.45%25-success)](https://github.com/Jafar-Rezazadeh/wordpress_companion/blob/develop/coverage/lcov.info)


# نرم افزار وردپرس یار (Flutter)

این اپلیکیشن به شما اجازه می‌دهد بخش‌هایی از وب‌سایت وردپرسی خود را از طریق REST API مدیریت کنید. قابلیت‌های این برنامه شامل مدیریت پست‌ها، دسته‌بندی‌ها و مدیا می‌باشد. این پروژه از **Clean Architecture** استفاده می‌کند تا توسعه و نگهداری کد را ساده‌تر کند.

<br/>
<br/>
<br/>

## ویژگی‌ها

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
     - موارد کاربرد (Use Cases): عملیات اصلی مانند `CreatePost`, `UpdateCategory`, `UploadMedia`.
<br/>
<br/>

3.**دیتا (Data)**

 - مسئول تعامل با منابع خارجی مانند REST API یا پایگاه داده است.
 - شامل:
  - مخزن Repository‌ های پیاده‌سازی‌شده (Implementation of Repositories).
  - منابع داده (Data Sources): ارتباط با API‌ها یا ذخیره محلی.

<br/>
<br/>

3.**رابط کابری (Presentation)**

   - شامل رابط کاربری (UI) و مدیریت وضعیت است.
   - از ابزارهایی مانند `Provider` یا `Bloc` برای مدیریت وضعیت استفاده می‌شود.
   - شامل:
     - ویجت‌ها (Widgets): نمایش اطلاعات به کاربر.
     - ViewModels یا Controllers: مدیریت داده‌ها و منطق نمایش.

<br/>
<br/>
<br/>

## ساختار پروژه

