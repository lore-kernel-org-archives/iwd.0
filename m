Content-Type: multipart/mixed; boundary="===============6518221019046917468=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd configure location and files
Date: Tue, 30 Nov 2021 12:52:17 -0800
Message-ID: <b786e77e9828625bb92a63d88630e5904234b920.camel@gmail.com>
In-Reply-To: CAA=hcWSGuuPcXbt6M=SOBmC+wYmPxMseG8veBgK9PUP8Or-bpA@mail.gmail.com

--===============6518221019046917468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi jh,

> I could see the WiFi network, but could not scan, nor could connect to
> the network:
> =

> [iwd]#=C2=A0 station mlan0 scan
> =

> [iwd]# station wlan0 get-networks
> =

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Available networks
> -----------------------------------------------------------------------
> ---------
> =C2=A0=C2=A0=C2=A0 Network name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Se=
curity=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Signal
> -----------------------------------------------------------------------
> ---------
> =C2=A0=C2=A0=C2=A0 JupiterIoT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 psk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ****

So scanning is working here...

> =

> # station wlan0 connect JupiterIoT
> Type the network passphrase for JupiterIoT psk.
> Passphrase: superpassphrase
> Operation aborted

...but not connecting. For PSK networks you should not need to put
anything in /var/lib/iwd. iwctl will ask for a passphrase as you saw
and if successful a new file (JupiterIoT.psk in your case) will be
created.

Without any debug logs this gonna be difficult to see whats going on.
If you could enable debug logging when starting IWD and capture some
logs that would give us a better idea of whats going on.

https://iwd.wiki.kernel.org/debugging

> =

> # iwctl station wlan0 show
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Station: wlan0
> -----------------------------------------------------------------------
> ---------
> =C2=A0 Settable=C2=A0 Property=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Value
> -----------------------------------------------------------------------
> ---------
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Scanni=
ng=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 State=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 disconnected
> =

> =

> I believe it is not configured properly. According to the the document
> https://iwd.wiki.kernel.org/networkconfigurationsettings, the network
> configure files are stored in /var/lib/iwd by default, but I can only
> see an empty folder /var/lib/iwd/hotspot, there are several files in
> /lib/systed/network:
> =

> # ls /lib/systemd/network
> =

> 80-container-host0.network=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 80-wifi-ap=
.network.example
> 80-container-ve.network=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 80-wifi-station.network
> 80-container-vz.network=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 80-wifi-station.network.example
> 80-iwd.link=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 80-wired=
.network
> 80-vm-vt.network=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 99-default.link
> 80-wifi-adhoc.network
> =

> Did you mean I need to copy network files from /lib/systemd/network to
> /var/lib/iwd? For example, to run iwd for a home WiFi network, should
> I copy the 80-wifi-station.network to /var/lib/iwd?

No, /var/lib/iwd contains IWD-specific provisioning files for networks
and a few other uses. Don't copy these systemd networks there.

Thanks,
James



--===============6518221019046917468==--

