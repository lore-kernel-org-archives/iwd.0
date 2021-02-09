Content-Type: multipart/mixed; boundary="===============0918025179627814137=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: Reconnect issues, still
Date: Wed, 10 Feb 2021 00:33:00 +0100
Message-ID: <CAOq732Kh64TRDOuFjAvkN1YGgfKiW-DtsQOM=h3ndaPgKos8aA@mail.gmail.com>
In-Reply-To: <CAG17S_OkvN8dYd=NOdg_u8Gowv5bsp7=Hbjq8GAVYVUYSW0m6w@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0918025179627814137==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On Wed, 10 Feb 2021 at 00:11, KeithG <ys3al35l@gmail.com> wrote:
> I see a similar result, though the mechanism may be different, on an x86 =
laptop also running Arch Linux. I use iwd with NetworkManager on this compu=
ter and if I do the same thing (restart radio on router), it also does not =
reconnect. NM is 1.28.1dev+7+g3f5df3cdc6 and iwd is v1.11. If it is force d=
isconnected from the router it never tries to reconnect. If I select it fro=
m the drop down, it reconnects.
>
> I noticed that NM did not set 'AutoConnect=3Dtrue' in the /var/lib/iwd/sp=
g3.psk file, so I added it and verified that iwctl reports that this featur=
e is set (It did not before), but even after this was added, it does not re=
connect when it is forced off the network by rebooting, disconnecting or cy=
cling the radio.
>
> The iwd-monitor log shows lots of this:
> {Station} [/net/connman/iwd/0/4] Scanning =3D False
> {Station} [/net/connman/iwd/0/4] Scanning =3D True
> {Station} [/net/connman/iwd/0/4] Scanning =3D False
> {Station} [/net/connman/iwd/0/4] Scanning =3D True
> {Removed net.connman.iwd.Network} [/net/connman/iwd/0/4/426964656e4861727=
26973_psk]
> {Added net.connman.iwd.Network} [/net/connman/iwd/0/4/4e4554474541523336_=
psk]
>       Name =3D NETGEAR36
>       Connected =3D False
>       Device =3D /net/connman/iwd/0/4
>       Type =3D psk
> {Station} [/net/connman/iwd/0/4] Scanning =3D False
> {Station} [/net/connman/iwd/0/4] Scanning =3D True
> {Added net.connman.iwd.Network} [/net/connman/iwd/0/4/415454687a436654786=
9_psk]
>       Name =3D ATThzCfTxi
>       Connected =3D False
>       Device =3D /net/connman/iwd/0/4
>       Type =3D psk
> {Added net.connman.iwd.Network} [/net/connman/iwd/0/4/5261676e6172_psk]
>       Name =3D Ragnar
>       Connected =3D False
>       Device =3D /net/connman/iwd/0/4
>       Type =3D psk
> {Removed net.connman.iwd.Network} [/net/connman/iwd/0/4/4d65617374657761_=
psk]
> {Removed net.connman.iwd.Network} [/net/connman/iwd/0/4/41545470666b766e4=
378_psk]
> {Added net.connman.iwd.Network} [/net/connman/iwd/0/4/4e4554474541523539_=
psk]
>       Name =3D NETGEAR59
>       Connected =3D False
>       Device =3D /net/connman/iwd/0/4
>       Type =3D psk
> {Station} [/net/connman/iwd/0/4] Scanning =3D False
> ...
>
> Interestingly, none of the logs I made actually showed that iwd had scann=
ed and found the network that it was just previously connected to in the li=
st of Network Names. While scanning, it sees the 2.5 network on the same ro=
uter, but not the 5Ghz that it knows the password to. If I do a 'iwctl wlan=
0 get-networks', the 5Ghz radio is at the top of the list but it does not c=
onnect to it. As soon as I select it in the drop down in NM it connects.
>
> My questions: With NM, is it supposed to have an 'AutoConnect=3Dtrue' in =
the psk file? If so, it does not appear that NM creates that in the psk fil=
e. Why does the scan not pick up the previously connected SSID?

A few data points:

* With NM 1.28 NM's own autoconnect mechanism is used, it doesn't
depend on IWD.  Starting with 1.30 IWD will control autoconnect by
default (can be turned off).  NM profies have their own "autoconnect"
property which also defaults to true.

* AutoConnect defaults to true so adding an AutoConnect=3Dtrue to the
.psk file shouldn't have any effect.

* So far only IWD writes the .psk files, it does this the first time
NM commands IWD to connect to a specific network.

* I've seen different quirks with NM autoconnect that I don't fully
understand, but generally it works.  It seemed that network profiles
created by some previous NM versions on my distro had the owner,
permissions and/or local hardware MAC set in a way that prevented them
from ever autoactivating but they could be activated manually.

Best regards
--===============0918025179627814137==--

