#T2Ku

The semantic and automated deductive wiki of Mathematics.

##Features
1. auto save on "Parse" and "Prove"
2. no extra requests if not changed in #1


##deployment

vncserver -geometry 1920x1200 -depth 24 :1

vncserver -geometry 1680x1050 -depth 24 :2

http://en.t2ku131.org:3000/

----

su - pg

postgres -D /usr/local/pgsql/data >>/usr/local/pgsql/logfile.log 2>&1 &

psql t2ku < t2ku.sql


postgres -D /usr/local/pgsql/data


----------

Smart:
kill -TERM `head -1 /usr/local/pgsql/data/postmaster.pid`

Fast:
kill -INT `head -1 /usr/local/pgsql/data/postmaster.pid`

----------

createdb t2ku

createuser -P -s -e super

