Content-Type: multipart/mixed; boundary="===============0654227994752481077=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: connman integration
Date: Wed, 03 Jun 2020 12:01:33 -0500
Message-ID: <CAG17S_PvAatbLoaygU-fRsvCE+YDKHuDh9w9d8X54e7+Kv6Okg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0654227994752481077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 I currently use iwd with NetworkManager on a couple laptops running Arch
Linux. I also am working on an RPI project with connman/iwd managing
network interfaces. Currently, if we use the connman interface to scan with
iwd, we never get a return:
"connmanctl scan wifi" just hangs and requires a ctrlC.
This was noted on the Arch connman page:
https://wiki.archlinux.org/index.php/ConnMan#Error_/net/connman/technology/=
wifi:_Not_supported
On my rpi project, we are using nginx/php to set it all up and we use the
'iwd station wlan0 scan' then 'connmanctl services' to select SSIDs. I
asked on the connman list and Daniel says that connman is waiting for a 0.

Scanning is supported with iwd. connmanctl scan is probably waiting for iwd
to respond with the scanning=3D0 signal. If iwd doesn't send out this signal
then this will hang.

Don't know if it is a connman or an iwd 'issue', but wanted to bring it up
here to see.

Keith

--===============0654227994752481077==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+CjxkaXY+SSBjdXJyZW50bHkgdXNlIGl3ZCB3aXRoIE5ldHdvcmtNYW5h
Z2VyIG9uIGEgY291cGxlIGxhcHRvcHMgcnVubmluZyBBcmNoIExpbnV4LiBJIGFsc28gYW0gd29y
a2luZyBvbiBhbiBSUEkgcHJvamVjdCB3aXRoIGNvbm5tYW4vaXdkIG1hbmFnaW5nIG5ldHdvcmsg
aW50ZXJmYWNlcy4gQ3VycmVudGx5LCBpZiB3ZSB1c2UgdGhlIGNvbm5tYW4gaW50ZXJmYWNlIHRv
IHNjYW4gd2l0aCBpd2QsIHdlIG5ldmVyIGdldCBhIHJldHVybjo8L2Rpdj48ZGl2PiZxdW90O2Nv
bm5tYW5jdGwgc2NhbiB3aWZpJnF1b3Q7IGp1c3QgaGFuZ3MgYW5kIHJlcXVpcmVzIGEgY3RybEMu
PC9kaXY+PGRpdj5UaGlzIHdhcyBub3RlZCBvbiB0aGUgQXJjaCBjb25ubWFuIHBhZ2U6PC9kaXY+
PGRpdj48YSBocmVmPSJodHRwczovL3dpa2kuYXJjaGxpbnV4Lm9yZy9pbmRleC5waHAvQ29ubk1h
biNFcnJvcl8vbmV0L2Nvbm5tYW4vdGVjaG5vbG9neS93aWZpOl9Ob3Rfc3VwcG9ydGVkIj5odHRw
czovL3dpa2kuYXJjaGxpbnV4Lm9yZy9pbmRleC5waHAvQ29ubk1hbiNFcnJvcl8vbmV0L2Nvbm5t
YW4vdGVjaG5vbG9neS93aWZpOl9Ob3Rfc3VwcG9ydGVkPC9hPjwvZGl2PjxkaXY+T24gbXkgcnBp
IHByb2plY3QsIHdlIGFyZSB1c2luZyBuZ2lueC9waHAgdG8gc2V0IGl0IGFsbCB1cCBhbmQgd2Ug
dXNlIHRoZSAmIzM5O2l3ZCBzdGF0aW9uIHdsYW4wIHNjYW4mIzM5OyB0aGVuICYjMzk7Y29ubm1h
bmN0bCBzZXJ2aWNlcyYjMzk7IHRvIHNlbGVjdCBTU0lEcy4gSSBhc2tlZCBvbiB0aGUgY29ubm1h
biBsaXN0IGFuZCBEYW5pZWwgc2F5cyB0aGF0IGNvbm5tYW4gaXMgd2FpdGluZyBmb3IgYSAwLjwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbi1sZWZ0OjQwcHgiPgpTY2Fubmlu
ZyBpcyBzdXBwb3J0ZWQgd2l0aCBpd2QuIGNvbm5tYW5jdGwgc2NhbiBpcyBwcm9iYWJseSB3YWl0
aW5nIGZvciBpd2Q8YnI+CnRvIHJlc3BvbmQgd2l0aCB0aGUgc2Nhbm5pbmc9MCBzaWduYWwuIElm
IGl3ZCBkb2VzbiYjMzk7dCBzZW5kIG91dCB0aGlzIHNpZ25hbDxicj4KdGhlbiB0aGlzIHdpbGwg
aGFuZy4gPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+RG9uJiMzOTt0IGtub3cgaWYgaXQg
aXMgYSBjb25ubWFuIG9yIGFuIGl3ZCAmIzM5O2lzc3VlJiMzOTssIGJ1dCB3YW50ZWQgdG8gYnJp
bmcgaXQgdXAgaGVyZSB0byBzZWUuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5LZWl0aDxicj48
L2Rpdj4KCjwvZGl2Pgo=

--===============0654227994752481077==--

