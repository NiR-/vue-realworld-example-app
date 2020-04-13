# Buildkit bug reproducer

* 1st build: 3.27MB
* 2nd build: 147.38MB
* 3st build: 2.16MB
* 4st build: 2.16MB
* 5st build: 43.64KB

```
$ zbuild update
$ zbuild debug-llb --json > build1.json
$ make build
docker buildx build --load -t vue-example-app -f zbuild.yml --target dev .
[+] Building 3.9s (9/9) FINISHED
 => [internal] load .dockerignore                                                                                                                                                   0.0s
 => => transferring context: 2B                                                                                                                                                     0.0s
 => [internal] load build definition from zbuild.yml                                                                                                                                0.0s
 => => transferring dockerfile: 32B                                                                                                                                                 0.0s
 => resolve image config for docker.io/akerouanton/zbuilder:200413-03                                                                                                               0.0s
 => CACHED docker-image://docker.io/akerouanton/zbuilder:200413-03                                                                                                                  0.0s
 => load zbuild config files from build context                                                                                                                                     0.0s
 => => transferring context: 615B                                                                                                                                                   0.0s
 => local://context                                                                                                                                                                 1.5s
 => => transferring context: 3.27MB                                                                                                                                                 1.4s
 => docker-image://docker.io/library/node:lts-alpine@sha256:0354aa58867fb873ef47d8345d21dddef1309a36226a425217910bc19fde5fb5                                                        0.0s
 => => resolve docker.io/library/node:lts-alpine@sha256:0354aa58867fb873ef47d8345d21dddef1309a36226a425217910bc19fde5fb5                                                            0.0s
 => Mkdir /app                                                                                                                                                                      0.1s
 => exporting to image                                                                                                                                                              0.3s
 => => exporting layers                                                                                                                                                             0.3s
 => => writing image sha256:8857a6213b1b0e221f47f8d1a39e750c139a3f998834814ce6549c912c7af88b                                                                                        0.0s
 => => naming to docker.io/library/vue-example-app                                                                                                                                  0.0s

$ make install-deps
docker run --rm -it -v /home/akerouanton/projets/github.com/NiR-/vue-realworld-example-app:/app -w /app vue-example-app yarn install
yarn install v1.22.4
[1/4] Resolving packages...
[2/4] Fetching packages...
warning url-loader@1.1.2: Invalid bin field for "url-loader".
info fsevents@1.2.9: The platform "linux" is incompatible with this module.
info "fsevents@1.2.9" is an optional dependency and failed compatibility check. Excluding it from installation.
[3/4] Linking dependencies...
warning "@vue/eslint-config-prettier > eslint-config-prettier@3.6.0" has unmet peer dependency "eslint@>=3.14.1".
warning "@vue/eslint-config-prettier > eslint-plugin-prettier@3.1.0" has unmet peer dependency "eslint@>= 5.0.0".
warning " > sass-loader@7.3.1" has unmet peer dependency "webpack@^3.0.0 || ^4.0.0".
[4/4] Building fresh packages...
Done in 25.27s.

$ zbuild debug-llb --json > build2.json
$ diff build*
$ make build
docker buildx build --load -t vue-example-app -f zbuild.yml --target dev .
[+] Building 5.6s (9/9) FINISHED
 => [internal] load .dockerignore                                                                                                                                                   0.0s
 => => transferring context: 2B                                                                                                                                                     0.0s
 => [internal] load build definition from zbuild.yml                                                                                                                                0.0s
 => => transferring dockerfile: 32B                                                                                                                                                 0.0s
 => resolve image config for docker.io/akerouanton/zbuilder:200413-03                                                                                                               0.0s
 => CACHED docker-image://docker.io/akerouanton/zbuilder:200413-03                                                                                                                  0.0s
 => load zbuild config files from build context                                                                                                                                     0.0s
 => => transferring context: 63B                                                                                                                                                    0.0s
 => local://context                                                                                                                                                                 3.2s
 => => transferring context: 147.38MB                                                                                                                                               3.1s
 => docker-image://docker.io/library/node:lts-alpine@sha256:0354aa58867fb873ef47d8345d21dddef1309a36226a425217910bc19fde5fb5                                                        0.0s
 => CACHED Mkdir /app                                                                                                                                                               0.0s
 => exporting to image                                                                                                                                                              0.0s
 => => exporting layers                                                                                                                                                             0.0s
 => => writing image sha256:f06535692bfbf08e7880f32a809ae0620e5d58896f9dfced194fbab1e0102e55                                                                                        0.0s
 => => naming to docker.io/library/vue-example-app                                                                                                                                  0.0s

$ zbuild debug-llb --json > build3.json
$ diff build2.json build3.json
$ make build
docker buildx build --load -t vue-example-app -f zbuild.yml --target dev .
[+] Building 3.0s (9/9) FINISHED
 => [internal] load build definition from zbuild.yml                                                                                                                                0.0s
 => => transferring dockerfile: 32B                                                                                                                                                 0.0s
 => [internal] load .dockerignore                                                                                                                                                   0.0s
 => => transferring context: 2B                                                                                                                                                     0.0s
 => resolve image config for docker.io/akerouanton/zbuilder:200413-03                                                                                                               0.0s
 => CACHED docker-image://docker.io/akerouanton/zbuilder:200413-03                                                                                                                  0.0s
 => load zbuild config files from build context                                                                                                                                     0.0s
 => => transferring context: 63B                                                                                                                                                    0.0s
 => local://context                                                                                                                                                                 0.8s
 => => transferring context: 2.16MB                                                                                                                                                 0.8s
 => docker-image://docker.io/library/node:lts-alpine@sha256:0354aa58867fb873ef47d8345d21dddef1309a36226a425217910bc19fde5fb5                                                        0.0s
 => CACHED Mkdir /app                                                                                                                                                               0.0s
 => exporting to image                                                                                                                                                              0.0s
 => => exporting layers                                                                                                                                                             0.0s
 => => writing image sha256:dea7d363aaec92a0e781c28fd3e9427cb753209e7028b7fd5e138df787853ad7                                                                                        0.0s
 => => naming to docker.io/library/vue-example-app                                                                                                                                  0.0s

$ make build
docker buildx build --load -t vue-example-app -f zbuild.yml --target dev .
[+] Building 3.2s (9/9) FINISHED
 => [internal] load .dockerignore                                                                                                                                                   0.0s
 => => transferring context: 2B                                                                                                                                                     0.0s
 => [internal] load build definition from zbuild.yml                                                                                                                                0.0s
 => => transferring dockerfile: 32B                                                                                                                                                 0.0s
 => resolve image config for docker.io/akerouanton/zbuilder:200413-03                                                                                                               0.0s
 => CACHED docker-image://docker.io/akerouanton/zbuilder:200413-03                                                                                                                  0.0s
 => load zbuild config files from build context                                                                                                                                     0.0s
 => => transferring context: 63B                                                                                                                                                    0.0s
 => local://context                                                                                                                                                                 0.8s
 => => transferring context: 2.16MB                                                                                                                                                 0.7s
 => docker-image://docker.io/library/node:lts-alpine@sha256:0354aa58867fb873ef47d8345d21dddef1309a36226a425217910bc19fde5fb5                                                        0.0s
 => CACHED Mkdir /app                                                                                                                                                               0.0s
 => exporting to image                                                                                                                                                              0.0s
 => => exporting layers                                                                                                                                                             0.0s
 => => writing image sha256:d640e630192a8391c90b6b5a3a881a0a44d770b4e0ce32f7b76dfd12ebdaa6b9                                                                                        0.0s
 => => naming to docker.io/library/vue-example-app                                                                                                                                  0.0s

$ rm -rf node_module
$ zbuild debug-llb --json > build5.json
$ diff build4.json build5.json
$ make build
docker buildx build --load -t vue-example-app -f zbuild.yml --target dev .
[+] Building 2.9s (9/9) FINISHED
 => [internal] load .dockerignore                                                                                                                                                   0.0s
 => => transferring context: 2B                                                                                                                                                     0.0s
 => [internal] load build definition from zbuild.yml                                                                                                                                0.0s
 => => transferring dockerfile: 32B                                                                                                                                                 0.0s
 => resolve image config for docker.io/akerouanton/zbuilder:200413-03                                                                                                               0.0s
 => CACHED docker-image://docker.io/akerouanton/zbuilder:200413-03                                                                                                                  0.0s
 => load zbuild config files from build context                                                                                                                                     0.0s
 => => transferring context: 63B                                                                                                                                                    0.0s
 => local://context                                                                                                                                                                 0.6s
 => => transferring context: 43.64kB                                                                                                                                                0.5s
 => docker-image://docker.io/library/node:lts-alpine@sha256:0354aa58867fb873ef47d8345d21dddef1309a36226a425217910bc19fde5fb5                                                        0.0s
 => CACHED Mkdir /app                                                                                                                                                               0.0s
 => exporting to image                                                                                                                                                              0.0s
 => => exporting layers                                                                                                                                                             0.0s
 => => writing image sha256:476e78d61e709ae4b2cee434cadb0695f7bcc2500dbccfd3843fa28715be6935                                                                                        0.0s
 => => naming to docker.io/library/vue-example-app                                                                                                                                  0.0s
```
