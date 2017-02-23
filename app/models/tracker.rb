class Tracker
  def add_hit(id)
    $redis.sadd("users", id)
    $redis.hincrby("stats/users:#{id}", "total", 1)
    $redis.hincrby("stats/users:#{id}", Date.today.to_s(:number), 1)
  end

  def hits(id, day=Date.today)
    $redis.hget("stats/users:#{id}", day.to_s(:number)).to_i
  end

  def over_limit?(id, limit)
    hits(id) > limit
  end

  def keys(beg_p, end_p)
    keys = []
    while beg_p <= end_p
      keys << beg_p.to_s(:number)
      beg_p += 1.day
    end

    keys
  end

  def stats_for_period(id, beginning_of_period, end_of_period)
    beg_p = Date.parse(beginning_of_period)
    end_p = Date.parse(end_of_period)
    $redis.hmget "stats/users:#{id}", *keys(beg_p, end_p)
  end

  def top_users(period: "total", limit: 5)
    $redis.sort("users",
      :by => "stats/users:*->#{period}",
      :order => "DESC",
      :get => ["#", "stats/users:*->#{period}"], :limit => [0, limit]
    )
  end
end
