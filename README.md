# Data_Cleansing_Shell

Tujuan pengerjaan project ini adalah untuk melakukan cleansing data csv.

#1. Menggabungkan kedua data dalam 1 file
Penggabungan ini menggunakan csvstack dengan format:
csvstack file1 file2 > file_baru

#2. Menyeleksi kolom yang relevan untuk analisis produk
Pengambilan kolom atau seleksi kolom ini menggunakan csvcut dengan format:
csvcut -c kolomke-? file > file_baru 

#3. Melakukan filtering untuk mendapatkan aktivitas pembelian saja
Filtering atau mengambil value tertentu saja dari sebuah kolom ini menggunakan csvgrep dengan format:
csvgrep -c "nama_kolom" -m "nama_value" file > file_baru

#4. Melakukan splitting data kategori produk dan nama produk pada kolom kategori code
-Pertama dibuat sebuah file yang berisi header nya saja
echo "category,product_name" > category-data.csv
-Kedua melakukan split dengan mengambil kata pertama dan kata terakhir dengan separator titik pada kolom category_code 
csvcut -c "category_code" purchase-data.csv | tail +2 | awk -F "." 'OFS="," {print $1, $NF}' >> category-data.csv

#5. Join data type purchase dengan hasil split
Penggabungan ini menggunakan csvjoin

#6 Validasi data
Validasi ini dilakukan untuk mengecek apakah hasilnya sama dengan yang diharapkan
