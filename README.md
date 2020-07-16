# wstunnel-sshd

[<img src="https://img.shields.io/docker/pulls/flaviostutz/wstunnel-sshd"/>](https://hub.docker.com/r/flaviostutz/wstunnel-sshd)
[<img src="https://img.shields.io/docker/automated/flaviostutz/wstunnel-sshd"/>](https://hub.docker.com/r/flaviostutz/wstunnel-sshd)

Websocket Tunnel to SSH inside container. Primarily used for accessing a SSH session inside a private container network through simple HTTP.

Originally created to enable maintenance connections (by SSH port forwarding or Socks5) to containers inside private application networks on OpenShift, because container services in OpenShift are only exposed through HTTP(S). 

Maybe used for por forwarding connections to databases, internal http endpoints and so.

## Usage

* Run this container inside the network (behind a http edge) you want to create a entrypoint. For example, inside a project in OpenShift or elsewhere.

   ``docker run -p 8080:80 -e GOOGLE_AUTHENTICATOR_ENABLE=true -e ROOT_PASSWORD=abc123 flaviostutz/wstunnel-sshd``

* If you enabled the Google Authenticator option
  * Provision your device using Google Authenticator App. See the keys and qrcode on container logs
  * The SSH and Google Authenticator private keys are generated once by container instance

* On the client machine

  * Install wstunnel
 
     ``npm install -g wstunnel``
   
  * Connect SSH to the target container through wstunnel
 
     ``ssh -o ProxyCommand="wstunnel -c -t stdio:%h:%p ws://localhost:8080" root@localhost``
   
  * You can create port forwardings too
 
     ``ssh -o ProxyCommand="wstunnel -c -t stdio:%h:%p wss://wstunnel-tests.openshift.com" -L 8888:whoami.tests.svc:8000 root@localhost``
   
  * If you enabled Google Authenticator, enter the numbers displayed on Google Authenticator App during login verification when asked for "Verification Code"
