Content-Type: multipart/mixed; boundary="===============8779122518961406145=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] src/storage.c: fix build with uclibc
Date: Mon, 28 Mar 2022 12:40:56 -0500
Message-ID: <e463c69b-f668-70c2-1d0e-f0660eee5596@gmail.com>
In-Reply-To: 20220325210017.525876-1-fontaine.fabrice@gmail.com

--===============8779122518961406145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fabrice,

On 3/25/22 16:00, Fabrice Fontaine wrote:
> explicit_bzero is used in src/storage.c since commit
> 01cd8587606bf2da1af245163150589834126c1c but src/missing.h is not
> included, as a result build with uclibc fails on:
> =

> /home/buildroot/autobuild/instance-0/output-1/host/lib/gcc/powerpc-buildr=
oot-linux-uclibc/10.3.0/../../../../powerpc-buildroot-linux-uclibc/bin/ld: =
src/storage.o: in function `storage_init':
> storage.c:(.text+0x13a4): undefined reference to `explicit_bzero'
> =

> Fixes:
>   - http://autobuild.buildroot.org/results/2aff8d3d7c33c95e2c57f7c8a71e69=
939f0580a1
> =

> Signed-off-by: Fabrice Fontaine <fontaine.fabrice(a)gmail.com>

We do not use S-o-b tags, so I took this out.

> ---
>   src/storage.c | 1 +
>   1 file changed, 1 insertion(+)
> =


Applied, thanks.

--===============8779122518961406145==--

