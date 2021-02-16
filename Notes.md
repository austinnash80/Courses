# Show page Temp:

ids = EmpireMasterList.group('lid, list').pluck('MIN(id)')
EmpireMasterList.where.not(id: ids).delete_all

State
ids = EmpireMasterList.where(source: 'CA').group('lid, list').pluck('MIN(id)')
EmpireMasterList.where(source: 'CA').where.not(id: ids).delete_all

ids = SCustomer.group('s_id').pluck('MIN(id)')
SCustomer.where.not(id: ids).delete_all

ids = MasterCpa.group('lid').pluck('MIN(id)')
MasterCpa.where.not(id: ids).delete_all

ids = MasterEa.group('lid').pluck('MIN(id)')
MasterEa.where.not(id: ids).delete_all

ea = MasterEa.where.not(uid: nil).all
ea.each do |i|
new = MasterEaMatch.create(uid: i.uid, lid:i.lid, list:i.list, search_date:Date.today, lname:i.lname)
new.save
end

Match EMpire Master:
EmpireCustomer.where(lic_state: 'CA').each do |i|
  EmpireMasterList.where(source: 'CA').where(license_number: i.license_num).update_all uid: i.uid
end


When killing server and can restart:
-> lsof -i tcp:3000
    OMMAND   PID       USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
    ruby    52713 austinnash   13u  IPv4 0xcb1c166552ce5b29      0t0  TCP :hbci (LISTEN)
    ruby    52713 austinnash   19u  IPv4 0xcb1c1665531d0e29      0t0  TCP localhost:hbci->localhost:63066 (CLOSE_WAIT)
-> kill -9 52713
