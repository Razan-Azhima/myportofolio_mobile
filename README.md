# myportofolio_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Tugas 7

1. Widget tree -> susunan widget struktur UI Flutter. parent menyusun/configure kepada child widgets. bisa lebih dari satu anak

2.  widget yang digunakan dalam proyek ini:
    === widget proyek ===
    MyApp -> config aplikasi
    MyHomePage -> menyusun halaman utama
    InfoCard -> menampilkan info Nama, NPM, kelas PBP
    ItemCard -> menampilkan tombol kartu menu
    === framework and layout === 
    MaterialApp -> menyediakan struktur app Material
    AppBar -> membuat bilah atas
    Padding -> memberi padding
    Column -> menyusun anak vertikal
    Row -> menyusun anak horizontal
    Center -> menaruh konten di tengah
    Container -> mengatur ruang dan tampilan
    SizedBox -> memberi jarak
    GridView.count -> menampilkan menu dalam kisi

3. MaterialApp ini menyiapkan berbagai hal untuk tema, navigasi, dan konfigurasi. di proyek ini, MyApp mengembalikan MaterialApp, lalu menetapkan tema dan MyHomePage sebagai halaman home

4.  Stateless Widget -> as it names imply, tidak menyimpan state (tidak bisa berubah) 
    Stateful Widget -> bisa berubah
    untuk elemen yang tetap, pakai stateless widget. cth: menu, judul
    untuk elemen yang bisa berubah, pakai stateful widget cth: SnackBar, dialog, popup

5. BuildContext menunjukkan posisi sebuah widget di dalam tree. dengan konteks itu, widget bisa mengambil informasi/layanan yang disediakan oleh parent

cth di proyek ini: 
Theme.of(context) mengambil warna tema
MediaQuery.of(context) membaca ukuran layar
ScaffoldMessenger.of(context) mengakses layanan untuk menampilkan SnackBar

6. 
Hot reload -> merefresh perubahan kode tanpa nge build ulang. State aplikasi dipertahankan
Hot restart -> memulai ulang aplikasi dari awal, sehingga ke reset state aplikasinya
Full restart -> stop lalu mulai dari ulang aplikasi dari awal. Perli dilakukan kalau ada perubahan native atau konfigurasi
