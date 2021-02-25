# Container to build Mendix applications (.mda)
This container makes it possible to build Mendix applications on any system that supports docker. It can be especially useful when your maintaining your own build processes.

This project is modified based on https://github.com/WebFlight/mxbuild.

## How-to
The following command will create a release package.
```
docker run -i \
  -e "SVN_USER=user@mendix.com" \
  -e "SVN_PASS=password" \
  -e "RELEASE_VERSION=RELEASE_VERSION" \
  -e "SVN_HOST=TEAM_SERVER_URL" \
  -e "MODEL_VERSION=YOUR_MENDIX_VERSION" \
  -e "MXAPP_NAME=YOUR_MXAPP_NAME" \
  -v /fully/qualified/path:/releases \
  tbn_mxbuild:beta-3
```

Following a list of the arguments:
- First we are passing in the required arguments to connect to the teamserver.
  - `SVN_USER` The email address used to login to sprintr and has access to the project your trying to build.
  - `SVN_PASS` The password that belongs to the email address.
  - `RELEASE_VERSION` This is a SVN tag. Such a tag is automatically pushed to the repo when creating a release in the modeler. This can also be done with the svn CLI or most svn GUI tools.
  - `SVN_HOST` The teamserver url which can be found at the sprintr portal. An example url is _https://teamserver.sprintr.com/00000000-0000-0000-0000-00000000_
  - `MODEL_VERSION` The model version of your mendix project.
  - `MXAPP_NAME` The name of your mendix project.
- `-v` option stands for volume. The builder will write the release package to the releases folder in the container. Map the releases folder to any path on the host.
