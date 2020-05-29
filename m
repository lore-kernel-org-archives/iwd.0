Content-Type: multipart/mixed; boundary="===============7157539567210738397=="
MIME-Version: 1.0
From: Erik =?unknown-8bit?q?Bot=C3=B6?= <erik.boto@gmail.com>
Subject: Scanning while in AP mode
Date: Fri, 29 May 2020 15:16:43 +0200
Message-ID: <CALNvYWNpDsZGakA97Qxo_SLG23ecrHuhD4Gmj2jfyBW=2XAscg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7157539567210738397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I want to scan for networks while having an active AP. From what I
understand this can be achieved by using NL80211_SCAN_FLAG_AP.

The documentation for it say:
 * @NL80211_SCAN_FLAG_AP: force a scan even if the interface is configured
 * as AP and the beaconing has already been configured. This attribute is
 * dangerous because will destroy stations performance as a lot of frames
 * will be lost while scanning off-channel, therefore it must be used only
 * when really needed

So I suppose it's not something that should be enabled by default, but
it would be useful to be able to start a scan with this if explicitly
requested.

My use case for this is initial device setup. A new device would be
configured to start up in AP-mode and a inital setup service would run
that e.g. a phone could connect to and be presented with a list of
found networks. Then a network can be selected and credentials setup,
then the device will shut down the AP and instead connect as a client
to the selected network. Like many IoT devices etc let's you do when
configuring.

What do you think, is it something that could fit into iwd or is there
some reasons to not support this?

Cheers,
Erik
--===============7157539567210738397==--

