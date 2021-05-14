Content-Type: multipart/mixed; boundary="===============7167210659873744140=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Consider supporting building with clang
Date: Fri, 14 May 2021 09:48:30 -0500
Message-ID: <4a2a4849-64ed-581a-7dc8-36e7531988d9@gmail.com>
In-Reply-To: <20210512114720.2812.33927@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7167210659873744140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 5/12/21 6:47 AM, keruspe+ml01(a)gmail.com wrote:
> Hello,
> =

> Since the introduction of the _auto_ destructor macros, ell and iwd gener=
ate nested functions, which are a gnu extension not supported by clang.
> =

> While adding support for that in clang would also benefit other projects,=
 I don't think this idea is going anywhere as it has been brought up numero=
us times in the past and never went forward.

We're aware of this.  We'll take a look at this in the next few releases.

> =

> The way e.g. glib deals with it is by splitting this in two, first define=
 the destructor function alonside the struct it is going to destruct, then =
hook it up with a macro like _auto_ here, this way no nested functions are =
needed. Would this make sense for ell/iwd too? I can provide patches if req=
uired.

Yes, we considered that.  However, at first glance this seemed less than id=
eal =

since our headers are not set up to make this approach very easy.  Using gc=
c's =

nested function syntax made for a much more compact and less invasive chang=
e. =

Maybe we missed something.  Feel free to take a stab at fixing this, patche=
s are =

always welcome.

Regards,
-Denis
--===============7167210659873744140==--

