# Show page Temp:

ids = EmpireMasterList.group('lid, list').pluck('MIN(id)')
EmpireMasterList.where.not(id: ids).destroy_all
