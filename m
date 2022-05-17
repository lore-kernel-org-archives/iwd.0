Content-Type: multipart/mixed; boundary="===============5588217560917968535=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 1/2] netconfig: Add multiple levels to IWD_DHCP_DEBUG
Date: Tue, 17 May 2022 20:17:28 +0100
Message-ID: <CACsRnHUpN+fXLekfFKzX4LmJKE_H5thYW9LK-5eXzXtw5Fy0VA@mail.gmail.com>
In-Reply-To: 04786874-f47b-aaa8-f3f3-1492fd268b01@gmail.com

--===============5588217560917968535==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, 17 May 2022 at 19:09, Denis Kenzior <denkenz(a)gmail.com> wrote:
...
>
> Actually, that's not our coding style.  We use Linux Kernel style, so it =
would be:

Sorry about that, I'll fix it up. I saw the functions and assumed
without checking other `if`'s.

> This changes the semantics slightly.  In our wiki, etc we show IWD_DHCP_D=
EBUG
> with value "1" to enable debugging, so I think we should be nice and keep=
 that
> behavior if possible.  How about:
>
> if IWD_DHCP_DEBUG is not set, use L_LOG_WARNING.
>
> If IWD_DHCP_DEBUG is set and has a non-NULL value, use L_LOG_DEBUG
>
> If the value above is from the set L_LOG_ERR .. L_LOG_DEBUG (3 .. 7), the=
n use that.

I made this change but it seems quite difficult to explain in a
reasonable way to the user why the values are 3, 4, 6, and 7.
How about using strings instead? `info`, `warn`, `error`, `debug`?
That still allows us to keep the old behavior if it's a `1`.

I'm also questioning if I should keep the L_LOG_WARN as the default or
make it L_LOG_INFO which is more in line with what I intended when I
started (i.e. not setting the env should result in similar output to
other DHCP clients). Do you prefer WARN?

Regards,
Michael
--===============5588217560917968535==--

