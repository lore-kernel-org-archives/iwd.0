Content-Type: multipart/mixed; boundary="===============0090577778766724226=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: >=iwd-1.8: crash in dmesg at boot
Date: Tue, 20 Oct 2020 09:28:49 -0700
Message-ID: <d163a616006b4fc97fc7af2048b19d19068ff74e.camel@gmail.com>
In-Reply-To: <20201020161422.GD1676@host>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0090577778766724226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2020-10-20 at 18:14 +0200, m1027(a)posteo.net wrote:
> Hi,
> =

> I am forwarding the following issue from Gentoo linux to you here.
> Please see: https://bugs.gentoo.org/746539
> =

> I hope this is the right place to continue with this issue.
> =

> This is the summary:
> =

> iwd-1.7 was not hit, but 1.8 and 1.9 have been hit by the issue.
> =

> The kernel has been bisected down to this commit:
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=3Db43e=
915b989dcbb0fa763fb7f256e30fe7426f14
> However, it may not be the real cause, maybe only revealing the
> issue. Still happening with linux 5.9.1.

Yes since adding the call to GET_REG it appears that IWD is just
exposing the kernel warning. I think this needs to be forwarded to
linux-wireless.

Side note: wpa_supplicant likely doesn't have this problem since it
does not include ATTR_WIPHY with its GET_REG call AFAIK. Anyone know if
GET_REG is intended to be per-phy? Or why we are including ATTR_WIPHY?

Thanks,
James

--===============0090577778766724226==--

