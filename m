Content-Type: multipart/mixed; boundary="===============6970628193009897593=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH V2] Makefile.am: Avoid redirection of input and output
 files
Date: Fri, 06 Mar 2020 19:33:31 +0100
Message-ID: <6621FDBB-3301-4174-905A-511F4082039B@holtmann.org>
In-Reply-To: <20191106025032.1447949-1-raj.khem@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6970628193009897593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Khem,

> Ensure that directory is created before its written to
> =

> This can cause a build race in a highly parallelised build where a direct=
ory is not yet created but
> output file is being written using redirection e.g.
> =

> rst2man.py --strict --no-raw --no-generator --no-datestamp < ../git/monit=
or/iwmon.rst > monitor/iwmon.1
> /bin/sh: monitor/iwmon.1: No such file or directory
> make[1]: *** [Makefile:3544: monitor/iwmon.1] Error 1
> =

> ---
> v2: create directory before emitting doc files into it
> =

> Makefile.am | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)

sorry for looking at this so late, can you send me a version that applies t=
o the latest HEAD.

Regards

Marcel

--===============6970628193009897593==--

