# symfony4_php7.2

This is the symfony 4 `flex` quick demo based on [the article](http://fabien.potencier.org/symfony4-demo.html).

The project starts two docker containers:

- flex_webapp: nginx + php7.2-fpm
- flex_db: MySQL server latest


# How to start

### build and start the containers
`bash flex.sh up`

### check if nginx, fpm works well
open a browser and open on:

`http://localhost:8080`

The phpinfo page should be shown correctly.
![phpinfo](./attachments/phpinfo_7.2.png)

### initial database and schema for backend webapp
```$xslt

docker exec -it flex_webapp demo/bin/console doctrine:database:create
docker exec -it flex_webapp demo/bin/console doctrine:schema:update --force

```

this will create a database named `symfony` and create the table schema from `src/Entity/Product.php`, which will be
used by backend web app `easy_admin`. To test it, open the browser on:

`http://127.0.0.1:8000/admin`

It should show the product page in admin area. 
![phpinfo](./attachments/easy_admin.png)