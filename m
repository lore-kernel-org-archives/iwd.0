Content-Type: multipart/mixed; boundary="===============2516009460593499065=="
MIME-Version: 1.0
From: Khem Raj <raj.khem@gmail.com>
Subject: Re: [PATCH V2] Makefile.am: Avoid redirection of input and output
 files
Date: Fri, 06 Mar 2020 11:23:21 -0800
Message-ID: <CAMKF1soFtieJnengkCvx1R5NrhgLrQ+9Z8gzDCgBRkwg-XFLug@mail.gmail.com>
In-Reply-To: <6621FDBB-3301-4174-905A-511F4082039B@holtmann.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2516009460593499065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel

Sent a v3

On Fri, Mar 6, 2020 at 10:33 AM Marcel Holtmann <marcel@holtmann.org> wro=
te:
>
> Hi Khem,
>
> > Ensure that directory is created before its written to
> >
> > This can cause a build race in a highly parallelised build where a dire=
ctory is not yet created but
> > output file is being written using redirection e.g.
> >
> > rst2man.py --strict --no-raw --no-generator --no-datestamp < ../git/mon=
itor/iwmon.rst > monitor/iwmon.1
> > /bin/sh: monitor/iwmon.1: No such file or directory
> > make[1]: *** [Makefile:3544: monitor/iwmon.1] Error 1
> >
> > ---
> > v2: create directory before emitting doc files into it
> >
> > Makefile.am | 5 +++--
> > 1 file changed, 3 insertions(+), 2 deletions(-)
>
> sorry for looking at this so late, can you send me a version that applies=
 to the latest HEAD.
>
> Regards
>
> Marcel
>
--===============2516009460593499065==--

