Content-Type: multipart/mixed; boundary="===============3175669060188347799=="
MIME-Version: 1.0
From: Khem Raj <raj.khem@gmail.com>
Subject: Re: [PATCH V2] Makefile.am: Avoid redirection of input and output
 files
Date: Fri, 06 Mar 2020 09:45:41 -0800
Message-ID: <CAMKF1sp7=ct3RwM7x5eGXuS=QYgTbNQuc_B8kGh3BgJE_xZrpg@mail.gmail.com>
In-Reply-To: <55e71dfb6b1ef153ce3fc79ab101c04a5d0331d8.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3175669060188347799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

gentle ping

On Wed, Nov 13, 2019 at 10:49 AM Khem Raj <raj.khem@gmail.com> wrote:
>
> ping
>
> On Tue, 2019-11-05 at 18:50 -0800, Khem Raj wrote:
> > Ensure that directory is created before its written to
> >
> > This can cause a build race in a highly parallelised build where a
> > directory is not yet created but
> > output file is being written using redirection e.g.
> >
> > rst2man.py --strict --no-raw --no-generator --no-datestamp <
> > ../git/monitor/iwmon.rst > monitor/iwmon.1
> > /bin/sh: monitor/iwmon.1: No such file or directory
> > make[1]: *** [Makefile:3544: monitor/iwmon.1] Error 1
> >
> > ---
> > v2: create directory before emitting doc files into it
> >
> >  Makefile.am | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile.am b/Makefile.am
> > index 823b7d02..1bd0005c 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -626,8 +626,9 @@ SED_PROCESS =3D $(AM_V_GEN)$(MKDIR_P) $(dir $@) &&
> > $(SED) \
> >               < $< > $@
> >
> >  if RUN_RST2MAN
> > -RST2MAN_PROCESS =3D $(AM_V_GEN)$(RST2MAN) --strict --no-raw --no-
> > generator \
> > -                     --no-datestamp < $< > $@
> > +RST2MAN_PROCESS =3D $(AM_V_GEN)$(MKDIR_P) $(dir $@) && \
> > +                     $(AM_V_GEN)$(RST2MAN) --strict --no-raw \
> > +                     --no-generator --no-datestamp $< $@
> >  else
> >  RST2MAN_PROCESS =3D $(AM_V_GEN)test -f $@ || \
> >               { echo "Generated manual page $@ does not exist";
> > false; }
>
--===============3175669060188347799==--

