{:repl {:dependencies [[com.cemerick/piggieback "0.2.2"]]}

 ;; https://stackoverflow.com/questions/16409182/any-way-to-add-dependency-to-lein-project-without-repl-restart
 :dev {:dependencies [[com.cemerick/pomegranate "1.0.0"]]}

 :user {:plugins [[lein-pprint "1.1.2"]
                  [polylith/lein-polylith "0.1.1"]]}}
