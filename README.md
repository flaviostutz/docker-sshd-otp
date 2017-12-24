# wstunnel-sshd
Websocket Tunnel to SSH inside container. Primarily used for accessing a SSH session inside a private container network through simple HTTP.

Originally created to enable maintenance connections (by SSH port forwarding or Socks5) to containers inside private application networks on OpenShift, because container services in OpenShift are only exposed through HTTP(S). 

Maybe used for por forwarding connections to databases, internal http endpoints and so.

## Usage

* Run this container inside the network (behind a http edge) you want to create a entrypoint. For example, inside a project in OpenShift or elsewhere.
   ``docker run -p 8080:80 flaviostutz/wstunnel-sshd``

* On the client machine
 ** Install wstunnel
   ``npm install -g wstunnel``
 ** Connect SSH to the target container through wstunnel
   ``ssh -o ProxyCommand="wstunnel -c -t stdio:%h:%p ws://localhost:8080" root@localhost``
 ** You can create port forwardings too
   ``ssh -o ProxyCommand="wstunnel -c -t stdio:%h:%p ws://mycontainer-openshift" -o UserKnownHostsFile=/dev/null -L8888:test.svc:80 root@localhost``
