Content-Type: multipart/mixed; boundary="===============4018174067066349265=="
MIME-Version: 1.0
From: Daniel Wagner <wagi at monom.org>
To: iwd at lists.01.org
Subject: Re: [PATCH v2] iwd: Always disconnect connection completely
Date: Tue, 25 Jan 2022 11:57:34 +0100
Message-ID: <20220125105734.s4cdlt2l5nl2lbls@beryllium.lan>
In-Reply-To: MRZP264MB154440F1153C4C3EEFDE51A3935F9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM

--===============4018174067066349265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 25, 2022 at 10:43:22AM +0000, VAUTRIN Emmanuel (Canal Plus Pres=
tataire) wrote:
> > I haven't made my mind up yet on this one. The problem I see with this
> > is that we start add glue logic which is hard to follow and I am not
> > sure if this is the right place for it. If you have some more info
> > what's happening I would love to hear.
> Indeed, Daniel it is a tricky subject.
> =

> The similar patch has already been applied for wpa_supplicant
> (cf commits referenced in the commit message), after a long discussion
> if I remember well.
> It is still necessary to manage the transitions between 3 known Wifi netw=
orks:
>  - formerly connected,
>  - currently connected,
>  - to be connected.
> In this case, they are 2 disconnections to take into account:
>  - of the currently connected
>  - of the formerly connected,  auto-connecting at the disconnection of
> the currently connected.

Let me add the iwd mailing list here. I'd like to know what we are
supposed to handle on the plugin layer.

For the iwd developers: Currently ConnMan's iwd plugin doesn't track any
networks state. It just forwards the connect/disconnect requests from
the core. Do we need to filter/serialize those?

Daniel
--===============4018174067066349265==--

