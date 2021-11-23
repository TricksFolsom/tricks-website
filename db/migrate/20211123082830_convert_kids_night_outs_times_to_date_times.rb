class ConvertKidsNightOutsTimesToDateTimes < ActiveRecord::Migration[6.1]
  def up
    # add a temporary column
    add_column :kids_night_outs, :gb_datetime, :datetime
    add_column :kids_night_outs, :fol_datetime, :datetime
    add_column :kids_night_outs, :sac_datetime, :datetime
    
    # add the the current start_time as datetime to the temporary column for each entry
    KidsNightOut.all.each do |kno|
      if !kno.date.nil?
        if !kno.gb_time.nil?
          combined = kno.date.to_time.to_i + (((kno.gb_time.hour * 60) + kno.gb_time.min)*60)
          kno.update(gb_datetime: Time.at(combined).to_datetime)
        end
        if !kno.fol_time.nil?
          combined = kno.date.to_time.to_i + (((kno.fol_time.hour * 60) + kno.fol_time.min)*60)
          kno.update(fol_datetime: Time.at(combined).to_datetime)
        end
        if !kno.sac_time.nil?
          combined = kno.date.to_time.to_i + (((kno.sac_time.hour * 60) + kno.sac_time.min)*60)
          kno.update(sac_datetime: Time.at(combined).to_datetime)
        end
      end
    end

    # drop the old time column
    remove_column :kids_night_outs, :gb_time
    remove_column :kids_night_outs, :fol_time
    remove_column :kids_night_outs, :sac_time
    remove_column :kids_night_outs, :date
  end

  def down
    add_column :kids_night_outs, :gb_time, :time
    add_column :kids_night_outs, :fol_time, :time
    add_column :kids_night_outs, :sac_time, :time
    add_column :kids_night_outs, :date, :date
    
    KidsNightOut.all.each do |kno|
      if !kno.gb_datetime.nil?
        kno.update(date: kno.gb_datetime.to_date)
        kno.update(gb_time: kno.gb_datetime.to_time)
      end
      if !kno.fol_datetime.nil?
        kno.update(date: kno.fol_datetime.to_date)
        kno.update(fol_time: kno.fol_datetime.to_time)
      end
      if !kno.sac_datetime.nil?
        kno.update(date: kno.sac_datetime.to_date)
        kno.update(sac_time: kno.sac_datetime.to_time)
      end
    end

    remove_column :kids_night_outs, :gb_datetime
    remove_column :kids_night_outs, :fol_datetime
    remove_column :kids_night_outs, :sac_datetime
  end
end
