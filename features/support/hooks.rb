Before do
  # Clear Memcached
  Rails.cache.clear

  # Clear Redis
  REDIS_GENERAL.flushall
  REDIS_KUDOS.flushall
  REDIS_RESQUE.flushall
  REDIS_ROLLOUT.flushall

  step %{all search indexes are updated}

  $rollout.activate :start_new_indexing

  unless elasticsearch_enabled?($elasticsearch)
    $rollout.activate :stop_old_indexing
    $rollout.activate :use_new_search
  end
end
