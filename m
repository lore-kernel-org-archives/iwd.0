Content-Type: multipart/mixed; boundary="===============8456138830335524225=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] test-runner: set msize to remove runtime warning
Date: Wed, 28 Jul 2021 09:33:14 -0500
Message-ID: <8d70da1b-50d1-200b-6045-fc8bb193812b@gmail.com>
In-Reply-To: <20210727221128.33131-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8456138830335524225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 7/27/21 5:11 PM, James Prestwood wrote:
> Newer QEMU version warn that msize is set too low and may result
> in poor IO performance. The default is 8KiB which QEMU claims is
> too low. Explicitly setting to 10KiB removes the warning:
> =

> qemu-system-x86_64: warning: 9p: degraded performance: a
> reasonable high msize should be chosen on client/guest side
> (chosen msize is <=3D 8192).
> See https://wiki.qemu.org/Documentation/9psetup#msize for details.
> ---
>   tools/test-runner | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============8456138830335524225==--

