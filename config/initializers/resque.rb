require 'resque'
require 'resque-scheduler'
require 'resque/scheduler/server'

Resque.redis = Redis.new(url: 'redis://localhost:6379')
Resque.schedule = YAML.load_file(Rails.root.join('config', 'resque_schedule.yml'))

Resque.logger = Logger.new(Rails.root.join('log', "#{Rails.env}_resque.log"))
Resque.logger.level = Logger::INFO
