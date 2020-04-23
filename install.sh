bundle install --jobs 5
rm pkg/* -rf
rake build && gem install pkg/awp3-0.1.0.gem