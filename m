Content-Type: multipart/mixed; boundary="===============0772336717913708673=="
MIME-Version: 1.0
From: Pranav Jerry <libreinator@disroot.org>
Subject: Using iwd.py for a project
Date: Wed, 26 May 2021 21:55:29 +0530
Message-ID: <IY2QTQ.MAEB01FKYJM7@disroot.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0772336717913708673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

I'm the developer of naxalnet [1], a shell
script to create a BATMAN-Advanced mesh network without bothering with =

any
configuration.

It uses iwd to create an ad-hoc network and then configures the network =

using
systemd-networkd.
It is currently in alpha stage.

I'm working on rewriting it in python and found out controlling iwd via =

D-Bus
is not easy as I thought. I searched the web for python libraries to =

control iwd
and found out on stackoverflow [2] that the iwd git repo had python3 =

examples
in `tests/`.

On further exploring, I found a python library for using iwd,
`autotests/util/iwd.py`. The python scripts used for testing in =

`autotests`
showed it was easy to use and was just what I needed to use for =

connecting
to iwd in my project.

But I couldn't find any information on the library on =

iwd.wiki.kernel.org and
I think it was developed for internal use. The library is not on PyPi =

either.
I want to use the library in naxalnet, which is at present a =

single-file file that
starts with `#!/usr/bin/env python3`, meant to reside as =

`/usr/bin/naxalnet`.

How do I make iwd.py importable? I don't want to include iwd.py as a =

file
when I package naxalnet for distribution.
So it probably needs to be installed by pip as a library, or by the OS =

package
manager. Can you or any other developers make iwd.py available as a =

python
package installable by pip?

I'm not an experienced dev and I'm not used to python packaging, so =

correct me
if I'm wrong anywhere.

[1]: https://git.disroot.org/pranav/naxalnet
[2]: =

https://stackoverflow.com/questions/60358001/accessing-iwd-dbus-interface-f=
rom-python


--===============0772336717913708673==--

