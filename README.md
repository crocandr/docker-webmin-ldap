# Webmin container for LDAP Administration

## Build

```
docker build -t croc/webmin-ldap .
```

## Run

```
docker run -tid --name=webmin-ldap -p 10000:10000 sandras/webmin-ldap /opt/start.sh
```

You can access Your webmin UI on the https://<your docker host IP>:10000 URL.
Default login is: root / SuperSecret

Good Luck!
