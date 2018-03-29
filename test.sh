#!/bin/bash
rake build && gem install pkg/awp3-0.1.0.gem && awp 5.hours.ago Time.now+1.hour max test
