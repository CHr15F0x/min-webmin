# min-webmin
Minimalistic yet useful webmin installation bundle suited for embedded devices.<br/>
__The installation is fully portable, using its own standalone perl build, which is included in the bundle.__<br/>
<br/>
To prepare the bundle just run:
```
./build.sh
```
To install:
```
tar xzf min-webmin.tar.gz
cd min-webmin
./install.sh
```
To rebuild PERL:
```
cd perl_src
./build.sh
```
