defmodule CacheTest do
  use ExUnit.Case, async: true
  doctest Cache


  describe "Getting cache" do
    test "when getting a key from an empty cache" do
      Cache.start_link
      assert Cache.get == %{}
      assert Cache.read("sflkjsdflkjsdf") == nil
    end

    test "when getting an unknown key from a cache with keys" do
      Cache.start_link

      Cache.write("key1", 1)

      assert Cache.read("key2") == nil
    end

    test "when getting a key for a valid entry in the cache" do
      Cache.start_link

      Cache.write("my_key", 10923)

      assert Cache.read("my_key") == 10923
    end
  end
end
