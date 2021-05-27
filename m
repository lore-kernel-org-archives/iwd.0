Content-Type: multipart/mixed; boundary="===============8593303796063049529=="
MIME-Version: 1.0
From: Pranav Jerry <libreinator@disroot.org>
Subject: Re: Using iwd.py for a project
Date: Thu, 27 May 2021 21:00:57 +0530
Message-ID: <L3VRTQ.6F0PZMSHMHSI2@disroot.org>
In-Reply-To: <0601f373-8021-ec2b-b34f-c059115137f8@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8593303796063049529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

Thanks for the reply. I found out I cannot use iwd.py
without some modifications, and I couldn't run
test-runner, maybe because I used the kernel
that came packaged with the distribution (Arch).

For now, naxalnet only uses iwd to find out how many
devices are available, and starts an ad-hoc network
on the first device found. If there is a second device,
it starts an AP on it so that other devices can connect
to the mesh network without installing any software
just for joining the mesh.

So I'll just use the D-Bus API via python-dasbus.
 From test/list-devices I got some idea on
how to find all devices, and other things from
the other files.

On Wed, May 26 2021 at 03:41:09 PM -0500 -0500, Denis Kenzior
<denkenz@gmail.com> wrote:
>  Hi Pranav,
> =

>  On 5/26/21 11:25 AM, Pranav Jerry wrote:
>>  Hi!
>> =

>>  I'm the developer of naxalnet [1], a shell
>>  script to create a BATMAN-Advanced mesh network without bothering
>>  with any
>>  configuration.
>> =

>>  It uses iwd to create an ad-hoc network and then configures the
>>  network using
>>  systemd-networkd.
>>  It is currently in alpha stage.
>> =

>>  I'm working on rewriting it in python and found out controlling iwd
>>  via D-Bus
>>  is not easy as I thought. I searched the web for python libraries to
>>  control iwd
>>  and found out on stackoverflow [2] that the iwd git repo had python3
>>  examples
>>  in `tests/`.
>> =

>>  On further exploring, I found a python library for using iwd,
>>  `autotests/util/iwd.py`. The python scripts used for testing in
>>  `autotests`
>>  showed it was easy to use and was just what I needed to use for
>>  connecting
>>  to iwd in my project.
>> =

>>  But I couldn't find any information on the library on
>>  iwd.wiki.kernel.org and
>>  I think it was developed for internal use. The library is not on
>>  PyPi either.
>>  I want to use the library in naxalnet, which is at present a
>>  single-file file that
>>  starts with `#!/usr/bin/env python3`, meant to reside as
>>  `/usr/bin/naxalnet`.
> =

>  That is not surprising because there isn't any :)
> =

>> =

>>  How do I make iwd.py importable? I don't want to include iwd.py as a
>>  file
>>  when I package naxalnet for distribution.
>>  So it probably needs to be installed by pip as a library, or by the
>>  OS package
>>  manager. Can you or any other developers make iwd.py available as a
>>  python
>>  package installable by pip?
> =

>  iwd.py is part of our auto test framework, it makes many assumptions
>  about its environment (i.e. running inside test-runner), so it isn't
>  really something that is meant as general purpose D-Bus binding.
> =

>  Given the above, we have no plans to distribute it outside of the iwd
>  git repo.  However, the code is open source.  So if you or someone
>  wants to base a proper binding on it, feel free.
> =

>> =

>>  I'm not an experienced dev and I'm not used to python packaging, so
>>  correct me
>>  if I'm wrong anywhere.
>> =

>>  [1]: https://git.disroot.org/pranav/naxalnet
>>  [2]:
>>  =

>> =7Fhttps://stackoverflow.com/questions/60358001/accessing-iwd-dbus-inter=
face-from-python
>>  =7F
> =

>  Regards,
>  -Denis





--===============8593303796063049529==--

