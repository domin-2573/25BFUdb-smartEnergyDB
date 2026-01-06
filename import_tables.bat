@echo off
mysql -h 121.196.200.165 -u jw -p1111 smart_energy < "E:\数据库课设\25BFUdb-smartEnergyDB\sql\建表_最终版.sql"
echo Import completed!
pause
