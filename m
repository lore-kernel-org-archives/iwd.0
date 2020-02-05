Content-Type: multipart/mixed; boundary="===============1885981850657367721=="
MIME-Version: 1.0
From: hector@ikatu.com
Subject: Re: Interface not detected sometimes
Date: Wed, 05 Feb 2020 19:28:36 +0000
Message-ID: <20200205192836.2820.73709@ml01.vlan13.01.org>
In-Reply-To: <5bf91f75-9c0a-6d87-761a-774c87f5f69d@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1885981850657367721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis,

I tried your patch and it seems like the problem is solved. I tested that t=
he initialization works even when I get the "No default interface for wiphy=
 0", so the retry you added after that fixed it:

Feb 05 19:14:19 mimx8mm systemd-udevd[303]: /lib/systemd/network/80-iwd.lin=
k:5: Failed to parse interface name policy, ignoring: keep
Feb 05 19:14:21 mimx8mm systemd[1]: Mounting Bind mount for /var/lib/iwd...
Feb 05 19:14:21 mimx8mm systemd[1]: Mounted Bind mount for /var/lib/iwd.
Feb 05 19:14:22 Paris-00100105 iwd[437]: Wireless daemon version 1.4
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/main.c:main() Using con=
figuration directory /etc/iwd
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/storage.c:storage_creat=
e_dirs() Using state directory /var/lib/iwd
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/main.c:nl80211_appeared=
() Found nl80211 interface
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/module.c:iwd_modules_in=
it()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_init() =
Opening route netlink socket
Feb 05 19:14:22 Paris-00100105 iwd[437]: netconfig: Network configuration i=
s disabled.
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wsc.c:wsc_init()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/knownnetworks.c:known_n=
etwork_frequencies_load() No known frequency file found.
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/eap.c:__eap_method_enab=
le()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/eap-wsc.c:eap_wsc_init()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/eap-md5.c:eap_md5_init()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/eap-tls.c:eap_tls_init()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/eap-ttls.c:eap_ttls_ini=
t()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/eap-mschapv2.c:eap_msch=
apv2_init()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/eap-sim.c:eap_sim_init()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/eap-aka.c:eap_aka_prime=
_init()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/eap-aka.c:eap_aka_init()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/eap-peap.c:eap_peap_ini=
t()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/eap-gtc.c:eap_gtc_init()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/eap-pwd.c:eap_pwd_init()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_confi=
g_notify() Notification of command New Wiphy(3)
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: Wiphy phy0 will only use the defau=
lt interface
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:22 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 19:14:23 Paris-00100105 iwd[437]: Wiphy: 0, Name: phy0
Feb 05 19:14:23 Paris-00100105 iwd[437]:         Permanent Address: 10:98:c=
3:ff:f6:9d
Feb 05 19:14:23 Paris-00100105 iwd[437]:         Bands: 2.4 GHz 5 GHz
Feb 05 19:14:23 Paris-00100105 iwd[437]:         Ciphers: CCMP TKIP BIP
Feb 05 19:14:23 Paris-00100105 iwd[437]:         Supported iftypes: ad-hoc =
station ap p2p-client p2p-go p2p-device
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_use_d=
efault()
Feb 05 19:14:23 Paris-00100105 iwd[437]: No default interface for wiphy 0
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_confi=
g_notify() Notification of command New Interface(7)
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_confi=
g_notify() Retrying setup of wiphy 0
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_get_i=
nterface_cb()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_use_d=
efault()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_create_=
from_genl() Created interface wlan0[3 1]
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_cqm_rss=
i_update()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 3
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 3
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_set_4ad=
dr() netdev: 3 use_4addr: 0
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_initial=
_up_cb() Interface 3 initialized
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/station.c:station_enter=
_state() Old State: disconnected, new state: autoconnect_quick
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/station.c:station_enter=
_state() Old State: disconnected, new state: autoconnect_full
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/scan.c:scan_periodic_st=
art() Starting periodic scan for wdev 1
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 3
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 3
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/scan.c:scan_notify() Sc=
an notification Trigger Scan(33)
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/scan.c:scan_request_tri=
ggered()
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/scan.c:scan_request_tri=
ggered() Passive scan triggered for wdev 1
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/scan.c:scan_periodic_tr=
iggered() Periodic scan triggered for wdev 1
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 3
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/manager.c:manager_confi=
g_notify() Notification of command New Interface(7)
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 4
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 4
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 4
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 3
Feb 05 19:14:23 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 4
Feb 05 19:14:24 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 4
Feb 05 19:14:25 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 3
Feb 05 19:14:25 Paris-00100105 iwd[437]: ../git/src/station.c:station_free()
Feb 05 19:14:25 Paris-00100105 iwd[437]: ../git/src/scan.c:scan_periodic_st=
op() Stopping periodic scan for wdev 1
Feb 05 19:14:25 Paris-00100105 iwd[437]: ../git/src/scan.c:scan_cancel() Tr=
ying to cancel scan id 1 for wdev 1
Feb 05 19:14:25 Paris-00100105 iwd[437]: ../git/src/scan.c:scan_cancel() Sc=
an is at the top of the queue and triggered
Feb 05 19:14:25 Paris-00100105 iwd[437]: ../git/src/scan.c:scan_notify() Sc=
an notification Scan Aborted(35)
Feb 05 19:14:25 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 2
Feb 05 19:14:25 Paris-00100105 iwd[437]: ../git/src/agent.c:agent_register(=
) agent register called
Feb 05 19:14:25 Paris-00100105 iwd[437]: ../git/src/agent.c:agent_register(=
) agent :1.6 path /net/connman/iwd_agent
Feb 05 19:14:27 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 2
Feb 05 19:14:37 Paris-00100105 iwd[437]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 3
Feb 05 19:14:37 Paris-00100105 iwd[437]: ../git/src/station.c:station_enter=
_state() Old State: disconnected, new state: autoconnect_quick
Feb 05 19:14:37 Paris-00100105 iwd[437]: ../git/src/station.c:station_enter=
_state() Old State: disconnected, new state: autoconnect_full
Feb 05 19:14:37 Paris-00100105 iwd[437]: ../git/src/scan.c:scan_periodic_st=
art() Starting periodic scan for wdev 1
Feb 05 19:14:37 Paris-00100105 iwd[437]: ../git/src/scan.c:scan_notify() Sc=
an notification Trigger Scan(33)
Feb 05 19:14:37 Paris-00100105 iwd[437]: ../git/src/scan.c:scan_request_tri=
ggered()
Feb 05 19:14:37 Paris-00100105 iwd[437]: ../git/src/scan.c:scan_request_tri=
ggered() Passive scan triggered for wdev 1
Feb 05 19:14:37 Paris-00100105 iwd[437]: ../git/src/scan.c:scan_periodic_tr=
iggered() Periodic scan triggered for wdev 1
Feb 05 19:14:39 Paris-00100105 iwd[437]: ../git/src/scan.c:scan_notify() Sc=
an notification New Scan Results(34)
[...]

Thank you so much!

Regards,
Hector
--===============1885981850657367721==--

