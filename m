Content-Type: multipart/mixed; boundary="===============4565722063690593219=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: How to run separate iwd for every wifi dongle on the same host?
Date: Wed, 20 Apr 2022 20:57:56 -0500
Message-ID: <9bc2b923-ff45-52a3-270f-5ca8fa18daf6@gmail.com>
In-Reply-To: 20220421014034.2318.714@ml01.vlan13.01.org

--===============4565722063690593219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 4/20/22 20:40, zlinuxboy(a)outlook.com wrote:
> I am trying to plug 3 wifi dongle into one SBC(odroid c2 running armbian =
22.01), wish to run separate iwd instance for each wifi dongle, in order to=
 connect different ssid and acquire dhcp ip address and assign to them.
> =

> I have successfully implement with systemd-networkd+vrf+iwd, assign three=
 wifi dongle to different vrf. start iwd, all three wifi dongle could conne=
ct to the same ssid and get different ip with dhcp, including default route.

vrf?

> =

> but when I assign different wifi dongle to the same ssid  with different =
psk(my ap is aerohive, support ppsk, everything user have a different priva=
te key. cisco, ruckus, aruba has such the same feature), iwd could not save=
 the multiple config for the same ssid, because the same ssid share one con=
fig. so any possible to run separate iwd for every wifi dongle?

I don't think you'd be able to accomplish this easily with iwd as of today.=
  You =

can try running a private system bus (dbus) for each iwd instance and using=
 phy =

filtering (see 'iwd --help') so that each iwd instance only manages the =

particular phy you want.  Or use namespaces.  But you'd need to access each=
 iwd =

instance via its private bus/namespace separately.  You'd also need to over=
ride =

the state directory for each iwd instance.

Also, iwd isn't aware of SAE password identities (I assume this is what you=
 mean =

by PPSK).  Or is this something else?

Anyhow, you'd probably need to add some intelligence into iwd for it to use =

multiple PSKs on the same SSID properly within the same iwd instance.

Regards,
-Denis
--===============4565722063690593219==--

