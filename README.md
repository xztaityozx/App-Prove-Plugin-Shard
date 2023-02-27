# App::Prove::Plugin::Shard 

Split tests in multiple subsets (like Jest)

## SYNOPSIS

  # Run tests using shard 1 of 3

  prove -PShard=1,3 ./t

## DESCRIPTION

This plugin allows you to shard your test suite into multiple subsets. It is similar to the `--shard` option in Jest.

## OPTIONS

### -P Shard=shard_number,total_shards

Specifies the shard number and total number of shards. The shard number indicates the index of the shard to be executed and must be a positive integer. The total number of shards indicates the number of shards into which the tests are divided and must also be a positive integer. Shard number must be less than or equal to total shards.

## Example

```sh
$ git clone https://github.com/xztaityozx/App-Prove-Plugin-Shard
$ cd App-Prove-Plugin-Shard
$ cpm install

$ prove -PShard=1,3 ./example_tests/
example_tests/1.t ... ok   
example_tests/11.t .. ok   
example_tests/14.t .. ok   
example_tests/17.t .. ok   
example_tests/2.t ... ok   
example_tests/22.t .. ok   
example_tests/25.t .. ok   
example_tests/28.t .. ok   
example_tests/30.t .. ok   
example_tests/33.t .. ok   
example_tests/36.t .. ok   
example_tests/39.t .. ok   
example_tests/41.t .. ok   
example_tests/44.t .. ok   
example_tests/47.t .. ok   
example_tests/5.t ... ok   
example_tests/52.t .. ok   
example_tests/55.t .. ok   
example_tests/58.t .. ok   
example_tests/60.t .. ok   
example_tests/63.t .. ok   
example_tests/66.t .. ok   
example_tests/69.t .. ok   
example_tests/71.t .. ok   
example_tests/74.t .. ok   
example_tests/77.t .. ok   
example_tests/8.t ... ok   
example_tests/82.t .. ok   
example_tests/85.t .. ok   
example_tests/88.t .. ok   
example_tests/90.t .. ok   
example_tests/93.t .. ok   
example_tests/96.t .. ok   
example_tests/99.t .. ok   
All tests successful.
Files=34, Tests=34,  1 wallclock secs ( 0.05 usr  0.00 sys +  1.14 cusr  0.09 csys =  1.28 CPU)
Result: PASS
```

## COPYRIGHT AND LICENCE

[MIT](./LICENSE)

