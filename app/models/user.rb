class User < ActiveRecord::Base
  after_commit :flush_redis

  validates :name, :email, presence: true

  def self.cached_find(id)
    Rails.cache.fetch("users:#{id}"){ find(id) }
  end

  def self.cached_all
    Rails.cache.fetch("users", ex: 300){ all.order("created_at DESC").to_a }
  end

  def flush_redis
    Rails.cache.delete("users:#{self.id}")
  end

  def cached_track_vists
    Rails.cache.increment("users:#{self.id}:visits", 1)
  end

  def cached_visits
    Rails.cache.fetch("users:#{self.id}:visits")
  end
end
