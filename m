Content-Type: multipart/mixed; boundary="===============5575390077113500998=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] configure.ac: fix static build with readline
Date: Thu, 17 Dec 2020 20:30:57 -0600
Message-ID: <979b198b-e6a1-3f97-2f94-83cf52237130@gmail.com>
In-Reply-To: <20201216070255.142413-1-fontaine.fabrice@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5575390077113500998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fabrice,

On 12/16/20 1:02 AM, Fabrice Fontaine wrote:
> Retrieve the dependencies of readline through pkg-config (and fallback
> to -lreadline) to avoid the following build failure:
> =

> /nvme/rc-buildroot-test/scripts/instance-0/output-1/host/opt/ext-toolchai=
n/bin/../lib/gcc/x86_64-buildroot-linux-uclibc/8.3.0/../../../../x86_64-bui=
ldroot-linux-uclibc/bin/ld: /nvme/rc-buildroot-test/scripts/instance-0/outp=
ut-1/host/bin/../x86_64-buildroot-linux-uclibc/sysroot/usr/lib/libreadline.=
a(display.o): in function `cr':
> display.c:(.text+0x1ab): undefined reference to `tputs'
> =

> Fixes:
>   - http://autobuild.buildroot.org/results/8fb1341f2f5094c346456b43b4fc04=
996c2e1485
> =

> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>

We do not use Signed-off-by, so I dropped this, and...

> ---
>   Makefile.am  | 4 ++--
>   configure.ac | 3 +++
>   2 files changed, 5 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============5575390077113500998==--

