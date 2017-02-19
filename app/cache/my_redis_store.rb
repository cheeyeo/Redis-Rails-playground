require 'active_support/core_ext/marshal'

class MyRedisStore < ActiveSupport::Cache::Store
  attr_reader :data

  def initialize(options={})
    super(options)
    @data = Redis.new(options)
  end

  # deletes all items from cache
  def clear(options = nil)
    @data.flushall
  end

  def cleanup(options = nil)
  end

  def increment(name, amount = 1)
    @data.incrby(name, amount)
  end

  def decrement(name, amount = 1)
    @data.decrby(name, amount)
  end

  def delete_matched(matcher, options = nil)
  end

  protected

  def deserialize_entry(raw_value)
    if raw_value
      entry = Marshal.load(raw_value) rescue raw_value
      entry.is_a?(ActiveSupport::Cache::Entry) ? entry : ActiveSupport::Cache::Entry.new(entry)
    else
      nil
    end
  end

  def read_entry(key, options)
    deserialize_entry(@data.get(key))
  end

  def write_entry(key, entry, options={})
    @data.set key, Marshal.dump(entry), options
  end

  def delete_entry(key, options)
    @data.del(key, options)
  end
end
