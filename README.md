su - pg

postgres -D /usr/local/pgsql/data >>/usr/local/pgsql/logfile.log 2>&1 &

postgres -D /usr/local/pgsql/data


----------

Smart:
kill -TERM `head -1 /usr/local/pgsql/data/postmaster.pid`

Fast:
kill -INT `head -1 /usr/local/pgsql/data/postmaster.pid`

----------

createdb t2ku

createuser -P -s -e super
