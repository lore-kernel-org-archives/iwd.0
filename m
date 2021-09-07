Content-Type: multipart/mixed; boundary="===============6299547283925055233=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 8/9] sae: don't send commit in confirmed state
Date: Tue, 07 Sep 2021 16:34:52 -0700
Message-ID: <abf40bb3b4b2d309b5a19343388c308b54a4a3bb.camel@gmail.com>
In-Reply-To: <3b994fe5-8b84-6f4d-e2d8-5e63fd05cd41@molgen.mpg.de>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6299547283925055233==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Wed, 2021-09-08 at 01:02 +0200, Paul Menzel wrote:
> Dear James,
> =

> =

> Am 07.09.21 um 23:14 schrieb James Prestwood:
> > This works around a hostapd bug (described more in the TODO
> > comment)
> =

> It=E2=80=99d be great, if you listed the hostapd version, you reproduced =
this
> with, and, if you did, add a reference to the hostapd bug report.

Sure. I did send an email to the hostapd ML if that is considered a bug
report.

> =

> > that deaths IWD if the initial commit is not acked. This behavior
> > has been identified in consumer access points and likely won't ever
> > be patched for older devices. Because of this IWD must work around
> > the problem which can be eliminated by not sending out this commit
> > message.
> =

> Excuse my ignorance, but how likely is it, that non-hostapd setups
> keep =

> working?

Do non-hostapd setups even exist? :) But in reality no it shouldn't
effect anything. I do need to amend this commit slightly, but v2 will
have identical behavior as wpa_supplicant, i.e. ignore the commit
message completely.

Thanks,
James



--===============6299547283925055233==--

