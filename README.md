[![Coverage](https://img.shields.io/badge/Test--Coverage-97.45%25-success)](https://github.com/Jafar-Rezazadeh/wordpress_companion/blob/develop/coverage/lcov.info)


## used Design patterns

- [Builder](lib\features\profile\presentation\utils\update_my_profile_params_builder.dart)
- [Factory Method](lib\core\errors\failures.dart)
- [Chain of Responsibility](lib/features/media/presentation/widgets/media_show_box.dart)

# مدیریت وردپرس از طریق اپلیکیشن موبایل (Flutter)

این اپلیکیشن Flutter به شما اجازه می‌دهد بخش‌هایی از وب‌سایت وردپرسی خود را از طریق REST API مدیریت کنید. قابلیت‌های این برنامه شامل مدیریت پست‌ها، دسته‌بندی‌ها و مدیا می‌باشد. این پروژه از **Clean Architecture** استفاده می‌کند تا توسعه و نگهداری کد را ساده‌تر کند.

---

## ویژگی‌ها

- **مدیریت پست‌ها**:
  - افزودن پست جدید
  - ویرایش پست‌های موجود
  - حذف پست‌ها
- **مدیریت دسته‌بندی‌ها**:
  - افزودن دسته‌بندی جدید
  - ویرایش دسته‌بندی‌های موجود
  - حذف دسته‌بندی‌ها
- **مدیریت رسانه‌ها (Media)**:
  - آپلود رسانه‌های جدید
  - حذف رسانه‌های موجود

---

## پیش‌نیازها

1. نصب [Flutter SDK](https://flutter.dev/docs/get-started/install) (نسخه حداقل ۳.۰.۰).
2. وب‌سایت وردپرسی فعال با نسخه حداقل ۵.۰.
3. فعال‌سازی REST API در وردپرس.
4. دسترسی به کلید API یا نام کاربری و رمز عبور برای احراز هویت.
5. نصب افزونه‌هایی مانند JWT Authentication (در صورت نیاز به احراز هویت JWT).

---

## معماری پروژه

این پروژه از معماری **Clean Architecture** استفاده می‌کند، که شامل سه لایه اصلی است:

### لایه‌ها:

1. **Domain (دامنه)**:
   - شامل منطق تجاری برنامه و موجودیت‌ها (Entities) است.
   - این لایه مستقل از هر تکنولوژی یا کتابخانه است.
   - شامل فایل‌های:
     - موجودیت‌ها (Entities): قوانین تجاری (مانند `Post`, `Category`, `Media`).
     - موارد کاربرد (Use Cases): عملیات اصلی مانند `CreatePost`, `UpdateCategory`, `UploadMedia`.

2. **Data (داده)**:
   - مسئول تعامل با منابع خارجی مانند REST API یا پایگاه داده است.
   - شامل:
     - Repository‌های پیاده‌سازی‌شده (Implementation of Repositories).
     - منابع داده (Data Sources): ارتباط با API‌ها یا ذخیره محلی.

3. **Presentation (ارائه)**:
   - شامل رابط کاربری (UI) و مدیریت وضعیت است.
   - از ابزارهایی مانند `Provider` یا `Bloc` برای مدیریت وضعیت استفاده می‌شود.
   - شامل:
     - ویجت‌ها (Widgets): نمایش اطلاعات به کاربر.
     - ViewModels یا Controllers: مدیریت داده‌ها و منطق نمایش.

---

## ساختار پروژه

