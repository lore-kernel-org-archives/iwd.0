Content-Type: multipart/mixed; boundary="===============2773926747980377115=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [RFC connman 1/1] WIP: Add WPA3-SAE support
Date: Thu, 13 May 2021 12:53:19 +0200
Message-ID: <20210513105319.7sgih2sbhrdn4dgz@beryllium.lan>
In-Reply-To: <3d463ef3-a1ea-3c49-5d4f-79ad58e4bd7f@collabora.co.uk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2773926747980377115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrej,

On Thu, May 13, 2021 at 11:52:32AM +0200, Andrej Shadura wrote:
> On 12/05/2021 19:27, Ariel D'Alessandro wrote:
> > Implement WPA3-SAE authentication on connman side.
> > =

> > Based on Tizen project:
> > =

> >   https://review.tizen.org/git/?p=3Dplatform/upstream/connman.git
> > =

> > Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> =

> Based on my understanding how this should work, this looks reasonable to =
me.

Same here, this looks pretty straightforward. Thanks for picking this
up.

The patch should be spitted into one which adds the SAE to the Security
property of the Service API (please also update the documentation). The
second patch adds the plugins/wifi.c implementation.

I am not really into the WiFi topic anymore, so I am adding the iwd
mailing list. Maybe we get some input for the new SAE Security
property, e.g. how this could work with iwd.

Thanks,
Daniel
--===============2773926747980377115==--

