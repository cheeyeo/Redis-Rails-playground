## Redis Rails playground

A sample application in Rails 4.2+ which leverage Redis as a cache store.

The example store is inside ```app/cache/my_redis_store```.

The purpose of this application is to familiarize myself with using Redis inside of Rails and to leverage it for tasks which are better performed outside
of the application cycle such as analytics, caching etc

The current implementation of redis are:

* Custom cache store ( app/cache/my_redis_store )

* Using ```Rails.cache``` to fetch and set AR models and views

## TODOS

* Implement user's followers / followees

* Some kind of pub/sub system

* O-Auth implementation in Redis

DO NOT use the cache store here in production as it is just POC.

Use [https://github.com/redis-store/redis-activesupport](https://github.com/redis-store/redis-activesupport) if running in production.
