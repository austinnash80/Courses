class AddPubDateVersionToDatasheet < ActiveRecord::Migration[5.1]
  def change
    add_column :datasheets, :version_0, :date
    add_column :datasheets, :version_a, :date
    add_column :datasheets, :version_b, :date
    add_column :datasheets, :version_c, :date
    add_column :datasheets, :version_d, :date
    add_column :datasheets, :version_e, :date
    add_column :datasheets, :version_f, :date
    add_column :datasheets, :version_g, :date
    add_column :datasheets, :version_h, :date
    add_column :datasheets, :version_i, :date
    add_column :datasheets, :version_j, :date
    add_column :datasheets, :version_k, :date
    add_column :datasheets, :version_l, :date
    add_column :datasheets, :version_m, :date
    add_column :datasheets, :version_n, :date
  end
end
