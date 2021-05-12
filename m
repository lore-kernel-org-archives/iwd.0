Content-Type: multipart/mixed; boundary="===============0796036591685550280=="
MIME-Version: 1.0
From: Rosen Penev <rosenp@gmail.com>
Subject: Re: Consider supporting building with clang
Date: Wed, 12 May 2021 14:44:01 -0700
Message-ID: <CAKxU2N9n=y=KqpUcySQeraiwwyqpKTVeKmnHgnRn7EFQrsdkow@mail.gmail.com>
In-Reply-To: <20210512114720.2812.33927@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0796036591685550280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 12, 2021 at 4:47 AM <keruspe+ml01@gmail.com> wrote:
>
> Hello,
>
> Since the introduction of the _auto_ destructor macros, ell and iwd gener=
ate nested functions, which are a gnu extension not supported by clang.
>
> While adding support for that in clang would also benefit other projects,=
 I don't think this idea is going anywhere as it has been brought up numero=
us times in the past and never went forward.
>
> The way e.g. glib deals with it is by splitting this in two, first define=
 the destructor function alonside the struct it is going to destruct, then =
hook it up with a macro like _auto_ here, this way no nested functions are =
needed. Would this make sense for ell/iwd too? I can provide patches if req=
uired.
C23 will get support for lambdas I believe.

http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2638.pdf
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org
--===============0796036591685550280==--

