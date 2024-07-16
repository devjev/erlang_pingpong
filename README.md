erlang_pingpong
=====

A asdasdas

Build
-----

    $ rebar3 compile

Run
---

Make sure to start the application with an sname that includes a hostname 
explicitly, as just going `--sname pingpong` on my MBP doesn't seem to work as 
I intend it to work.

    $ rebar3 shell --sname pingpong@localhost --setcookie <COOKIE>

