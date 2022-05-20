Content-Type: multipart/mixed; boundary="===============6119771377328679756=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: Unsupported finite cyclic group
Date: Fri, 20 May 2022 11:09:15 -0500
Message-ID: <8d92aea3-241c-85ed-6742-14a61203edc4@gmail.com>
In-Reply-To: CACsRnHXTXLj4A7M9+05m+rF54NiE=isBzpxYTWxah-UUZXqe7w@mail.gmail.com

--===============6119771377328679756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 5/20/22 09:49, Michael Johnson wrote:
> Hi,
> =

> After updating to master (f12cf1ab9db iwd, 43e99ec5f21 ell) I've
> started seeing a few new errors which are causing the client to
> disconnect and stay disconnected for a brief time. The previous

Hmm, so starting around ell 0.42 we started to prefer using P384 group for =
SAE =

connections over P256.

> version I was running (1.21 iwd and 0.47 ell) didn't have these but

Since you're running 0.47, that should already be the default behavior.

> it's possible this is new functionality that was enabled and the AP
> vendor doesn't support it properly. If there is anything else I can
> gather to help debug what is going wrong please let me know.
> =


Did anything change on the AP?  iwd 1.21 wasn't that long ago, and there ha=
sn't =

been any notable SAE or FT changes since then.

> The first error happens during an FT roam and the AP reports this
> association failure: 802.11 STATUS (CODE 77) - Unsupported finite
> cyclic group. Most FT roams happen fine so I'm not sure why this one
> is different.

That is a weird error to get during FT since cyclic groups shouldn't even b=
e =

involved.  Are you sure it is really trying to FT?    Maybe it is trying a =

simple Reassociate with SAE?  Do you have an iwmon log by any chance?

Regards,
-Denis
--===============6119771377328679756==--

