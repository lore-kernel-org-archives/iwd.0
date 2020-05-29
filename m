Content-Type: multipart/mixed; boundary="===============5745711753990957035=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Scanning while in AP mode
Date: Fri, 29 May 2020 15:14:35 +0000
Message-ID: <166f7dab-1d55-e726-699f-86b458088ec2@gmail.com>
In-Reply-To: <CALNvYWNpDsZGakA97Qxo_SLG23ecrHuhD4Gmj2jfyBW=2XAscg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5745711753990957035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Erik,

On 5/29/20 8:16 AM, Erik Bot=C3=B6 wrote:
> Hi,
> =

> I want to scan for networks while having an active AP. From what I
> understand this can be achieved by using NL80211_SCAN_FLAG_AP.
> =

> The documentation for it say:
>   * @NL80211_SCAN_FLAG_AP: force a scan even if the interface is configur=
ed
>   * as AP and the beaconing has already been configured. This attribute is
>   * dangerous because will destroy stations performance as a lot of frames
>   * will be lost while scanning off-channel, therefore it must be used on=
ly
>   * when really needed
> =

> So I suppose it's not something that should be enabled by default, but
> it would be useful to be able to start a scan with this if explicitly
> requested.
> =

> My use case for this is initial device setup. A new device would be
> configured to start up in AP-mode and a inital setup service would run
> that e.g. a phone could connect to and be presented with a list of
> found networks. Then a network can be selected and credentials setup,
> then the device will shut down the AP and instead connect as a client
> to the selected network. Like many IoT devices etc let's you do when
> configuring.

So let me see if I understood correctly.  You want to have wlan0:

1. Switch to Device.Mode =3D ap
2. Wait until 'something' connects to wlan0
3. Run a scan on wlan0 and tell that 'something' what networks are seen
4. 'something' configures one of the seen networks
5. wlan0 Device.Mode is then switched to 'station' and it connects to =

the network configured in 4.

And to enable this you want to add scanning functionality to the =

AccessPoint interface and have scan.c support this SCAN_FLAG_AP flag. =

If above is correct, then...

> =

> What do you think, is it something that could fit into iwd or is there
> some reasons to not support this?

I don't see any reason not to.  Feel free to come up with an initial =

proposal and we can go from there.

Regards,
-Denis
--===============5745711753990957035==--

