Content-Type: multipart/mixed; boundary="===============5521753543522839209=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: how to disable colorized/grey output from iwctl commands
Date: Sun, 08 Mar 2020 08:35:33 -0500
Message-ID: <CAG17S_NQbJEQdv6twFogVoZ7gc__QNQXwy48qjyHMckGPEVjaA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5521753543522839209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I am trying to move to connman/iwd from netctl on a RPi. It currently has a
PHP based UI to display the info and allow connections, etc. Connmanctl
commands  respond with text (no control characters, no colorization) iwdctl
responds with text with control characters. If I use this command::
iwctl station wlan0 get-networks
I get a response which looks like clear txt in my linux terminal connected
by ssh, but it has control characters indicating which network is connected
and the signal strength stars are all present and are either full
brightness of grey depending on the signal. THis makes it challenging to
feed this into php to be displayed in a browser... Is there a hidden flag
to turn this off? Can this be added? If there are other suggestions on how
to best deal with this, I am soliciting advice... What I get is this in php:

sysCmd($str) ###  iwctl station wlan0 get-networks | sed -e '1,4d' | tr -s
' '
sysCmd() output: ### $data type =3D array
sysCmd() output: ###  ['0'] =3D>  Edventures psk ***ESC[1;30m*ESC[0m
sysCmd() output: ###  ['1'] =3D>  Oliwia2009 psk *ESC[1;30m***ESC[0m
sysCmd() output: ###  ['2'] =3D>  HouseStark01 psk *ESC[1;30m***ESC[0m
sysCmd() output: ###  ['3'] =3D>  ATTeHeTKI2 psk *ESC[1;30m***ESC[0m
sysCmd() output: ###  ['4'] =3D>  monterrey psk *ESC[1;30m***ESC[0m
sysCmd() output: ###  ['5'] =3D>  ATTxZIQ4wa psk *ESC[1;30m***ESC[0m
sysCmd() output: ###  ['6'] =3D>  Wemo.Mini.25B open *ESC[1;30m***ESC[0m
sysCmd() output: ###  ['7'] =3D>  xfinitywifi open *ESC[1;30m***ESC[0m
sysCmd() output: ###  ['8'] =3D>  ESC[1;30m> ESC[0mspg2 psk ****

I am trying to figure out how to use sed to remove the control characters,
but tit would be easier if I could just turn it off. Is there a flag? Could
one be added?

Thanks,

Gearhead

--===============5521753543522839209==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5JIGFtIHRyeWluZyB0byBtb3ZlIHRvIGNvbm5tYW4vaXdkIGZy
b20gbmV0Y3RsIG9uIGEgUlBpLiBJdCBjdXJyZW50bHkgaGFzIGEgUEhQIGJhc2VkIFVJIHRvIGRp
c3BsYXkgdGhlIGluZm8gYW5kIGFsbG93IGNvbm5lY3Rpb25zLCBldGMuIENvbm5tYW5jdGwgY29t
bWFuZHPCoCByZXNwb25kIHdpdGggdGV4dCAobm8gY29udHJvbCBjaGFyYWN0ZXJzLCBubyBjb2xv
cml6YXRpb24pIGl3ZGN0bCByZXNwb25kcyB3aXRoIHRleHQgd2l0aCBjb250cm9sIGNoYXJhY3Rl
cnMuIElmIEkgdXNlIHRoaXMgY29tbWFuZDo6PC9kaXY+PGRpdj5pd2N0bCBzdGF0aW9uIHdsYW4w
IGdldC1uZXR3b3JrczwvZGl2PjxkaXY+SSBnZXQgYSByZXNwb25zZSB3aGljaCBsb29rcyBsaWtl
IGNsZWFyIHR4dCBpbiBteSBsaW51eCB0ZXJtaW5hbCBjb25uZWN0ZWQgYnkgc3NoLCBidXQgaXQg
aGFzIGNvbnRyb2wgY2hhcmFjdGVycyBpbmRpY2F0aW5nIHdoaWNoIG5ldHdvcmsgaXMgY29ubmVj
dGVkIGFuZCB0aGUgc2lnbmFsIHN0cmVuZ3RoIHN0YXJzIGFyZSBhbGwgcHJlc2VudCBhbmQgYXJl
IGVpdGhlciBmdWxsIGJyaWdodG5lc3Mgb2YgZ3JleSBkZXBlbmRpbmcgb24gdGhlIHNpZ25hbC4g
VEhpcyBtYWtlcyBpdCBjaGFsbGVuZ2luZyB0byBmZWVkIHRoaXMgaW50byBwaHAgdG8gYmUgZGlz
cGxheWVkIGluIGEgYnJvd3Nlci4uLiBJcyB0aGVyZSBhIGhpZGRlbiBmbGFnIHRvIHR1cm4gdGhp
cyBvZmY/IENhbiB0aGlzIGJlIGFkZGVkPyBJZiB0aGVyZSBhcmUgb3RoZXIgc3VnZ2VzdGlvbnMg
b24gaG93IHRvIGJlc3QgZGVhbCB3aXRoIHRoaXMsIEkgYW0gc29saWNpdGluZyBhZHZpY2UuLi4g
V2hhdCBJIGdldCBpcyB0aGlzIGluIHBocDo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PnN5c0Nt
ZCgkc3RyKSAjIyMgwqBpd2N0bCBzdGF0aW9uIHdsYW4wIGdldC1uZXR3b3JrcyB8IHNlZCAtZSAm
IzM5OzEsNGQmIzM5OyB8IHRyIC1zICYjMzk7ICYjMzk7PGJyPnN5c0NtZCgpIG91dHB1dDogIyMj
ICRkYXRhIHR5cGUgPSBhcnJheTxicj5zeXNDbWQoKSBvdXRwdXQ6ICMjIyDCoFsmIzM5OzAmIzM5
O10gPSZndDsgwqBFZHZlbnR1cmVzIHBzayAqKipFU0NbMTszMG0qRVNDWzBtPGJyPnN5c0NtZCgp
IG91dHB1dDogIyMjIMKgWyYjMzk7MSYjMzk7XSA9Jmd0OyDCoE9saXdpYTIwMDkgcHNrICpFU0Nb
MTszMG0qKipFU0NbMG08YnI+c3lzQ21kKCkgb3V0cHV0OiAjIyMgwqBbJiMzOTsyJiMzOTtdID0m
Z3Q7IMKgSG91c2VTdGFyazAxIHBzayAqRVNDWzE7MzBtKioqRVNDWzBtPGJyPnN5c0NtZCgpIG91
dHB1dDogIyMjIMKgWyYjMzk7MyYjMzk7XSA9Jmd0OyDCoEFUVGVIZVRLSTIgcHNrICpFU0NbMTsz
MG0qKipFU0NbMG08YnI+c3lzQ21kKCkgb3V0cHV0OiAjIyMgwqBbJiMzOTs0JiMzOTtdID0mZ3Q7
IMKgbW9udGVycmV5IHBzayAqRVNDWzE7MzBtKioqRVNDWzBtPGJyPnN5c0NtZCgpIG91dHB1dDog
IyMjIMKgWyYjMzk7NSYjMzk7XSA9Jmd0OyDCoEFUVHhaSVE0d2EgcHNrICpFU0NbMTszMG0qKipF
U0NbMG08YnI+c3lzQ21kKCkgb3V0cHV0OiAjIyMgwqBbJiMzOTs2JiMzOTtdID0mZ3Q7IMKgV2Vt
by5NaW5pLjI1QiBvcGVuICpFU0NbMTszMG0qKipFU0NbMG08YnI+c3lzQ21kKCkgb3V0cHV0OiAj
IyMgwqBbJiMzOTs3JiMzOTtdID0mZ3Q7IMKgeGZpbml0eXdpZmkgb3BlbiAqRVNDWzE7MzBtKioq
RVNDWzBtPGJyPnN5c0NtZCgpIG91dHB1dDogIyMjIMKgWyYjMzk7OCYjMzk7XSA9Jmd0OyDCoEVT
Q1sxOzMwbSZndDsgRVNDWzBtc3BnMiBwc2sgKioqKjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
SSBhbSB0cnlpbmcgdG8gZmlndXJlIG91dCBob3cgdG8gdXNlIHNlZCB0byByZW1vdmUgdGhlIGNv
bnRyb2wgY2hhcmFjdGVycywgYnV0IHRpdCB3b3VsZCBiZSBlYXNpZXIgaWYgSSBjb3VsZCBqdXN0
IHR1cm4gaXQgb2ZmLiBJcyB0aGVyZSBhIGZsYWc/IENvdWxkIG9uZSBiZSBhZGRlZD88L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rcyw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkdlYXJo
ZWFkPGJyPjwvZGl2PjwvZGl2Pgo=

--===============5521753543522839209==--

