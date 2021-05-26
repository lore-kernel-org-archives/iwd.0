Content-Type: multipart/mixed; boundary="===============1956869289386155324=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Using iwd.py for a project
Date: Wed, 26 May 2021 15:41:09 -0500
Message-ID: <0601f373-8021-ec2b-b34f-c059115137f8@gmail.com>
In-Reply-To: <IY2QTQ.MAEB01FKYJM7@disroot.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1956869289386155324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pranav,

On 5/26/21 11:25 AM, Pranav Jerry wrote:
> Hi!
> =

> I'm the developer of naxalnet [1], a shell
> script to create a BATMAN-Advanced mesh network without bothering with any
> configuration.
> =

> It uses iwd to create an ad-hoc network and then configures the network u=
sing
> systemd-networkd.
> It is currently in alpha stage.
> =

> I'm working on rewriting it in python and found out controlling iwd via D=
-Bus
> is not easy as I thought. I searched the web for python libraries to cont=
rol iwd
> and found out on stackoverflow [2] that the iwd git repo had python3 exam=
ples
> in `tests/`.
> =

> On further exploring, I found a python library for using iwd,
> `autotests/util/iwd.py`. The python scripts used for testing in `autotest=
s`
> showed it was easy to use and was just what I needed to use for connecting
> to iwd in my project.
> =

> But I couldn't find any information on the library on iwd.wiki.kernel.org=
 and
> I think it was developed for internal use. The library is not on PyPi eit=
her.
> I want to use the library in naxalnet, which is at present a single-file =
file that
> starts with `#!/usr/bin/env python3`, meant to reside as `/usr/bin/naxaln=
et`.

That is not surprising because there isn't any :)

> =

> How do I make iwd.py importable? I don't want to include iwd.py as a file
> when I package naxalnet for distribution.
> So it probably needs to be installed by pip as a library, or by the OS pa=
ckage
> manager. Can you or any other developers make iwd.py available as a python
> package installable by pip?

iwd.py is part of our auto test framework, it makes many assumptions about =
its =

environment (i.e. running inside test-runner), so it isn't really something=
 that =

is meant as general purpose D-Bus binding.

Given the above, we have no plans to distribute it outside of the iwd git r=
epo. =

  However, the code is open source.  So if you or someone wants to base a p=
roper =

binding on it, feel free.

> =

> I'm not an experienced dev and I'm not used to python packaging, so corre=
ct me
> if I'm wrong anywhere.
> =

> [1]: https://git.disroot.org/pranav/naxalnet
> [2]: =

> https://stackoverflow.com/questions/60358001/accessing-iwd-dbus-interface=
-from-python =

> =


Regards,
-Denis
--===============1956869289386155324==--

