Datasheet.destroy_all

d1 = Datasheet.create :seq_number => '1000', :seq_title => 'Title A', :seq_version => 'A', :pes_number => '1234', :pes_version => 'B', :pub_date => '1/1/2000', :seq_update => '1/1/2000', :seq_original_list => '1/1/2000'
d2 = Datasheet.create :seq_number => '1005', :seq_title => 'Title B', :seq_version => 'B', :pes_number => '4321', :pes_version => 'C', :pub_date => '1/1/2000', :seq_update => '1/1/2000', :seq_original_list => '1/1/2000'
