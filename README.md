# meteor-ferretdb

This is a docker compose test that runs the meteor-blaze-tutorial app using FerretDB and PostgreSQL instead of MongoDB.

https://user-images.githubusercontent.com/6295044/185584542-e8b5cc73-53be-438c-ae37-6b397890ac64.mp4

## What is FerretDB?

[FerretDB](https://www.ferretdb.io/) is a stateless proxy, which converts MongoDB protocol queries to SQL, and uses PostgreSQL as a database engine. This will be compatible with MongoDB drivers, and should work as a drop-in replacement to MongoDB in many cases.

### Getting started

```bash
git clone https://github.com/wreiske/meteor-ferretdb.git
cd meteor-ferretdb
docker-compose up -d --no-deps --build app
docker-compose up
```

Visit [http://localhost:8888](http://localhost:8888) to see the app.

## Credits

- [https://github.com/disney/meteor-base](https://github.com/disney/meteor-base)
- [https://github.com/FerretDB/example](https://github.com/FerretDB/example)

## Discussion

- [Meteor support for PostgreSQL using OxideDB / FerretDB #12150](https://github.com/meteor/meteor/discussions/12150)