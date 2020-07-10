# Show page Temp:

ids = EmpireMasterList.group('lid, list').pluck('MIN(id)')
EmpireMasterList.where.not(id: ids).delete_all
ids = SCustomer.group('s_id).pluck('MIN(id)')
SCustomer.where.not(id: ids).delete_all

ids = MasterCpa.group('lid').pluck('MIN(id)')
MasterCpa.where.not(id: ids).delete_all


When killing server and can restart:
-> lsof -i tcp:3000
    OMMAND   PID       USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
    ruby    52713 austinnash   13u  IPv4 0xcb1c166552ce5b29      0t0  TCP :hbci (LISTEN)
    ruby    52713 austinnash   19u  IPv4 0xcb1c1665531d0e29      0t0  TCP localhost:hbci->localhost:63066 (CLOSE_WAIT)
-> kill -9 52713
