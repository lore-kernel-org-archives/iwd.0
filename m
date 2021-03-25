Content-Type: multipart/mixed; boundary="===============3895307375434296941=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Broadcom reconnect problems
Date: Thu, 25 Mar 2021 15:13:07 -0500
Message-ID: <d06aee72-dc9c-bb99-aaaf-88eeb6b909d2@gmail.com>
In-Reply-To: <CAG17S_MtQZB+v-BO0Fr2joXYLZD9cYphePa0OAaLrVNjPY_GtA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3895307375434296941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On 3/24/21 6:16 PM, KeithG wrote:
> I have been having problems getting my broadcom based cards to
> reconnect when the disconnect is caused from the router side. It used
> to be a problem with NetworkManager as well as connman, but something
> recently happened with NM and now it reconnects in this scenario. When
> I have connman managing and a broadcom card, any disconnect from the
> router side will not reconnect.

NM uses iwd's autoconnect now, so the behavior should be the same between =

iwd-standalone and NM+iwd.  I haven't really kept up with ConnMan...

> =

> I have 3 machines that I contrast. 1 x86 laptop with an intel card, 1
> laptop with a brcmsmac card and 1 (a bunch) of raspberry pis with
> brcmfmac cards. All will connect at boot time correctly. and the
> laptops reconnect at resume correctly as well.
> =

> On the 2 laptops when NetworkManager is controlling things (Intel and
> brsmac with the iwd backend) and I disconnect it from the router end,
> they reconnect fine. When connman is controlling it, only the laptop
> with the intel card will reconnect. When I run the test on the laptop
> with the connman managing the brcmsmac card, all it does is this:

brcmsmac and brcmfmac are really quite different drivers.  We probably woul=
d =

need a full iwmon trace + iwd debug log from both platforms...

> =

> $ ./monitor-iwd
> {Station} [/net/connman/iwd/0/7] State =3D disconnected
> {Network} [/net/connman/iwd/0/7/73706733_psk] Connected =3D False
> {Station} [/net/connman/iwd/0/7] Scanning =3D True

What is a bit concerning is that Scanning goes to True but is never reset u=
ntil =

after the disconnect.  This seems like a minor bug on our side...

> {Station} [/net/connman/iwd/0/7] State =3D connecting
> {Station} [/net/connman/iwd/0/7] ConnectedNetwork =3D
> /net/connman/iwd/0/7/73706733_psk

So from the iwd-monitor log it looks like you connect to '73706733_psk'

> {Network} [/net/connman/iwd/0/7/73706733_psk] Connected =3D True
> {Station} [/net/connman/iwd/0/7] State =3D disconnected

We get disconnected and presumably scan at least once and don't find any =

existing networks...

> {Network} [/net/connman/iwd/0/7/73706733_psk] Connected =3D False
> {Removed net.connman.iwd.Network}
> [/net/connman/iwd/0/7/53756c6c6976616e2046616d696c79_psk]
> {Removed net.connman.iwd.Network}
> [/net/connman/iwd/0/7/415454385a7334464b33_psk]
> {Removed net.connman.iwd.Network} [/net/connman/iwd/0/7/73706732_psk]
> {Removed net.connman.iwd.Network} [/net/connman/iwd/0/7/4e455447454152363=
3_psk]
> {Removed net.connman.iwd.Network}
> [/net/connman/iwd/0/7/436f6e6e656374696e672e2e2e_psk]
> {Removed net.connman.iwd.Network}
> [/net/connman/iwd/0/7/4d4f544f524f4c412d4645304431_psk]
> {Removed net.connman.iwd.Network}
> [/net/connman/iwd/0/7/41545470666b766e4378_psk]
> {Added net.connman.iwd.Network} [/net/connman/iwd/0/7/4e4554474541523332_=
psk]
>        Name =3D NETGEAR32
>        Connected =3D False
>        Device =3D /net/connman/iwd/0/7
>        Type =3D psk
> {Station} [/net/connman/iwd/0/7] Scanning =3D False
> =


Hmm, it shouldn't stop completely.  In theory it should scan after 10 secon=
ds or =

so.  Can you try setting [Scan].MaximumPeriodicScanInterval to 15 in =

/etc/iwd/main.conf?

> Then it stops and nothing more happens. The output from monitor-iwd
> looks very similar on the RPis running the brcmfmac card. It
> disconnects but then never seems to re-scan and reconnect.
> =


Ok, we definitely need to see the logs to see what's happening.

https://iwd.wiki.kernel.org/debugging

Regards,
-Denis
--===============3895307375434296941==--

