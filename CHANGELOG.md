## 2.2.2
 - File structure and code was added to have the repo more accuretly reflect the custom codec tutorial: https://www.elastic.co/guide/en/logstash/current/_how_to_write_a_logstash_codec_plugin.html

## 2.0.0
 - Plugins were updated to follow the new shutdown semantic, this mainly allows Logstash to instruct input plugins to terminate gracefully, 
   instead of using Thread.raise on the plugins' threads. Ref: https://github.com/elastic/logstash/pull/3895
 - Dependency on logstash-core update to 2.0

