Content-Type: multipart/mixed; boundary="===============6228021308833441832=="
MIME-Version: 1.0
From: hector@ikatu.com
Subject: Re: Interface not detected sometimes
Date: Tue, 04 Feb 2020 20:45:16 +0000
Message-ID: <20200204204516.2820.74539@ml01.vlan13.01.org>
In-Reply-To: <20200204190847.2820.5022@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6228021308833441832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Well the behavior is not the same! Don't know what I did wrong on my first =
test after applying the commit.

Now I'm not setting the "--interfaces wlan0" parameter and I'm not executin=
g the sleep in iwd.service, and it's working almost always (before it was f=
ailling almost always).

This is the log of a failed initialization:

Feb 04 20:37:49 mimx8mm systemd-udevd[308]: /lib/systemd/network/80-iwd.lin=
k:5: Failed to parse interface name policy, ignoring: keep
Feb 04 20:37:50 mimx8mm systemd[1]: Mounting Bind mount for /var/lib/iwd...
Feb 04 20:37:50 mimx8mm systemd[1]: Mounted Bind mount for /var/lib/iwd.
Feb 04 20:37:51 Paris-00100105 iwd[502]: Wireless daemon version 1.4
Feb 04 20:37:51 Paris-00100105 iwd[502]: ../git/src/main.c:main() Using con=
figuration directory /etc/iwd
Feb 04 20:37:51 Paris-00100105 iwd[502]: ../git/src/storage.c:storage_creat=
e_dirs() Using state directory /var/lib/iwd
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/main.c:nl80211_appeared=
() Found nl80211 interface
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/module.c:iwd_modules_in=
it()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/netdev.c:netdev_init() =
Opening route netlink socket
Feb 04 20:37:52 Paris-00100105 iwd[502]: netconfig: Network configuration i=
s disabled.
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wsc.c:wsc_init()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/knownnetworks.c:known_n=
etwork_frequencies_load() No known frequency file found.
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/eap.c:__eap_method_enab=
le()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/eap-wsc.c:eap_wsc_init()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/eap-md5.c:eap_md5_init()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/eap-tls.c:eap_tls_init()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/eap-ttls.c:eap_ttls_ini=
t()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/eap-mschapv2.c:eap_msch=
apv2_init()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/eap-sim.c:eap_sim_init()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/eap-aka.c:eap_aka_prime=
_init()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/eap-aka.c:eap_aka_init()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/eap-peap.c:eap_peap_ini=
t()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/eap-gtc.c:eap_gtc_init()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/eap-pwd.c:eap_pwd_init()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_inter=
face_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_get_i=
nterface_cb()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_inter=
face_dump_callback()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_get_i=
nterface_cb()
Feb 04 20:37:52 Paris-00100105 iwd[502]: Wiphy: 0, Name: phy0
Feb 04 20:37:52 Paris-00100105 iwd[502]:         Permanent Address: 10:98:c=
3:ff:f6:9d
Feb 04 20:37:52 Paris-00100105 iwd[502]:         Bands: 2.4 GHz 5 GHz
Feb 04 20:37:52 Paris-00100105 iwd[502]:         Ciphers: CCMP TKIP BIP
Feb 04 20:37:52 Paris-00100105 iwd[502]:         Supported iftypes: ad-hoc =
station ap p2p-client p2p-go p2p-device
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_confi=
g_notify() Notification of command Del Interface(8)
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 4
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_del_i=
nterface_cb()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/netdev.c:netdev_link_no=
tify() event 17 on ifindex 4
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_del_i=
nterface_cb()
Feb 04 20:37:52 Paris-00100105 iwd[502]: DEL_INTERFACE failed: Unknown erro=
r 524
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/manager.c:manager_use_d=
efault()
Feb 04 20:37:52 Paris-00100105 iwd[502]: ../git/src/netdev.c:netdev_create_=
from_genl() Created interface uap0[4 2]
Feb 04 20:37:52 Paris-00100105 iwd[502]: Could not register frame watch typ=
e 00d0: -19
Feb 04 20:37:52 Paris-00100105 iwd[502]: RTM_GETLINK error -19: No such dev=
ice
Feb 04 20:37:52 Paris-00100105 iwd[502]: Could not register frame watch typ=
e 00d0: -19
Feb 04 20:37:53 Paris-00100105 iwd[502]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 2
Feb 04 20:37:53 Paris-00100105 iwd[502]: ../git/src/agent.c:agent_register(=
) agent register called
Feb 04 20:37:53 Paris-00100105 iwd[502]: ../git/src/agent.c:agent_register(=
) agent :1.4 path /net/connman/iwd_agent
Feb 04 20:37:55 Paris-00100105 iwd[502]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 2
--===============6228021308833441832==--

