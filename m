Content-Type: multipart/mixed; boundary="===============4820593528299669693=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] client: make grey really grey
Date: Mon, 14 Mar 2022 14:40:21 -0700
Message-ID: <b36ff816d2a4daf4ec1398bf8b676e22bc564834.camel@gmail.com>
In-Reply-To: 20220314204944.246498-1-vladimir@tango-dj.cz

--===============4820593528299669693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2022-03-14 at 21:49 +0100, Vladim=C3=ADr Dudr wrote:
> Hello, =

> I dared to fix displaying of grey color for iwctl. I tested in Kitty,
> Xterm, Termite, foot and Alarcitty.
> =

> \e[1;30m is bold black, often, but not always displayed bright black
> or
> bold bright black. In case it is displayed as real black it is
> invisible. \e[1;90m is explicit bold bright black.
> =

> \e[37m is white, therefore it is not suitable to be
> labeled as GREY, which is \e[90m. Anyway, this define is used only in
> header, so matching the color to BOLDGRAY seems intuitive. =


This definitely makes the table headers show up which I kinda forgot
existed since they were nearly black. Thanks.

My only suggestion would be to change the commit description a bit to
look more like a git commit, something like:

"Fixed displaying of grey color for iwctl...."

The rest seems fine to me.

Thanks,
James

> =

> Cheers, =

> Vladim=C3=ADr
> ---
> =C2=A0client/display.h | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/client/display.h b/client/display.h
> index b5df944a..7747c6a0 100644
> --- a/client/display.h
> +++ b/client/display.h
> @@ -23,8 +23,8 @@
> =C2=A0struct command;
> =C2=A0struct command_family;
> =C2=A0
> -#define COLOR_BOLDGRAY=C2=A0"\x1B[1;30m"
> -#define COLOR_GRAY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"\x1b[37m"
> +#define COLOR_BOLDGRAY=C2=A0"\x1B[1;90m"
> +#define COLOR_GRAY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"\x1b[90m"
> =C2=A0#define COLOR_GREEN=C2=A0=C2=A0=C2=A0=C2=A0"\x1b[32m"
> =C2=A0#define COLOR_RED=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"\x1B[0;91m"
> =C2=A0#define COLOR_BLUE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"\x1B[94m"
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============4820593528299669693==--

