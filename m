Content-Type: multipart/mixed; boundary="===============0219731204608326573=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] frame-xchg.c: fix build with glibc < 2.24
Date: Wed, 22 Apr 2020 10:39:22 -0500
Message-ID: <247265db-866c-20d3-9af0-39c048b8fb4b@gmail.com>
In-Reply-To: <20200422081338.4180928-1-fontaine.fabrice@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0219731204608326573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fabrice,

On 4/22/20 3:13 AM, Fabrice Fontaine wrote:
> SOL_NETLINK is used since commit
> 87a198111af1ea67053895f7435fb99e3cdd2159 resulting in the following
> build failure with glibc < 2.24:
> =

> src/frame-xchg.c: In function 'frame_watch_group_io_read':
> src/frame-xchg.c:328:27: error: 'SOL_NETLINK' undeclared (first use in th=
is function)
>     if (cmsg->cmsg_level !=3D SOL_NETLINK)
>                             ^
> =

> This failure is due to glibc that doesn't support SOL_NETLINK before
> version 2.24 and
> https://github.com/bminor/glibc/commit/f9b437d5efce93800b51ad2a437c8b1c96=
16bf80
> =

> Fixes:
>   - http://autobuild.buildroot.org/results/3485088b84111c271bbcfaf025aa41=
03c6452072
> =

> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> ---
>   src/frame-xchg.c | 4 ++++
>   1 file changed, 4 insertions(+)
> =


Applied after stripping the Signed-off-by tag (we do not use these).

Thanks,
-Denis

--===============0219731204608326573==--

