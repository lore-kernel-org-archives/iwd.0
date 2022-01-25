Content-Type: multipart/mixed; boundary="===============4550663517711215505=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2] iwd: Always disconnect connection completely
Date: Tue, 25 Jan 2022 10:25:02 -0600
Message-ID: <d0cbe87b-83c4-12c3-f109-782d2bfe366c@gmail.com>
In-Reply-To: 20220125105734.s4cdlt2l5nl2lbls@beryllium.lan

--===============4550663517711215505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

> For the iwd developers: Currently ConnMan's iwd plugin doesn't track any
> networks state. It just forwards the connect/disconnect requests from
> the core. Do we need to filter/serialize those?

So in theory iwd should gracefully handle such scenarios.  For example:
- Connect comes while already connected (network switch)
- Disconnect comes when connecting (aborts the connect attempt)
- Connect while connecting (aborts original attempt, starts new one)

There may be situations where the timing between requests is so small that =
we =

simply have to return an -EBUSY (net.connman.iwd.Busy).

Is there a particular scenario which isn't working?

Regards,
-Denis
--===============4550663517711215505==--

