# Webmin container for LDAP Administration

This is an LDAP manager container to my openldap container:

  - https://github.com/crocandr/docker-openldap
  - https://hub.docker.com/r/croc/openldap/

Not the best, but good option, and it has a web UI for easier management. :) 

## Build

```
docker build -t croc/webmin .
```

You can change the default webmin password at the build, example:
```
docker build -t croc/webmin --build-arg DEFAULT_PASS=myNewPass .
```

## Run

```
docker run -tid --name webmin -v $PWD/backup:/backup -p 10000:10000 croc/webmin
```

or with docker-compose:
```
docker-compose up -d
```

You can access Your webmin UI on the https://<your docker host IP>:10000 URL.
Default login is: root / SuperSecret
If you changed this default password, try login with your password.

## Config

You have to configure the default webmin installation.
  1. Login into the webmin UI.
  2. search "ldap" and choose "LDAP Users and Groups" module
  3. click on "Module Config" option
  4. set the default config with these parameters:

    - LDAP server host: `< your docker host that runs LDAP container >` , example: `192.168.56.103`
    - LDAP server port: `389`
    - LDAP server uses encryption?: `no`
    - Bind to LDAP server as: `cn=admin,dc=< domain >,dc=< ltd >` , example: `cn=admin,dc=mydomain,dc=site`
    - Credentials for bind name above: < ldap admin password of your ldap installation > , example: `MySecret`
    - Base for users: example: `ou=People,dc=mydomain,dc=site`
    - Base for groups: example: `ou=Group,dc=mydomain,dc=site`
    - Other objectClasses to add to new users: `inetOrgPerson posixAccount sambaSamAccount shadowAccount`
    or without "sambaSamAccount" if you don't use samba server
    - Object class to add for given name?: `inetOrgPerson`

    - LDAP properties for all new users: `mail: ${USER}@example.com`
    - LDAP properties for modified users: `mail: ${USER}@example.com`
    - Extra LDAP user properties to allow editing of: `mail email address`

    - Lowest UID for new users: `5000`
      (increment and choose a free automatically)
    - Lowest GID for new groups: `5000`
      (increment and choose a free automatically)

    - Default primary group for new users: `BaseGroup`
      or your default LDAP group
    - Default shell for new users: `/bin/false`

   other options is your choice :)

  5. click the save button at the buttom of the page
  6. you can see an empty list or your users and groups in your LDAP after this setup


### Config Backup and Restore


#### Script method

You can use backup script:
```
docker exec -ti webmin /opt/backup.sh
```

This script copies all files and folders from the `/etc/webmin` folder to the `/backup` folder.

You can restore backed up configuration from the `/backup` folder to the `/etc/webmin` folder with this command:
```
docker exec -ti webmin /opt/restore.sh
```
But don't forget! You have to restart webmin container after the restore to update and reread config files. 


#### Manual method

You should backup the `/etc/webmin/ldap-useradmin/config` from the webmin container. Example:
```
docker cp webmin:/etc/webmin/ldap-useradmin/config /backup/ldap-config
```

The restore process is reverse. Example:
```
docker cp /backup/ldap-config webmin:/etc/webmin/ldap-useradmin/config
```

You can backup and restore every used module like this.



Good Luck!
