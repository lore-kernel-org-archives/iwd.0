Content-Type: multipart/mixed; boundary="===============0437784583133030973=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Makefile.am: Avoid redirection of input and output files
Date: Tue, 05 Nov 2019 07:11:03 +0100
Message-ID: <F316B322-020B-4D7A-BF10-8EF7B5CB7CE2@holtmann.org>
In-Reply-To: <20191105010705.2711040-1-raj.khem@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0437784583133030973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Khem,

> This can cause a build race in a highly parallelised build where a direct=
ory is not yet created but
> output file is being written using redirection e.g.
> =

> rst2man.py --strict --no-raw --no-generator --no-datestamp < ../git/monit=
or/iwmon.rst > monitor/iwmon.1
> /bin/sh: monitor/iwmon.1: No such file or directory
> make[1]: *** [Makefile:3544: monitor/iwmon.1] Error 1
> ---
> Makefile.am | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/Makefile.am b/Makefile.am
> index 823b7d02..21dd707c 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -627,7 +627,7 @@ SED_PROCESS =3D $(AM_V_GEN)$(MKDIR_P) $(dir $@) && $(=
SED) \
> =

> if RUN_RST2MAN
> RST2MAN_PROCESS =3D $(AM_V_GEN)$(RST2MAN) --strict --no-raw --no-generato=
r \
> -			--no-datestamp < $< > $@
> +			--no-datestamp
> else
> RST2MAN_PROCESS =3D $(AM_V_GEN)test -f $@ || \
> 		{ echo "Generated manual page $@ does not exist"; false; }

so this is bad in case the else clause is used.

> @@ -637,13 +637,13 @@ endif
> 	$(SED_PROCESS)
> =

> %.1: %.rst Makefile
> -	$(RST2MAN_PROCESS)
> +	$(RST2MAN_PROCESS) $< $@
> =

> %.5: %.rst Makefile
> -	$(RST2MAN_PROCESS)
> +	$(RST2MAN_PROCESS) $< $@
> =

> %.8: %.rst Makefile
> -	$(RST2MAN_PROCESS)
> +	$(RST2MAN_PROCESS) $< $@

Is adding this to the RST2MAN_PROCESS variable not working?

Regards

Marcel

--===============0437784583133030973==--

