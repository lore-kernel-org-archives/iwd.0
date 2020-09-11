Content-Type: multipart/mixed; boundary="===============2560337414771302815=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] src/ap.c: fix build with uclibc
Date: Fri, 11 Sep 2020 13:43:40 -0500
Message-ID: <4999cd2b-6572-6de1-dcd7-f5dc974c404b@gmail.com>
In-Reply-To: <20200910061800.497914-1-fontaine.fabrice@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2560337414771302815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fabrice,

On 9/10/20 1:18 AM, Fabrice Fontaine wrote:
> explicit_bzero is used in src/ap.c since commit
> d55e00b31d7bccdbb2ea1cdeb0a749df77a51e47 but src/missing.h is not
> included, as a result build with uclibc fails on:
> =

> /srv/storage/autobuild/run/instance-1/output-1/host/lib/gcc/xtensa-buildr=
oot-linux-uclibc/9.3.0/../../../../xtensa-buildroot-linux-uclibc/bin/ld: sr=
c/ap.o: in function `ap_probe_req_cb':
> ap.c:(.text+0x23d8): undefined reference to `explicit_bzero'
> =

> Fixes:
>   - http://autobuild.buildroot.org/results/c7a0096a269bfc52bd8e23d453d36d=
5bfb61441d
> =

> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> ---
>   src/ap.c | 1 +
>   1 file changed, 1 insertion(+)
> =


Applied, thanks.

Regards,
-Denis

--===============2560337414771302815==--

