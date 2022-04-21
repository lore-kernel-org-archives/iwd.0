Content-Type: multipart/mixed; boundary="===============0590850231885876230=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel at holtmann.org>
To: iwd at lists.01.org
Subject: Re: How to run separate iwd for every wifi dongle on the same host?
Date: Thu, 21 Apr 2022 18:00:36 +0200
Message-ID: <65B81935-CD82-40DA-A3C4-DF0697848B53@holtmann.org>
In-Reply-To: 9bc2b923-ff45-52a3-270f-5ca8fa18daf6@gmail.com

--===============0590850231885876230==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> I am trying to plug 3 wifi dongle into one SBC(odroid c2 running armbian=
 22.01), wish to run separate iwd instance for each wifi dongle, in order t=
o connect different ssid and acquire dhcp ip address and assign to them.
>> I have successfully implement with systemd-networkd+vrf+iwd, assign thre=
e wifi dongle to different vrf. start iwd, all three wifi dongle could conn=
ect to the same ssid and get different ip with dhcp, including default rout=
e.
> =

> vrf?
> =

>> but when I assign different wifi dongle to the same ssid  with different=
 psk(my ap is aerohive, support ppsk, everything user have a different priv=
ate key. cisco, ruckus, aruba has such the same feature), iwd could not sav=
e the multiple config for the same ssid, because the same ssid share one co=
nfig. so any possible to run separate iwd for every wifi dongle?
> =

> I don't think you'd be able to accomplish this easily with iwd as of toda=
y.  You can try running a private system bus (dbus) for each iwd instance a=
nd using phy filtering (see 'iwd --help') so that each iwd instance only ma=
nages the particular phy you want.  Or use namespaces.  But you'd need to a=
ccess each iwd instance via its private bus/namespace separately.  You'd al=
so need to override the state directory for each iwd instance.

you can use the environment variables STATE_DIRECTORY and CONFIGURATION_DIR=
ECTORY to point to separate directories for storage and config.

Regards

Marcel

--===============0590850231885876230==--

