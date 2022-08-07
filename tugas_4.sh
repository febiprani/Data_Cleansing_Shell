#!/bin/bash

#1. Menggabungkan kedua data dalam 1 file
csvstack 2019-Oct-sample.csv 2019-Nov-sample.csv > 2019-Oct-Nov.csv
echo -e "Data berhasil digabungkan"

#2. Menyeleksi kolom yang relevan untuk analisis produk
csvcut -c 2,3,4,5,7,8,6 2019-Oct-Nov.csv > 2019-relevant-data.csv
echo -e "Data berhasil diseleksi"

#3. Melakukan filtering untuk mendapatkan aktivitas pembelian saja
csvgrep -c "event_type" -m "purchase" 2019-relevant-data.csv > purchase-data.csv
echo -e "Data berhasil difilter"

#4. Melakukan splitting data kategori produk dan nama produk pada kolom kategori code
echo "category,product_name" > category-data.csv 
csvcut -c "category_code" purchase-data.csv | tail +2 | awk -F "." 'OFS="," {print $1, $NF}' >> category-data.csv
echo -e "Data berhasil dilakukan split"

#5. Join data type purchase dengan hasil split
csvjoin purchase-data.csv category-data.csv | csvcut -C "category_code" > data-final.csv

#6 Validasi data
echo -e "Validasi data"
cat data-final.csv | wc
cat data-final.csv | grep electronics | grep smartphone| awk -F ',' '{print $5}'|
	sort | uniq -c | sort -nr
