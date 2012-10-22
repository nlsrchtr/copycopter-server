class RemoveDelayedJobs < ActiveRecord::Migration
  def up
    drop_table :delayed_jobs
  end

  def down
    create_table 'delayed_jobs', :force => true do |t|
      t.timestamps :null => false
      t.integer 'attempts', :default => 0
      t.datetime 'failed_at'
      t.text 'handler'
      t.text 'last_error'
      t.datetime 'locked_at'
      t.string 'locked_by'
      t.integer 'priority', :default => 0
      t.datetime 'run_at'
    end
  end
end
