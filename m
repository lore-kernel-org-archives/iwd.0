Content-Type: multipart/mixed; boundary="===============2870610977668159138=="
MIME-Version: 1.0
From: zlinuxboy at outlook.com
To: iwd at lists.01.org
Subject: How to run separate iwd for every wifi dongle on the same host?
Date: Thu, 21 Apr 2022 01:40:34 +0000
Message-ID: <20220421014034.2318.714@ml01.vlan13.01.org>

--===============2870610977668159138==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I am trying to plug 3 wifi dongle into one SBC(odroid c2 running armbian 22=
.01), wish to run separate iwd instance for each wifi dongle, in order to c=
onnect different ssid and acquire dhcp ip address and assign to them.

I have successfully implement with systemd-networkd+vrf+iwd, assign three w=
ifi dongle to different vrf. start iwd, all three wifi dongle could connect=
 to the same ssid and get different ip with dhcp, including default route.

but when I assign different wifi dongle to the same ssid  with different ps=
k(my ap is aerohive, support ppsk, everything user have a different private=
 key. cisco, ruckus, aruba has such the same feature), iwd could not save t=
he multiple config for the same ssid, because the same ssid share one confi=
g. so any possible to run separate iwd for every wifi dongle?
--===============2870610977668159138==--

