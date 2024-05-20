Ubuntu desktop (lxde) + noVnc
===
This is a minimal image to run Ubuntu LXDE desktop with Firefox pre-installed.

## How to use



```bash
git clone https://github.com/AndroidEl93/docker-lxde-novnc.git

mkdir /home/folder

cd docker-lxde-novnc

docker build --build-arg VNC_PASSWORD=yourpassword -t lxde .

docker run -d --restart always -p 3000:6080 -v /home/folder:/home/folder --memory=800m --cpus=1 lxde
```

## How to connect

http://{server ip}:3000