defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KV.Bucket.start_link([])
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "deletes a value by key", %{bucket: bucket} do
    KV.Bucket.put(bucket, "to_be_deleted", 12345)
    assert KV.Bucket.get(bucket, "to_be_deleted") == 12345

    KV.Bucket.delete(bucket, "to_be_deleted")
    assert KV.Bucket.get(bucket, "to_be_deleted") == nil
  end
end
