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


### TUGAS 8

1. (diambil dari tutorial 9)
- push() -> menambah suatu route ke dalam stack (LIFO Stack) route yang dikelola Navigator
- pop() -> menghapus route yang sedang ditampilkan kepada pengguna (atau dalam kata lain, route yang berada pada paling atas stack) dari stack route yang dikelola oleh Navigator.
mirip method Stack untuk yg diatas
- pushReplacement() -> menghapus route yang sedang ditampilkan kepada pengguna dan menggantinya dengan suatu route. Method ini menyebabkan aplikasi untuk berpindah dari route yang sedang ditampilkan kepada pengguna ke suatu route yang diberikan

- Kartu Aksi -> membuka formulir baned route -> Navigator.pushNamed()
    say: Navigator.pushNamed(context, '/add-edu');
    route '/add-edu' dipetakan ke EducationFormPage di main.dart. pushNamed() membuka formulir di atas halaman saat ini

- Opsi Home di drawer memakai pushReplacement() dengan MyHomePage().
    - mengganti halaman aktif dengan halaman utama (home)

2. 
Scaffold -> menyediakan struktur visual dasar halaman (AppBar, Body, SnackBar)
AppBar -> ditempatkan bagian atas
Drawer -> menyediakan navigasi yang sama, dan konten halaman diletakkan di body.
dengan memakai LeftDrawer bersama pada setiap scaffold, pengguna bisa pindah halaman dengan cara seragam

cth: penggunaan warna tema di lebih dari satu halaman:
    appBar: AppBar(
        title: const Text("Judul Halaman"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
    ),
    
3. 
tata letak memakai Column agar input tersusun secara berurutan dari atas ke bawah. 
untuk field tanggal di education_form di taruh di row agar berdampingan, dengan Expanded membagi ruang yang tersedia secara proporsional
Padding -> memberi jarak sekeliling field
SizedBox() -> memisahkan kedua field tanggal agar tidak berhimpitan
SingleChildScrollView memungkinkan isi formulir digulir ketika tinggi layar terbatas

4. 
GlobalKey<FormState> -> menghubungkan kode ke FormState milik form, sehingga tombol bisa melakukan validasi
validator -> memeriksa nilai field -> kembalikan string jika nilainya tidak valid atau null jika valid
validate() -> menjalankan semua validator. jika ada yang gagal, hasilnya false; jika semua lolos, hasilnya true

cth:
    validator: (value) {
    if (value == null || value.trim().isEmpty) {
        return "Nama institusi tidak boleh kosong";
    }
    return null;
    },

    Memilih jenis input atau papan ketik saja belum cukup untuk menjamin data valid. 
    keyboardType (ketikkan) hanya memberi petunjuk papan ketik yang ditampilkan; 
    pengguna masih dapat memasukkan data dengan cara lain. Oleh karena itu masih perlu divalidasi saat nilai form disimpan 




AI Disclosure: Saya memakai LLM ChatGPT berupa menganalisis mengapa kode buatan saya error dan mengkoreksi secara manual sesuai dengan saran AI.

