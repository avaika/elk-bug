# What's that about?

This is a docker-compose project to demonstrate 2 kibana bugs related to data display issues.

# Bug descriptions

## Bug 1. Incorrect values.

When we feed numerical values to field kibana might display incorrect value even though we have correct value in elastisearch.
In example I put `seqnum` field with the value constructed as "100,000,00" + @timestamp. E.g. for `timestamp == 1,552,386,661` the value for `seqnum` should be `100,000,001,552,386,661`.
However kibana displays different numbers (e.g. `100,000,001,552,386,656` instead of `100,000,001,552,386,661`). Looks like a data type mismatch. JS code expects long or similar datatype.

Workaround: define field datatype as `string`.

## Bug 2. No data is found.

In the same data feed I provided entry where seqnum is alphanum instead of numeric value. This entry is never display and there's no any hint in kibana interface, that some entries can't be displayed.
There is no even exception in browser console (which is very confusing).

Workaround: clean up index or manually update field datatype. Both doesn't work well enough.

# How to reproduce?

 1. Start ELK with `docker-compose up -d`. Logstash will send the data from `input.json` to elasticsearch automatically. No need to run generate script.
 2. Create search pattern for `fail*` index.
 3. Open created search pattern and ensure `seqnum` field is not unique.
 4. There should be one message with alphanum value for `seqnum`. Ensure it's not displayed.



