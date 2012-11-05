web:          bundle exec rails server -p $PORT
worker:       bundle exec rake resque:work QUEUE=*
urgentworker: bundle exec rake resque:work QUEUE=urgent
clock:        bundle exec clockwork clock.rb
