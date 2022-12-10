<!-- # Перенести фапйлы в папку нашего пользователя именно на HDFS. -->
root@fea313eaeea5:/# hdfs dfs -put voyna-i-mir-tom-* /test
<!-- # Вывести список файлов -->
root@fea313eaeea5:/# hdfs dfs -ls /test
Found 4 items
-rw-r--r--   3 root supergroup     736519 2022-12-10 15:25 /test/voyna-i-mir-tom-1.txt
-rw-r--r--   3 root supergroup     770324 2022-12-10 15:25 /test/voyna-i-mir-tom-2.txt
-rw-r--r--   3 root supergroup     843205 2022-12-10 15:25 /test/voyna-i-mir-tom-3.txt
-rw-r--r--   3 root supergroup     697960 2022-12-10 15:25 /test/voyna-i-mir-tom-4.txt

<!-- Слить файлы в один -->
root@fea313eaeea5:/# hadoop fs -text /test/voyna-i-mir-tom-* | hadoop fs -put - /test/voyna-i-mir.txt
<!-- Поставить разрешения на файл -->
root@fea313eaeea5:/# hdfs dfs -chmod 777 /test/voyna-i-mir.txt

<!-- # Вывести список файлов -->
root@fea313eaeea5:/# hdfs dfs -ls /test
Found 5 items
-rw-r--r--   3 root supergroup     736519 2022-12-10 15:25 /test/voyna-i-mir-tom-1.txt
-rw-r--r--   3 root supergroup     770324 2022-12-10 15:25 /test/voyna-i-mir-tom-2.txt
-rw-r--r--   3 root supergroup     843205 2022-12-10 15:25 /test/voyna-i-mir-tom-3.txt
-rw-r--r--   3 root supergroup     697960 2022-12-10 15:25 /test/voyna-i-mir-tom-4.txt
-rwxrwxrwx   3 root supergroup    3048008 2022-12-10 15:29 /test/voyna-i-mir.txt
<!-- Вывести размер файлов -->
root@fea313eaeea5:/# hdfs dfs -du -h /test
719.3 K  2.1 M  /test/voyna-i-mir-tom-1.txt
752.3 K  2.2 M  /test/voyna-i-mir-tom-2.txt
823.4 K  2.4 M  /test/voyna-i-mir-tom-3.txt
681.6 K  2.0 M  /test/voyna-i-mir-tom-4.txt
2.9 M    8.7 M  /test/voyna-i-mir.txt

<!-- Поменять фактор репликации -->
root@fea313eaeea5:/# hdfs dfs -setrep -R 2 /test/voyna-i-mir.txt
Replication 2 set: /test/voyna-i-mir.txt
<!-- Вывести размер файлов -->
root@fea313eaeea5:/# hdfs dfs -du -h /test
719.3 K  2.1 M  /test/voyna-i-mir-tom-1.txt
752.3 K  2.2 M  /test/voyna-i-mir-tom-2.txt
823.4 K  2.4 M  /test/voyna-i-mir-tom-3.txt
681.6 K  2.0 M  /test/voyna-i-mir-tom-4.txt
2.9 M    5.8 M  /test/voyna-i-mir.txt

<!-- Подсчитать количество строк в файле -->
root@fea313eaeea5:/# hadoop fs -cat /test/voyna-i-mir.txt | wc -l
10272
