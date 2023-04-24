Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A103214
	for <iwd@lists.linux.dev>; Mon, 24 Apr 2023 17:21:48 +0000 (UTC)
Received: from smtpclient.apple (p5b3d2302.dip0.t-ipconnect.de [91.61.35.2])
	by mail.holtmann.org (Postfix) with ESMTPSA id BC009CECDE;
	Mon, 24 Apr 2023 19:21:47 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: commit IWD 8f0420c533ae6a49c4f2803afe32d5922a5236ad build error
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+iibzCE+PNRThG_fF+bzg2PheFBDpTgQ6MEqVXH40O=3LMp+Q@mail.gmail.com>
Date: Mon, 24 Apr 2023 19:21:47 +0200
Cc: iwd@lists.linux.dev,
 James Prestwood <prestwoj@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A2A4E632-4530-49F1-BBD1-D55B8C30114C@holtmann.org>
References: <CA+iibzC0O-v+Rk+799=QYmzyAZo_3XcN1mfAsM-QtnA8zc6wpw@mail.gmail.com>
 <zp2pcpoqip7qkqhzrgjd2v55yhfqfpv7qke63njyocpuphrgz7@vto2ce7jzm4g>
 <CA+iibzDF+8oYVofSLejo_YS-BLF40Wqk-nmG4H=Ssg7yTOF8uA@mail.gmail.com>
 <CA+iibzCE+PNRThG_fF+bzg2PheFBDpTgQ6MEqVXH40O=3LMp+Q@mail.gmail.com>
To: daniel antoine <univac55@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)

Hi Daniel,

> Sorry to send the same mail but I have been clumsy with the mailing =
list.
>=20
> The distribution is Grat-OS, a fork of Nutyx based on Linux from
> Scratch. Nutyx is on SysVinit, Grat-OS is on Systemd. It's an
> "unofficial" distribution.
> I compile the package in a chroot environment
>=20
> ******************************
> Chroot path: /mnt/hd
> ******************************
> root@grat-os1:/# cards search pkg-config
> (base) pkg-config 0.29.2 A system for managing library compile/link =
flags.
> (base) pkg-config.doc 0.29.2 A system for managing library =
compile/link flags.
> (base) pkg-config.man 0.29.2 A system for managing library =
compile/link flags.
>=20
> root@grat-os1:/# pkg-config --cflags --libs libedit
> -I/usr/include/editline -ledit
>=20
> to add some information the first try i cloned the iwd git at the
> lastThe distribution is Great-OS, a fork of Nutyx based on Linux from
>=20
> Scratch. Nutyx is on SysVinit, Grat-OS is on Systemd. It's an
> "unofficial" distribution.
> I compile the package in a chroot environment
>=20
> ******************************
> Chroot path: /mnt/hd
> ******************************
> root@grat-os1:/# cards search pkg-config
> (base) pkg-config 0.29.2 A system for managing library compile/link =
flags.
> (base) pkg-config.doc 0.29.2 A system for managing library =
compile/link flags.
> (base) pkg-config.man 0.29.2 A system for managing library =
compile/link flags.
> root@grat-os1:/# pkg-config --cflags --libs libedit
> -I/usr/include/editline -ledit
>=20
> to add some information the first try i cloned the iwd git at the last
> commit with readline in the makedepends. The option --enable--libedit
> was not added in the Pkgfile. The build failed with an error that the
> readline dependency was needed. I added the first log iwd.error.txt
> After I have done a second try with the option --enable-libedit and
> the dependency readline removed. The log is iwd.error 2.txt
>=20
> Best regards
>=20
> Daniel
>=20
> commit with readline in the makedepends. The option --enable--libedit
> was not added in the Pkgfile. The build failed with an error that the
> readline dependency was needed. I added the first log iwd.error.txt
> After I have done a second try with the option --enable-libedit and
> the dependency readline removed. The log is iwd.error 2.txt

since Debian shows this:

# apt-get install libeditreadline-dev
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  libbsd-dev libedit-dev libmd-dev
The following packages will be REMOVED:
  libreadline-dev
The following NEW packages will be installed:
  libbsd-dev libedit-dev libeditreadline-dev libmd-dev
0 upgraded, 4 newly installed, 1 to remove and 0 not upgraded.
Need to get 419 kB of archives.
After this operation, 766 kB of additional disk space will be used.

I have the feeling that they are being stupid and do some funky tricks
between and libedit and libedit with Readline rl_* exports. You need
to have a look what is on your system.

If you install libeditreadline-dev, then use --disable-libedit and let
it look for Readline. My guess is pkg-config --libs --cflags readline
will then give you the libedit version.

Regards

Marcel

