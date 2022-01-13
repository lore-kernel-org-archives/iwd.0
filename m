Content-Type: multipart/mixed; boundary="===============6254520519947111468=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd 1.21 stuck on connecting state
Date: Thu, 13 Jan 2022 09:22:02 -0800
Message-ID: <2aaa505ef89f9ec1635c30e3a65674fe489f6580.camel@gmail.com>
In-Reply-To: 20220113112714.2807.22007@ml01.vlan13.01.org

--===============6254520519947111468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2022-01-13 at 11:27 +0000,
54d22547-afc0-4701-b1fc-5a2a2e411646(a)simplelogin.co wrote:
> Hi,
> =

> I've recently started noticing on my laptop that iwd gets stuck on
> 'connecting' state when I boot a **second time** right after poweroff.
> The fix is quite easy. Just disconnect and connect again from iwctl.

If its repeatable could you get an IWD log with debugging enabled, as
well as an iwmon trace?

https://iwd.wiki.kernel.org/debugging

> =

> I recall having a similar issue not long ago. Maybe a regression was
> introduced. For the record, router and connection settings are the same
> as before.
> =

> Arch Linux with kernel 5.16-zen1.
> =

> Thanks!
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============6254520519947111468==--

