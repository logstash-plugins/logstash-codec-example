## 2.0.2
 - Added gemspec

## 2.0.1
 - Added documentation template
 
## 2.0.0
 - Changed plugins to follow the new shutdown semantic, this mainly allows Logstash to instruct input plugins to terminate gracefully, 
   instead of using Thread.raise on the plugins' threads. Ref: https://github.com/elastic/logstash/pull/3895
 - Dependency on logstash-core update to 2.0

