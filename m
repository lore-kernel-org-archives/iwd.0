Content-Type: multipart/mixed; boundary="===============7297332176957300330=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] src/p2p.c: fix build with uclibc
Date: Mon, 22 Jun 2020 10:25:27 -0500
Message-ID: <ce70274a-5413-4c5f-8cc9-fc3cf944e949@gmail.com>
In-Reply-To: <20200620131954.436598-1-fontaine.fabrice@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7297332176957300330==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fabrice,

On 6/20/20 8:19 AM, Fabrice Fontaine wrote:
> explicit_bzero is used in src/p2p.c since commit
> 1675c765a3d66f3c626a1581a7bf514e1859b064 but src/missing.h is not
> included, as a result build with uclibc fails on:
> =

> /home/naourr/work/instance-0/output-1/per-package/iwd/host/opt/ext-toolch=
ain/bin/../lib/gcc/mips64el-buildroot-linux-uclibc/5.5.0/../../../../mips64=
el-buildroot-linux-uclibc/bin/ld: src/p2p.o: in function `p2p_connection_re=
set':
> p2p.c:(.text+0x2cf4): undefined reference to `explicit_bzero'
> /home/naourr/work/instance-0/output-1/per-package/iwd/host/opt/ext-toolch=
ain/bin/../lib/gcc/mips64el-buildroot-linux-uclibc/5.5.0/../../../../mips64=
el-buildroot-linux-uclibc/bin/ld: p2p.c:(.text+0x2cfc): undefined reference=
 to `explicit_bzero'
> =

> Fixes:
>   - http://autobuild.buildroot.org/results/8bbf7e1d0929d0883c0c2445990f62=
f5a1d54163
> =

> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>

No signed-off-by please.  iwd doesn't use these.

> ---
>   src/p2p.c | 1 +
>   1 file changed, 1 insertion(+)
> =


Applied after minor commit description modifications.

Regards,
-Denis
--===============7297332176957300330==--

