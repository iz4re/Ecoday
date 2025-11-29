---
description: Panduan lengkap mengatasi overflow pixel di Android
---

# 🔧 Cara Mengatasi Overflow Pixel di Android

## 🎯 Masalah Umum
- **Pixel Overflow** terjadi saat konten lebih besar dari layar
- Sering muncul saat keyboard terbuka
- Terjadi di layar Android yang lebih kecil

---

## ✅ Solusi Utama (Sudah Diterapkan di Auth Screen)

### 1. **Tambahkan `resizeToAvoidBottomInset`**
```dart
Scaffold(
  resizeToAvoidBottomInset: true,  // ← Penting untuk screen dengan input field
  body: ...
)
```

### 2. **Wrap dengan `SingleChildScrollView`**
```dart
body: SingleChildScrollView(
  physics: const ClampingScrollPhysics(),  // Smooth scrolling Android
  child: Column(
    children: [
      // konten Anda
    ],
  ),
)
```

### 3. **Gunakan `SafeArea`**
```dart
SafeArea(
  child: SingleChildScrollView(
    // konten
  ),
)
```

### 4. **Gunakan `LayoutBuilder` untuk responsive**
```dart
LayoutBuilder(
  builder: (context, constraints) {
    final maxWidth = constraints.maxWidth > 420 
        ? 400.0 
        : constraints.maxWidth - 24;
    
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: // konten
    );
  },
)
```

---

## 📱 Screen-by-Screen Checklist

### ✅ Auth Screen - **SUDAH DIPERBAIKI**
- ✅ `resizeToAvoidBottomInset: true`
- ✅ `SingleChildScrollView`
- ✅ `LayoutBuilder` untuk responsive
- ✅ `SafeArea`

### 🔍 Screens Lain yang Perlu Dicek:

#### Home Screen
- Sudah ada `SingleChildScrollView` ✅
- Tidak ada input field, jadi aman ✅

#### Event Screen
- Sudah ada `SingleChildScrollView` ✅
- Tidak ada input field ✅

#### Event Detail Screen
- Sudah ada `SingleChildScrollView` ✅
- Scroll physics baik ✅

#### Event Progress Screen
- Sudah ada `SingleChildScrollView` ✅
- Perhatikan event quest cards ⚠️

#### Ranking Screen
- Sudah ada `SingleChildScrollView` ✅
- Leaderboard items aman ✅

#### Reward Screen
- Sudah ada `SingleChildScrollView` ✅
- Voucher cards perlu dicek ⚠️

#### Profile Screen
- Sudah ada `SingleChildScrollView` ✅
- Banyak konten, perlu monitoring ⚠️

#### Quest List Screen
- Sudah ada `ListView` ✅
- Aman karena pakai ListView ✅

---

## 🚨 Solusi untuk Masalah Spesifik

### **Problem 1: Keyboard Menutupi Input Field**

**Solusi:**
```dart
Scaffold(
  resizeToAvoidBottomInset: true,  // ← WAJIB!
  body: SingleChildScrollView(
    reverse: true,  // Auto scroll ke bawah saat keyboard muncul (optional)
    child: ...
  ),
)
```

### **Problem 2: Bottom Overflow saat Keyboard Muncul**

**Solusi dengan Padding Bottom:**
```dart
SingleChildScrollView(
  child: Padding(
    padding: EdgeInsets.only(
      bottom: MediaQuery.of(context).viewInsets.bottom,  // Padding dinamis
    ),
    child: Column(children: [...]),
  ),
)
```

### **Problem 3: Widget Tetap Overflow Meski Ada ScrollView**

**Penyebab:** Ada `Expanded` atau `Flexible` di dalam `Column` yang ada di `SingleChildScrollView`

**Solusi:** Ganti `Expanded` dengan `Container` atau `SizedBox` dengan height fixed
```dart
// ❌ JANGAN:
SingleChildScrollView(
  child: Column(
    children: [
      Expanded(child: ...), // ← Ini akan error!
    ],
  ),
)

// ✅ LAKUKAN:
SingleChildScrollView(
  child: Column(
    children: [
      Container(
        height: 200,  // atau SizedBox
        child: ...,
      ),
    ],
  ),
)
```

### **Problem 4: ListView di dalam Column**

**Solusi:** Beri `shrinkWrap: true` dan `physics`
```dart
Column(
  children: [
    ListView.builder(
      shrinkWrap: true,  // ← Penting!
      physics: const NeverScrollableScrollPhysics(),  // ← Disable scroll ListView
      itemCount: items.length,
      itemBuilder: (context, index) => ...,
    ),
  ],
)
```

### **Problem 5: Card Terlalu Tinggi untuk Layar Kecil**

**Solusi:** Gunakan responsive sizing dengan `MediaQuery`
```dart
Container(
  height: MediaQuery.of(context).size.height * 0.3,  // 30% dari tinggi layar
  child: ...
)

// Atau dengan constraints:
Container(
  constraints: BoxConstraints(
    maxHeight: MediaQuery.of(context).size.height * 0.5,
    minHeight: 200,
  ),
  child: ...
)
```

---

## 🛠️ Testing di Android

### **Ukuran Screen yang Harus Dicek:**
1. **Small** - 5.0" (360x640) - Contoh: Samsung A10
2. **Medium** - 5.5" (411x731) - Contoh: Pixel 4
3. **Large** - 6.0" (412x915) - Contoh: Pixel 6

### **Cara Testing:**

#### 1. **Di Android Emulator:**
```bash
flutter run
```
Lalu rotate screen dan buka keyboard untuk test overflow.

#### 2. **Di Real Device:**
```bash
flutter run
```
Test dengan keyboard, scroll, dan rotate.

#### 3. **Test Overflow Secara Visual:**
Tambahkan ini di `main.dart` sementara:
```dart
MaterialApp(
  debugShowCheckedModeBanner: false,
  showPerformanceOverlay: false,
  debugShowMaterialGrid: true,  // ← Tampilkan grid, bantu lihat overflow
  ...
)
```

---

## 📏 Responsive Design Best Practices

### **1. Hindari Hardcoded Heights untuk Layar Kecil**
```dart
// ❌ Hindari:
Container(height: 800, child: ...)  // Terlalu tinggi untuk layar kecil

// ✅ Gunakan:
Container(
  height: MediaQuery.of(context).size.height * 0.8,
  child: ...
)
```

### **2. Gunakan Flexible Spacing**
```dart
// ❌ Spacing terlalu besar:
const SizedBox(height: 50)

// ✅ Responsive spacing:
SizedBox(height: MediaQuery.of(context).size.height * 0.03)

// atau minimal clamp:
SizedBox(height: (MediaQuery.of(context).size.height * 0.05).clamp(20, 50))
```

### **3. Adaptive Font Sizes**
```dart
Text(
  'Judul',
  style: TextStyle(
    fontSize: MediaQuery.of(context).size.width * 0.05,  // 5% dari lebar
  ),
)
```

### **4. Gunakan `FittedBox` untuk Text Overflow**
```dart
FittedBox(
  fit: BoxFit.scaleDown,
  child: Text('Text panjang yang mungkin overflow'),
)
```

---

## 🎨 Widget Helper untuk Responsive

### **Create a Responsive Helper:**

Buat file `lib/core/utils/responsive_helper.dart`:
```dart
import 'package:flutter/material.dart';

class ResponsiveHelper {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  
  static bool isSmallScreen(BuildContext context) => width(context) < 375;
  static bool isMediumScreen(BuildContext context) => width(context) >= 375 && width(context) < 414;
  static bool isLargeScreen(BuildContext context) => width(context) >= 414;
  
  // Responsive padding
  static EdgeInsets screenPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: isSmallScreen(context) ? 12 : 16,
      vertical: isSmallScreen(context) ? 16 : 20,
    );
  }
  
  // Responsive spacing
  static double spacing(BuildContext context, double percentage) {
    return height(context) * percentage;
  }
}
```

**Cara Pakai:**
```dart
Padding(
  padding: ResponsiveHelper.screenPadding(context),
  child: ...
)

SizedBox(height: ResponsiveHelper.spacing(context, 0.02))  // 2% dari height
```

---

## 🚀 Quick Fix Commands

### **Hot Reload setelah perubahan:**
```bash
# Di terminal Flutter yang sedang running:
# Tekan: r (hot reload)
# Atau: R (hot restart)
```

### **Jika masih overflow, coba:**
1. **Stop app** (tekan `q` di terminal)
2. **Run ulang:**
```bash
flutter clean
flutter run
```

---

## ❓ Troubleshooting

### **Masih overflow setelah menambahkan SingleChildScrollView?**
1. Cek apakah ada `Expanded` widget di dalam `Column`
2. Pastikan tidak ada `height: double.infinity` 
3. Periksa `CrossAxisAlignment` di `Column`

### **Keyboard menutupi input field?**
1. Pastikan `resizeToAvoidBottomInset: true`
2. Tambahkan padding bottom dinamis
3. Gunakan `Scrollable.ensureVisible()` jika perlu

### **ListView tidak bisa scroll?**
1. Cek apakah ada `NeverScrollableScrollPhysics()`
2. Jika di dalam `SingleChildScrollView`, tambahkan `shrinkWrap: true`

---

## ✅ Checklist Final

Sebelum test di device, pastikan:
- [ ] Semua screen dengan input field punya `resizeToAvoidBottomInset: true`
- [ ] Semua long content wrapped dengan `SingleChildScrollView`
- [ ] Tidak ada `Expanded` di dalam `SingleChildScrollView`
- [ ] Semua screen pakai `SafeArea`
- [ ] Spacing menggunakan percentage atau minimal fixed value
- [ ] Test di emulator dengan ukuran screen kecil (360x640)
- [ ] Test dengan keyboard terbuka
- [ ] Test dengan screen rotation

---

**Status Auth Screen:** ✅ **SUDAH DIPERBAIKI**

Silakan hot reload aplikasi Anda dengan tekan **`r`** di terminal!
