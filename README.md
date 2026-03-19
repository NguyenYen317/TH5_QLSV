# 🎓 Student Management App (Flutter)

Ứng dụng quản lý sinh viên được xây dựng bằng **Flutter**, sử dụng **Local Storage (Hive/SQLite)** để lưu trữ dữ liệu. Ứng dụng hỗ trợ thêm, sửa, xóa, tìm kiếm và phân loại sinh viên một cách khoa học.

---

## 🚀 Tính năng chính

### 📌 Quản lý sinh viên (CRUD)
- Thêm sinh viên mới
- Cập nhật thông tin sinh viên
- Xóa sinh viên
- Xem chi tiết sinh viên

### 🔍 Tìm kiếm & lọc
- Tìm kiếm theo tên hoặc mã sinh viên
- Lọc theo lớp / ngành học
- Sắp xếp theo GPA, tên (A-Z, Z-A)

### 📊 Dashboard
- Tổng số sinh viên
- Thống kê theo lớp / ngành
- Hiển thị nhanh thông tin tổng quan

### 💾 Lưu trữ dữ liệu
- Lưu dữ liệu cục bộ bằng **Hive / SQLite**
- Dữ liệu không bị mất khi tắt ứng dụng

---

## 🛠️ Công nghệ sử dụng

- Flutter
- Dart
- Hive (hoặc SQLite)
- Provider / State Management
- Material Design

---

## 📁 Cấu trúc thư mục

```bash
lib/
├── main.dart
├── app.dart
├── models/
│   └── student.dart
├── screens/
│   ├── splash/
│   ├── auth/
│   ├── home/
│   ├── student/
│   └── search/
├── services/
│   ├── storage_service.dart
│   └── student_service.dart
├── providers/
│   └── student_provider.dart
├── widgets/
│   ├── student_card.dart
│   ├── custom_button.dart
│   └── custom_textfield.dart
├── utils/
│   ├── validators.dart
│   ├── constants.dart
│   └── helpers.dart
├── routes/
│   └── app_routes.dart