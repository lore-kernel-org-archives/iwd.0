Content-Type: multipart/mixed; boundary="===============5467367309553773366=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2] src/sae.c: fix build without reallocarray
Date: Mon, 20 Sep 2021 10:34:10 -0500
Message-ID: <7455fa76-7847-babe-ea08-4bcb994bb87c@gmail.com>
In-Reply-To: 20210919191744.3963258-1-fontaine.fabrice@gmail.com

--===============5467367309553773366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fabrice,

On 9/19/21 2:17 PM, Fabrice Fontaine wrote:
> reallocarray has been added to glibc relatively recently (version 2.26,
> from 2017) and apparently not all users run new enough glibc. Moreover,
> reallocarray is not available with uclibc-ng. So use realloc if
> reallocarray is not available to avoid the following build failure
> raised since commit 891b78e9e892a3bcd800eb3a298e6380e9a15dd1:
> =

> /home/giuliobenetti/autobuild/run/instance-3/output-1/host/lib/gcc/xtensa=
-buildroot-linux-uclibc/10.3.0/../../../../xtensa-buildroot-linux-uclibc/bi=
n/ld: src/sae.o: in function `sae_rx_authenticate':
> sae.c:(.text+0xd74): undefined reference to `reallocarray'
> =

> Fixes:
>   - http://autobuild.buildroot.org/results/c6d3f86282c44645b4f1c61882dc63=
ccfc8eb35a
> ---
> Changes v1 -> v2 (after review of Denis Kenzior):
>   - Remove SoB
>   - Add reallocarray to missing.h
> =

>   configure.ac  | 1 +
>   src/missing.h | 7 +++++++
>   2 files changed, 8 insertions(+)
> =


Applied after re-wording the commit header slightly.  Thanks!

Regards,
-Denis

--===============5467367309553773366==--

