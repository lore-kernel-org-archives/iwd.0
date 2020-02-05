Content-Type: multipart/mixed; boundary="===============0347233919900764706=="
MIME-Version: 1.0
From: hector@ikatu.com
Subject: Re: Interface not detected sometimes
Date: Wed, 05 Feb 2020 13:35:15 +0000
Message-ID: <20200205133515.2820.50222@ml01.vlan13.01.org>
In-Reply-To: <2ae955ab-fb4c-e6f5-b06a-5045d1122dcb@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0347233919900764706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here is a log of a failed initialization where I have set "--interfaces wla=
n0", no sleep in iwd.service, and I applied your recent commit (8530396fb31=
79c789430264a01e506a11907f94b manager: Add brcmfmac to the blacklist), (BTW=
 I didn't set any value to the UseDefaultInterface property).

Feb 05 13:24:29 mimx8mm systemd-udevd[303]: /lib/systemd/network/80-iwd.lin=
k:5: Failed to parse interface name policy, ignoring: keep
Feb 05 13:24:31 mimx8mm systemd[1]: Mounting Bind mount for /var/lib/iwd...
Feb 05 13:24:31 mimx8mm systemd[1]: Mounted Bind mount for /var/lib/iwd.
Feb 05 13:24:32 Paris-00100105 iwd[429]: Wireless daemon version 1.4
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/main.c:main() Using con=
figuration directory /etc/iwd
Feb 05 13:24:32 Paris-00100105 iwd[429]: Loaded configuration from /etc/iwd=
/main.conf
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/storage.c:storage_creat=
e_dirs() Using state directory /var/lib/iwd
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/main.c:nl80211_appeared=
() Found nl80211 interface
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/module.c:iwd_modules_in=
it()
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/netdev.c:netdev_init() =
Opening route netlink socket
Feb 05 13:24:32 Paris-00100105 iwd[429]: netconfig: Network configuration i=
s disabled.
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/wsc.c:wsc_init()
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/knownnetworks.c:known_n=
etwork_frequencies_load() No known frequency file found.
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/eap.c:__eap_method_enab=
le()
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/eap-wsc.c:eap_wsc_init()
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/eap-md5.c:eap_md5_init()
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/eap-tls.c:eap_tls_init()
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/eap-ttls.c:eap_ttls_ini=
t()
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/eap-mschapv2.c:eap_msch=
apv2_init()
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/eap-sim.c:eap_sim_init()
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/eap-aka.c:eap_aka_prime=
_init()
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/eap-aka.c:eap_aka_init()
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/eap-peap.c:eap_peap_ini=
t()
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/eap-gtc.c:eap_gtc_init()
Feb 05 13:24:32 Paris-00100105 iwd[429]: ../git/src/eap-pwd.c:eap_pwd_init()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_confi=
g_notify() Notification of command New Wiphy(3)
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: Wiphy phy0 will only use the defau=
lt interface
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_frequencies()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:parse_supported=
_bands()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_wiphy=
_dump_callback()
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/wiphy.c:wiphy_update_fr=
om_genl()
Feb 05 13:24:33 Paris-00100105 iwd[429]: Wiphy: 0, Name: phy0
Feb 05 13:24:33 Paris-00100105 iwd[429]:         Permanent Address: 10:98:c=
3:ff:f6:9d
Feb 05 13:24:33 Paris-00100105 iwd[429]:         Bands: 2.4 GHz 5 GHz
Feb 05 13:24:33 Paris-00100105 iwd[429]:         Ciphers: CCMP TKIP BIP
Feb 05 13:24:33 Paris-00100105 iwd[429]:         Supported iftypes: ad-hoc =
station ap p2p-client p2p-go p2p-device
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_use_d=
efault()
Feb 05 13:24:33 Paris-00100105 iwd[429]: No default interface for wiphy 0
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_confi=
g_notify() Notification of command New Interface(7)
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 3
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 3
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/manager.c:manager_confi=
g_notify() Notification of command New Interface(7)
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 4
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 4
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 4
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 4
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 3
Feb 05 13:24:33 Paris-00100105 iwd[429]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 4
Feb 05 13:24:34 Paris-00100105 iwd[429]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 2
Feb 05 13:24:34 Paris-00100105 iwd[429]: ../git/src/agent.c:agent_register(=
) agent register called
Feb 05 13:24:34 Paris-00100105 iwd[429]: ../git/src/agent.c:agent_register(=
) agent :1.6 path /net/connman/iwd_agent
Feb 05 13:24:36 Paris-00100105 iwd[429]: ../git/src/netdev.c:netdev_link_no=
tify() event 16 on ifindex 2
--===============0347233919900764706==--

