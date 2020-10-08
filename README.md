# docker postgres

Postgres with wal2json and slots replications

* postgres 12 (for now)
* [wal2json](https://github.com/eulerto/wal2json)

## run

```bash
docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d habx/postgres
```
