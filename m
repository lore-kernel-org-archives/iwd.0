Content-Type: multipart/mixed; boundary="===============3207729875019642723=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: Wifi Tethering
Date: Tue, 28 Apr 2020 07:33:56 -0500
Message-ID: <CAG17S_MG7iSYXW+YJb1xS03ZNp0m=XLyZr_6JdncOmnDMkeY=Q@mail.gmail.com>
In-Reply-To: <20200428121611.7r5izwsizyzicrww@beryllium.lan>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3207729875019642723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Daniel,

The pcap is here:
https://drive.google.com/open?id=3D18G8cM5Ob88YENZ6WCWJjhBDREol7vW-9

Regards,

Keith

On Tue, Apr 28, 2020 at 7:16 AM Daniel Wagner <wagi@monom.org> wrote:

> [Cc: iwd mailing list]
>
> On Tue, Apr 28, 2020 at 06:45:25AM -0500, KeithG wrote:
> > Daniel,
> >
> > I built the kernel/modules (I am on Arch on an RPi and the kernel I am
> > using is 4.19.114) and tried to diagnose the ap mode problem with nlmon
> and
> > get this, though I am sure I am doing it wrong:
> > # modprobe nlmon
> > # ip link add name nlmon type nlmon
> > # ip link set dev nlmon allmulticast on
> > # ip link set dev nlmon up
> > # tcpdump -i nlmon -w trace-file.pcap
> > tcpdump: listening on nlmon, link-type NETLINK (Linux netlink), capture
> > size 262144 bytes
> > ^C158 packets captured
> > 163 packets received by filter
> > 0 packets dropped by kernel
> > # iwmon -r trace-file.pcap
> > Wireless monitor ver 1.6
> > Invalid packet format
>
> Could you upload the pcap file somewhere? I suppose the iwd developers
> might
> be interested to inspect it.
>
> > In another window, I did this to see what was going on:
> > ~# connmanctl tether wifi on myssid password
> > Wifi SSID set
> > Wifi passphrase set
> > Enabled tethering for wifi
> > # ip addr
> > 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN gro=
up
> > default qlen 1000
> >     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> >     inet 127.0.0.1/8 scope host lo
> >        valid_lft forever preferred_lft forever
> >     inet6 ::1/128 scope host
> >        valid_lft forever preferred_lft forever
> > 2: eth0: <BROADCAST,MULTICAST,DYNAMIC,UP,LOWER_UP> mtu 1500 qdisc
> fq_codel
> > state UP group default qlen 1000
> >     link/ether a0:ce:c8:12:ed:05 brd ff:ff:ff:ff:ff:ff
> >     inet 192.168.2.25/24 brd 192.168.2.255 scope global eth0
> >        valid_lft forever preferred_lft forever
> >     inet6 fe80::a2ce:c8ff:fe12:ed05/64 scope link
> >        valid_lft forever preferred_lft forever
> > 3: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
> > fq_codel master tether state DORMANT group default qlen 1000
> >     link/ether b8:27:eb:28:18:48 brd ff:ff:ff:ff:ff:ff
> > 4: nlmon: <NOARP,ALLMULTI,UP,LOWER_UP> mtu 3904 qdisc noqueue state
> UNKNOWN
> > group default qlen 1000
> >     link/netlink
> > 5: tether: <NO-CARRIER,BROADCAST,MULTICAST,DYNAMIC,UP> mtu 1500 qdisc
> > noqueue state DOWN group default qlen 1000
> >     link/ether 9a:69:3a:48:c1:32 brd ff:ff:ff:ff:ff:ff
> >     inet 192.168.0.1/24 brd 192.168.0.255 scope global tether
> >        valid_lft forever preferred_lft forever
> >     inet6 fe80::c20:faff:fec4:92b9/64 scope link
> >        valid_lft forever preferred_lft forever
> >
> > I tried to connect to this AP with my Win10 laptop and get the response:
> > "Can't connect to this network". My Arch Laptop likewise will not
> connect.
> >
> > Now, when I run iwd -d, I get this:
> > # /usr/lib/iwd/iwd -d
> > No Diffie-Hellman support found, WPS will not be available
> > No asymmetric key support found.
> > TLS based WPA-Enterprise authentication methods will not function.
> > Kernel 4.20+ is required for this feature.
> > The following options are missing in the kernel:
> >         CONFIG_ASYMMETRIC_KEY_TYPE
> >         CONFIG_KEY_DH_OPERATIONS
> >         CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> >         CONFIG_PKCS7_MESSAGE_PARSER
> >         CONFIG_X509_CERTIFICATE_PARSER
> >         CONFIG_PKCS8_PRIVATE_KEY_PARSER
> > Wireless daemon version 1.6
> > src/main.c:main() Using configuration directory /etc/iwd
> > src/storage.c:storage_create_dirs() Using state directory /var/lib/iwd
> > src/main.c:nl80211_appeared() Found nl80211 interface
> > src/module.c:iwd_modules_init()
> > src/netdev.c:netdev_init() Opening route netlink socket
> > netconfig: Network configuration is disabled.
> > src/wsc.c:wsc_init()
> > src/eap.c:__eap_method_enable()
> > src/eap-wsc.c:eap_wsc_init()
> > src/eap-md5.c:eap_md5_init()
> > src/eap-tls.c:eap_tls_init()
> > src/eap-ttls.c:eap_ttls_init()
> > src/eap-mschapv2.c:eap_mschapv2_init()
> > src/eap-sim.c:eap_sim_init()
> > src/eap-aka.c:eap_aka_prime_init()
> > src/eap-aka.c:eap_aka_init()
> > src/eap-peap.c:eap_peap_init()
> > src/eap-gtc.c:eap_gtc_init()
> > src/eap-pwd.c:eap_pwd_init()
> > plugins/sim_hardcoded.c:sim_hardcoded_init() IWD_SIM_KEYS not set in env
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/wiphy.c:parse_supported_bands()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/wiphy.c:parse_supported_bands()
> > src/wiphy.c:parse_supported_frequencies()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/wiphy.c:parse_supported_bands()
> > src/wiphy.c:parse_supported_frequencies()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/wiphy.c:parse_supported_bands()
> > src/wiphy.c:parse_supported_frequencies()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/wiphy.c:parse_supported_bands()
> > src/wiphy.c:parse_supported_frequencies()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/wiphy.c:parse_supported_bands()
> > src/wiphy.c:parse_supported_frequencies()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/wiphy.c:parse_supported_bands()
> > src/wiphy.c:parse_supported_frequencies()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/wiphy.c:parse_supported_bands()
> > src/wiphy.c:parse_supported_frequencies()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/wiphy.c:parse_supported_bands()
> > src/wiphy.c:parse_supported_frequencies()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/wiphy.c:parse_supported_bands()
> > src/wiphy.c:parse_supported_frequencies()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/wiphy.c:parse_supported_bands()
> > src/wiphy.c:parse_supported_frequencies()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/wiphy.c:parse_supported_bands()
> > src/wiphy.c:parse_supported_frequencies()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/wiphy.c:parse_supported_bands()
> > src/wiphy.c:parse_supported_frequencies()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/wiphy.c:parse_supported_bands()
> > src/wiphy.c:parse_supported_frequencies()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/wiphy.c:parse_supported_bands()
> > src/wiphy.c:parse_supported_frequencies()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/wiphy.c:parse_supported_bands()
> > src/wiphy.c:parse_supported_frequencies()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/wiphy.c:parse_supported_bands()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/manager.c:manager_wiphy_dump_callback()
> > src/wiphy.c:wiphy_update_from_genl()
> > src/agent.c:agent_register() agent register called
> > src/agent.c:agent_register() agent :1.7 path /net/connman/iwd_agent
> > Wiphy: 0, Name: phy0
> >         Permanent Address: b8:27:eb:28:18:48
> >         Bands: 2.4 GHz
> >         Ciphers: CCMP TKIP
> >         Supported iftypes: ad-hoc station ap p2p-client p2p-go p2p-devi=
ce
> > Wiphy phy0 will only use the default interface
> > src/manager.c:manager_interface_dump_callback()
> > src/manager.c:manager_get_interface_cb()
> > src/manager.c:manager_use_default()
> > src/netdev.c:netdev_create_from_genl() Created interface wlan0[3 1]
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> > src/netdev.c:netdev_set_4addr() netdev: 3 use_4addr: 0
> > src/netdev.c:netdev_initial_up_cb() Interface 3 initialized
> >
> > strange thing is that most of those features are built in the kernel. My
> > kernel is 4.19.114 and the config specifies:
> > # CONFIG_CRYPTO_HW is not set
> > CONFIG_ASYMMETRIC_KEY_TYPE=3Dy
> > CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy
> > CONFIG_X509_CERTIFICATE_PARSER=3Dy
> > CONFIG_PKCS7_MESSAGE_PARSER=3Dy
> > I am currently re-building the kernel with:
> > CONFIG_KEY_DH_OPERATIONS=3Dy
> > as it was previously not set.
> > There does not seem to be any reference to PKCS8 for this kernel.
> >
> > Thanks!
> >
> > Keith
> >
> > On Mon, Apr 27, 2020 at 2:36 AM Daniel Wagner <wagi@monom.org> wrote:
> >
> > > On Sat, Apr 25, 2020 at 11:20:45AM -0500, KeithG wrote:
> > > > I looked at the IWD readme and cannot enable this on the RPi:
> > > >
> > > > # ip link set dev nlmon allmulticast on
> > > > > Cannot find device "nlmon"
> > >
> > > The RPi kernel has no support for nlmon enabled. If you want to debug
> this
> > > you
> > > propably need to compile your own RPi kernel with nlmon enabled.
> > >
> > > > I did verify a couple things. I do have iwd set explicitly when I
> start
> > > > connman
> > > >  /usr/bin/connmand --wifi=3Diwd_agent -n --nodnsproxy
> > >
> > > --wifi=3Diwd_agent is wrong. If you want iwd support you need to defi=
ne
> this
> > > at compile time only:
> > >
> > >    ./configure --enable-iwd --disable-wifi
> > >
> > > which adds the iwd plugin and disables the wpa_supplicant plugin. But=
 I
> > > don't
> > > think it matter. --iwfi-iwd_agent will be ignored and ConnMan will
> > > dynamically
> > > discover iwd. Just make sure wpa_supplicant is not running. With the
> above
> > > command line you would make sure wpa_supplicant is not accidentally
> used.
> > >
> > > > When I issue the command from connman, the mode changes in iwd:
> > > >
> > > > > # connmanctl tether wifi on myssid password
> > > > > Wifi SSID set
> > > > > Wifi passphrase set
> > > > > Enabled tethering for wifi
> > > > > # ip addr
> > > > > 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNO=
WN
> > > group
> > > > > default qlen 1000
> > > > >     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> > > > >     inet 127.0.0.1/8 scope host lo
> > > > >        valid_lft forever preferred_lft forever
> > > > >     inet6 ::1/128 scope host
> > > > >        valid_lft forever preferred_lft forever
> > > > > 2: eth0: <BROADCAST,MULTICAST,DYNAMIC,UP,LOWER_UP> mtu 1500 qdisc
> > > fq_codel
> > > > > state UP group default qlen 1000
> > > > >     link/ether a0:ce:c8:12:ed:05 brd ff:ff:ff:ff:ff:ff
> > > > >     inet 192.168.2.25/24 brd 192.168.2.255 scope global eth0
> > > > >        valid_lft forever preferred_lft forever
> > > > >     inet6 fe80::a2ce:c8ff:fe12:ed05/64 scope link
> > > > >        valid_lft forever preferred_lft forever
> > > > > 3: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
> qdisc
> > > > > fq_codel master tether state DORMANT group default qlen 1000
> > > > >     link/ether b8:27:eb:28:18:48 brd ff:ff:ff:ff:ff:ff
> > > > > 4: tether: <NO-CARRIER,BROADCAST,MULTICAST,DYNAMIC,UP> mtu 1500
> qdisc
> > > > > noqueue state DOWN group default qlen 1000
> > > > >     link/ether 9a:69:3a:48:c1:32 brd ff:ff:ff:ff:ff:ff
> > > > >     inet 192.168.0.1/24 brd 192.168.0.255 scope global tether
> > > > >        valid_lft forever preferred_lft forever
> > > > >     inet6 fe80::d024:5eff:fe80:1a57/64 scope link
> > > > >        valid_lft forever preferred_lft forever
> > > > > # iwctl device wlan0 show
> > > > >                                  Device: wlan0
> > > > >
> > > > >
> > >
> -------------------------------------------------------------------------=
-------
> > > > >   Settable  Property            Value
> > > > >
> > > > >
> > >
> -------------------------------------------------------------------------=
-------
> > > > >             Name                wlan0
> > > > >          *  Mode                ap
> > > > >          *  Powered             on
> > > > >             Address             b8:27:eb:28:18:48
> > > > >             Adapter             phy0
> > > > >
> > > >
> > > > I get these responses in the journal when I try to connect but it
> never
> > > > connects:
> > > >
> > > > > src/netdev.c:netdev_mlme_notify() MLME notification New Station(1=
9)
> > > > > src/netdev.c:netdev_mlme_notify() MLME notification Del Station(2=
0)
> > > > > src/netdev.c:netdev_mlme_notify() MLME notification Del Station(2=
0)
> > > > >
> > >
> > > Did you try to run iwd with debug enabled 'iwd -d'? Maybe there is mo=
re
> > > info. And if there isn't any clue, the best way forward is to get
> > > nlmon running and provide the information the iwd developers. From
> what I
> > > see ConnMan is talking to iwd and setups the AP mode.
> > >
> > > > I currently use hostapd and dnsmasq to have this headless RPi audio
> > > > appliance work as an AP for initial setup, but want to remove
> hostapd and
> > > > dnsmasq if I can get connman/iwd to do the same thing. I tried to
> get iwd
> > > > to go into ap mode and connect, but cannot do it there, either. I do
> get
> > > > some messages at startup of iwd. I do not think these are the
> problem,
> > > but
> > > > they are missing kernel modules:
> > > >
> > > > No Diffie-Hellman support found, WPS will not be available
> > > > > No asymmetric key support found.
> > > > > TLS based WPA-Enterprise authentication methods will not function.
> > > > > Kernel 4.20+ is required for this feature.
> > > > > The following options are missing in the kernel:
> > > > >         CONFIG_ASYMMETRIC_KEY_TYPE
> > > > >         CONFIG_KEY_DH_OPERATIONS
> > > > >         CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > > > >         CONFIG_PKCS7_MESSAGE_PARSER
> > > > >         CONFIG_X509_CERTIFICATE_PARSER
> > > > >         CONFIG_PKCS8_PRIVATE_KEY_PARSER
> > > > > Wireless daemon version 1.6
> > >
> > > I don't know but I would suggest to address this in the same go when
> you
> > > build
> > > a new kernel with nlmon support.
> > >
> > > Thanks,
> > > Daniel
> > >
>

--===============3207729875019642723==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5EYW5pZWwsPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGUg
cGNhcCBpcyBoZXJlOjwvZGl2PjxkaXY+PGEgaHJlZj0iaHR0cHM6Ly9kcml2ZS5nb29nbGUuY29t
L29wZW4/aWQ9MThHOGNNNU9iODhZRU5aNldDV0pqaEJEUkVvbDd2Vy05Ij5odHRwczovL2RyaXZl
Lmdvb2dsZS5jb20vb3Blbj9pZD0xOEc4Y001T2I4OFlFTlo2V0NXSmpoQkRSRW9sN3ZXLTk8L2E+
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5SZWdhcmRzLDwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+S2VpdGg8YnI+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2
IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gVHVlLCBBcHIgMjgsIDIwMjAgYXQgNzox
NiBBTSBEYW5pZWwgV2FnbmVyICZsdDs8YSBocmVmPSJtYWlsdG86d2FnaUBtb25vbS5vcmciPndh
Z2lAbW9ub20ub3JnPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDox
cHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5bQ2M6IGl3ZCBtYWls
aW5nIGxpc3RdPGJyPgo8YnI+Ck9uIFR1ZSwgQXByIDI4LCAyMDIwIGF0IDA2OjQ1OjI1QU0gLTA1
MDAsIEtlaXRoRyB3cm90ZTo8YnI+CiZndDsgRGFuaWVsLDxicj4KJmd0OyA8YnI+CiZndDsgSSBi
dWlsdCB0aGUga2VybmVsL21vZHVsZXMgKEkgYW0gb24gQXJjaCBvbiBhbiBSUGkgYW5kIHRoZSBr
ZXJuZWwgSSBhbTxicj4KJmd0OyB1c2luZyBpcyA0LjE5LjExNCkgYW5kIHRyaWVkIHRvIGRpYWdu
b3NlIHRoZSBhcCBtb2RlIHByb2JsZW0gd2l0aCBubG1vbiBhbmQ8YnI+CiZndDsgZ2V0IHRoaXMs
IHRob3VnaCBJIGFtIHN1cmUgSSBhbSBkb2luZyBpdCB3cm9uZzo8YnI+CiZndDsgIyBtb2Rwcm9i
ZSBubG1vbjxicj4KJmd0OyAjIGlwIGxpbmsgYWRkIG5hbWUgbmxtb24gdHlwZSBubG1vbjxicj4K
Jmd0OyAjIGlwIGxpbmsgc2V0IGRldiBubG1vbiBhbGxtdWx0aWNhc3Qgb248YnI+CiZndDsgIyBp
cCBsaW5rIHNldCBkZXYgbmxtb24gdXA8YnI+CiZndDsgIyB0Y3BkdW1wIC1pIG5sbW9uIC13IHRy
YWNlLWZpbGUucGNhcDxicj4KJmd0OyB0Y3BkdW1wOiBsaXN0ZW5pbmcgb24gbmxtb24sIGxpbmst
dHlwZSBORVRMSU5LIChMaW51eCBuZXRsaW5rKSwgY2FwdHVyZTxicj4KJmd0OyBzaXplIDI2MjE0
NCBieXRlczxicj4KJmd0OyBeQzE1OCBwYWNrZXRzIGNhcHR1cmVkPGJyPgomZ3Q7IDE2MyBwYWNr
ZXRzIHJlY2VpdmVkIGJ5IGZpbHRlcjxicj4KJmd0OyAwIHBhY2tldHMgZHJvcHBlZCBieSBrZXJu
ZWw8YnI+CiZndDsgIyBpd21vbiAtciB0cmFjZS1maWxlLnBjYXA8YnI+CiZndDsgV2lyZWxlc3Mg
bW9uaXRvciB2ZXIgMS42PGJyPgomZ3Q7IEludmFsaWQgcGFja2V0IGZvcm1hdDxicj4KPGJyPgpD
b3VsZCB5b3UgdXBsb2FkIHRoZSBwY2FwIGZpbGUgc29tZXdoZXJlPyBJIHN1cHBvc2UgdGhlIGl3
ZCBkZXZlbG9wZXJzIG1pZ2h0PGJyPgpiZSBpbnRlcmVzdGVkIHRvIGluc3BlY3QgaXQuPGJyPgo8
YnI+CiZndDsgSW4gYW5vdGhlciB3aW5kb3csIEkgZGlkIHRoaXMgdG8gc2VlIHdoYXQgd2FzIGdv
aW5nIG9uOjxicj4KJmd0OyB+IyBjb25ubWFuY3RsIHRldGhlciB3aWZpIG9uIG15c3NpZCBwYXNz
d29yZDxicj4KJmd0OyBXaWZpIFNTSUQgc2V0PGJyPgomZ3Q7IFdpZmkgcGFzc3BocmFzZSBzZXQ8
YnI+CiZndDsgRW5hYmxlZCB0ZXRoZXJpbmcgZm9yIHdpZmk8YnI+CiZndDsgIyBpcCBhZGRyPGJy
PgomZ3Q7IDE6IGxvOiAmbHQ7TE9PUEJBQ0ssVVAsTE9XRVJfVVAmZ3Q7IG10dSA2NTUzNiBxZGlz
YyBub3F1ZXVlIHN0YXRlIFVOS05PV04gZ3JvdXA8YnI+CiZndDsgZGVmYXVsdCBxbGVuIDEwMDA8
YnI+CiZndDvCoCDCoCDCoGxpbmsvbG9vcGJhY2sgMDA6MDA6MDA6MDA6MDA6MDAgYnJkIDAwOjAw
OjAwOjAwOjAwOjAwPGJyPgomZ3Q7wqAgwqAgwqBpbmV0IDxhIGhyZWY9Imh0dHA6Ly8xMjcuMC4w
LjEvOCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+MTI3LjAuMC4xLzg8L2E+IHNj
b3BlIGhvc3QgbG88YnI+CiZndDvCoCDCoCDCoCDCoCB2YWxpZF9sZnQgZm9yZXZlciBwcmVmZXJy
ZWRfbGZ0IGZvcmV2ZXI8YnI+CiZndDvCoCDCoCDCoGluZXQ2IDo6MS8xMjggc2NvcGUgaG9zdDxi
cj4KJmd0O8KgIMKgIMKgIMKgIHZhbGlkX2xmdCBmb3JldmVyIHByZWZlcnJlZF9sZnQgZm9yZXZl
cjxicj4KJmd0OyAyOiBldGgwOiAmbHQ7QlJPQURDQVNULE1VTFRJQ0FTVCxEWU5BTUlDLFVQLExP
V0VSX1VQJmd0OyBtdHUgMTUwMCBxZGlzYyBmcV9jb2RlbDxicj4KJmd0OyBzdGF0ZSBVUCBncm91
cCBkZWZhdWx0IHFsZW4gMTAwMDxicj4KJmd0O8KgIMKgIMKgbGluay9ldGhlciBhMDpjZTpjODox
MjplZDowNSBicmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmY8YnI+CiZndDvCoCDCoCDCoGluZXQgPGEgaHJl
Zj0iaHR0cDovLzE5Mi4xNjguMi4yNS8yNCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFu
ayI+MTkyLjE2OC4yLjI1LzI0PC9hPiBicmQgMTkyLjE2OC4yLjI1NSBzY29wZSBnbG9iYWwgZXRo
MDxicj4KJmd0O8KgIMKgIMKgIMKgIHZhbGlkX2xmdCBmb3JldmVyIHByZWZlcnJlZF9sZnQgZm9y
ZXZlcjxicj4KJmd0O8KgIMKgIMKgaW5ldDYgZmU4MDo6YTJjZTpjOGZmOmZlMTI6ZWQwNS82NCBz
Y29wZSBsaW5rPGJyPgomZ3Q7wqAgwqAgwqAgwqAgdmFsaWRfbGZ0IGZvcmV2ZXIgcHJlZmVycmVk
X2xmdCBmb3JldmVyPGJyPgomZ3Q7IDM6IHdsYW4wOiAmbHQ7Tk8tQ0FSUklFUixCUk9BRENBU1Qs
TVVMVElDQVNULFVQLExPV0VSX1VQJmd0OyBtdHUgMTUwMCBxZGlzYzxicj4KJmd0OyBmcV9jb2Rl
bCBtYXN0ZXIgdGV0aGVyIHN0YXRlIERPUk1BTlQgZ3JvdXAgZGVmYXVsdCBxbGVuIDEwMDA8YnI+
CiZndDvCoCDCoCDCoGxpbmsvZXRoZXIgYjg6Mjc6ZWI6Mjg6MTg6NDggYnJkIGZmOmZmOmZmOmZm
OmZmOmZmPGJyPgomZ3Q7IDQ6IG5sbW9uOiAmbHQ7Tk9BUlAsQUxMTVVMVEksVVAsTE9XRVJfVVAm
Z3Q7IG10dSAzOTA0IHFkaXNjIG5vcXVldWUgc3RhdGUgVU5LTk9XTjxicj4KJmd0OyBncm91cCBk
ZWZhdWx0IHFsZW4gMTAwMDxicj4KJmd0O8KgIMKgIMKgbGluay9uZXRsaW5rPGJyPgomZ3Q7IDU6
IHRldGhlcjogJmx0O05PLUNBUlJJRVIsQlJPQURDQVNULE1VTFRJQ0FTVCxEWU5BTUlDLFVQJmd0
OyBtdHUgMTUwMCBxZGlzYzxicj4KJmd0OyBub3F1ZXVlIHN0YXRlIERPV04gZ3JvdXAgZGVmYXVs
dCBxbGVuIDEwMDA8YnI+CiZndDvCoCDCoCDCoGxpbmsvZXRoZXIgOWE6Njk6M2E6NDg6YzE6MzIg
YnJkIGZmOmZmOmZmOmZmOmZmOmZmPGJyPgomZ3Q7wqAgwqAgwqBpbmV0IDxhIGhyZWY9Imh0dHA6
Ly8xOTIuMTY4LjAuMS8yNCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+MTkyLjE2
OC4wLjEvMjQ8L2E+IGJyZCAxOTIuMTY4LjAuMjU1IHNjb3BlIGdsb2JhbCB0ZXRoZXI8YnI+CiZn
dDvCoCDCoCDCoCDCoCB2YWxpZF9sZnQgZm9yZXZlciBwcmVmZXJyZWRfbGZ0IGZvcmV2ZXI8YnI+
CiZndDvCoCDCoCDCoGluZXQ2IGZlODA6OmMyMDpmYWZmOmZlYzQ6OTJiOS82NCBzY29wZSBsaW5r
PGJyPgomZ3Q7wqAgwqAgwqAgwqAgdmFsaWRfbGZ0IGZvcmV2ZXIgcHJlZmVycmVkX2xmdCBmb3Jl
dmVyPGJyPgomZ3Q7IDxicj4KJmd0OyBJIHRyaWVkIHRvIGNvbm5lY3QgdG8gdGhpcyBBUCB3aXRo
IG15IFdpbjEwIGxhcHRvcCBhbmQgZ2V0IHRoZSByZXNwb25zZTo8YnI+CiZndDsgJnF1b3Q7Q2Fu
JiMzOTt0IGNvbm5lY3QgdG8gdGhpcyBuZXR3b3JrJnF1b3Q7LiBNeSBBcmNoIExhcHRvcCBsaWtl
d2lzZSB3aWxsIG5vdCBjb25uZWN0Ljxicj4KJmd0OyA8YnI+CiZndDsgTm93LCB3aGVuIEkgcnVu
IGl3ZCAtZCwgSSBnZXQgdGhpczo8YnI+CiZndDsgIyAvdXNyL2xpYi9pd2QvaXdkIC1kPGJyPgom
Z3Q7IE5vIERpZmZpZS1IZWxsbWFuIHN1cHBvcnQgZm91bmQsIFdQUyB3aWxsIG5vdCBiZSBhdmFp
bGFibGU8YnI+CiZndDsgTm8gYXN5bW1ldHJpYyBrZXkgc3VwcG9ydCBmb3VuZC48YnI+CiZndDsg
VExTIGJhc2VkIFdQQS1FbnRlcnByaXNlIGF1dGhlbnRpY2F0aW9uIG1ldGhvZHMgd2lsbCBub3Qg
ZnVuY3Rpb24uPGJyPgomZ3Q7IEtlcm5lbCA0LjIwKyBpcyByZXF1aXJlZCBmb3IgdGhpcyBmZWF0
dXJlLjxicj4KJmd0OyBUaGUgZm9sbG93aW5nIG9wdGlvbnMgYXJlIG1pc3NpbmcgaW4gdGhlIGtl
cm5lbDo8YnI+CiZndDvCoCDCoCDCoCDCoCDCoENPTkZJR19BU1lNTUVUUklDX0tFWV9UWVBFPGJy
PgomZ3Q7wqAgwqAgwqAgwqAgwqBDT05GSUdfS0VZX0RIX09QRVJBVElPTlM8YnI+CiZndDvCoCDC
oCDCoCDCoCDCoENPTkZJR19BU1lNTUVUUklDX1BVQkxJQ19LRVlfU1VCVFlQRTxicj4KJmd0O8Kg
IMKgIMKgIMKgIMKgQ09ORklHX1BLQ1M3X01FU1NBR0VfUEFSU0VSPGJyPgomZ3Q7wqAgwqAgwqAg
wqAgwqBDT05GSUdfWDUwOV9DRVJUSUZJQ0FURV9QQVJTRVI8YnI+CiZndDvCoCDCoCDCoCDCoCDC
oENPTkZJR19QS0NTOF9QUklWQVRFX0tFWV9QQVJTRVI8YnI+CiZndDsgV2lyZWxlc3MgZGFlbW9u
IHZlcnNpb24gMS42PGJyPgomZ3Q7IHNyYy9tYWluLmM6bWFpbigpIFVzaW5nIGNvbmZpZ3VyYXRp
b24gZGlyZWN0b3J5IC9ldGMvaXdkPGJyPgomZ3Q7IHNyYy9zdG9yYWdlLmM6c3RvcmFnZV9jcmVh
dGVfZGlycygpIFVzaW5nIHN0YXRlIGRpcmVjdG9yeSAvdmFyL2xpYi9pd2Q8YnI+CiZndDsgc3Jj
L21haW4uYzpubDgwMjExX2FwcGVhcmVkKCkgRm91bmQgbmw4MDIxMSBpbnRlcmZhY2U8YnI+CiZn
dDsgc3JjL21vZHVsZS5jOml3ZF9tb2R1bGVzX2luaXQoKTxicj4KJmd0OyBzcmMvbmV0ZGV2LmM6
bmV0ZGV2X2luaXQoKSBPcGVuaW5nIHJvdXRlIG5ldGxpbmsgc29ja2V0PGJyPgomZ3Q7IG5ldGNv
bmZpZzogTmV0d29yayBjb25maWd1cmF0aW9uIGlzIGRpc2FibGVkLjxicj4KJmd0OyBzcmMvd3Nj
LmM6d3NjX2luaXQoKTxicj4KJmd0OyBzcmMvZWFwLmM6X19lYXBfbWV0aG9kX2VuYWJsZSgpPGJy
PgomZ3Q7IHNyYy9lYXAtd3NjLmM6ZWFwX3dzY19pbml0KCk8YnI+CiZndDsgc3JjL2VhcC1tZDUu
YzplYXBfbWQ1X2luaXQoKTxicj4KJmd0OyBzcmMvZWFwLXRscy5jOmVhcF90bHNfaW5pdCgpPGJy
PgomZ3Q7IHNyYy9lYXAtdHRscy5jOmVhcF90dGxzX2luaXQoKTxicj4KJmd0OyBzcmMvZWFwLW1z
Y2hhcHYyLmM6ZWFwX21zY2hhcHYyX2luaXQoKTxicj4KJmd0OyBzcmMvZWFwLXNpbS5jOmVhcF9z
aW1faW5pdCgpPGJyPgomZ3Q7IHNyYy9lYXAtYWthLmM6ZWFwX2FrYV9wcmltZV9pbml0KCk8YnI+
CiZndDsgc3JjL2VhcC1ha2EuYzplYXBfYWthX2luaXQoKTxicj4KJmd0OyBzcmMvZWFwLXBlYXAu
YzplYXBfcGVhcF9pbml0KCk8YnI+CiZndDsgc3JjL2VhcC1ndGMuYzplYXBfZ3RjX2luaXQoKTxi
cj4KJmd0OyBzcmMvZWFwLXB3ZC5jOmVhcF9wd2RfaW5pdCgpPGJyPgomZ3Q7IHBsdWdpbnMvc2lt
X2hhcmRjb2RlZC5jOnNpbV9oYXJkY29kZWRfaW5pdCgpIElXRF9TSU1fS0VZUyBub3Qgc2V0IGlu
IGVudjxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygp
PGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBz
cmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93
aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1h
bmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3Vw
ZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlfZHVt
cF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwo
KTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfYmFuZHMoKTxicj4KJmd0OyBz
cmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93
aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJz
ZV9zdXBwb3J0ZWRfYmFuZHMoKTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRf
ZnJlcXVlbmNpZXMoKTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlfZHVtcF9j
YWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwoKTxi
cj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfYmFuZHMoKTxicj4KJmd0OyBzcmMv
d2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfZnJlcXVlbmNpZXMoKTxicj4KJmd0OyBzcmMvbWFuYWdl
ci5jOm1hbmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndp
cGh5X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0
ZWRfYmFuZHMoKTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfZnJlcXVlbmNp
ZXMoKTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygp
PGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBz
cmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfYmFuZHMoKTxicj4KJmd0OyBzcmMvd2lwaHkuYzpw
YXJzZV9zdXBwb3J0ZWRfZnJlcXVlbmNpZXMoKTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1hbmFn
ZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3VwZGF0
ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfYmFuZHMo
KTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfZnJlcXVlbmNpZXMoKTxicj4K
Jmd0OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7
IHNyYy93aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBzcmMvd2lwaHku
YzpwYXJzZV9zdXBwb3J0ZWRfYmFuZHMoKTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBw
b3J0ZWRfZnJlcXVlbmNpZXMoKTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlf
ZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dl
bmwoKTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfYmFuZHMoKTxicj4KJmd0
OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfZnJlcXVlbmNpZXMoKTxicj4KJmd0OyBzcmMv
bWFuYWdlci5jOm1hbmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93aXBo
eS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9z
dXBwb3J0ZWRfYmFuZHMoKTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfZnJl
cXVlbmNpZXMoKTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlfZHVtcF9jYWxs
YmFjaygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4K
Jmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfYmFuZHMoKTxicj4KJmd0OyBzcmMvd2lw
aHkuYzpwYXJzZV9zdXBwb3J0ZWRfZnJlcXVlbmNpZXMoKTxicj4KJmd0OyBzcmMvbWFuYWdlci5j
Om1hbmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5
X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRf
YmFuZHMoKTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfZnJlcXVlbmNpZXMo
KTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygpPGJy
PgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBzcmMv
d2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfYmFuZHMoKTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJz
ZV9zdXBwb3J0ZWRfZnJlcXVlbmNpZXMoKTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJf
d2lwaHlfZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3VwZGF0ZV9m
cm9tX2dlbmwoKTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfYmFuZHMoKTxi
cj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfZnJlcXVlbmNpZXMoKTxicj4KJmd0
OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNy
Yy93aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBzcmMvd2lwaHkuYzpw
YXJzZV9zdXBwb3J0ZWRfYmFuZHMoKTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0
ZWRfZnJlcXVlbmNpZXMoKTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlfZHVt
cF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwo
KTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfYmFuZHMoKTxicj4KJmd0OyBz
cmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfZnJlcXVlbmNpZXMoKTxicj4KJmd0OyBzcmMvbWFu
YWdlci5jOm1hbmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93aXBoeS5j
OndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBw
b3J0ZWRfYmFuZHMoKTxicj4KJmd0OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfZnJlcXVl
bmNpZXMoKTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFj
aygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0
OyBzcmMvd2lwaHkuYzpwYXJzZV9zdXBwb3J0ZWRfYmFuZHMoKTxicj4KJmd0OyBzcmMvbWFuYWdl
ci5jOm1hbmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndp
cGh5X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfd2lw
aHlfZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9t
X2dlbmwoKTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFj
aygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0
OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNy
Yy93aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBzcmMvbWFuYWdlci5j
Om1hbmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5
X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlf
ZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dl
bmwoKTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygp
PGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBz
cmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93
aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1h
bmFnZXJfd2lwaHlfZHVtcF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3Vw
ZGF0ZV9mcm9tX2dlbmwoKTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfd2lwaHlfZHVt
cF9jYWxsYmFjaygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3VwZGF0ZV9mcm9tX2dlbmwo
KTxicj4KJmd0OyBzcmMvYWdlbnQuYzphZ2VudF9yZWdpc3RlcigpIGFnZW50IHJlZ2lzdGVyIGNh
bGxlZDxicj4KJmd0OyBzcmMvYWdlbnQuYzphZ2VudF9yZWdpc3RlcigpIGFnZW50IDoxLjcgcGF0
aCAvbmV0L2Nvbm5tYW4vaXdkX2FnZW50PGJyPgomZ3Q7IFdpcGh5OiAwLCBOYW1lOiBwaHkwPGJy
PgomZ3Q7wqAgwqAgwqAgwqAgwqBQZXJtYW5lbnQgQWRkcmVzczogYjg6Mjc6ZWI6Mjg6MTg6NDg8
YnI+CiZndDvCoCDCoCDCoCDCoCDCoEJhbmRzOiAyLjQgR0h6PGJyPgomZ3Q7wqAgwqAgwqAgwqAg
wqBDaXBoZXJzOiBDQ01QIFRLSVA8YnI+CiZndDvCoCDCoCDCoCDCoCDCoFN1cHBvcnRlZCBpZnR5
cGVzOiBhZC1ob2Mgc3RhdGlvbiBhcCBwMnAtY2xpZW50IHAycC1nbyBwMnAtZGV2aWNlPGJyPgom
Z3Q7IFdpcGh5IHBoeTAgd2lsbCBvbmx5IHVzZSB0aGUgZGVmYXVsdCBpbnRlcmZhY2U8YnI+CiZn
dDsgc3JjL21hbmFnZXIuYzptYW5hZ2VyX2ludGVyZmFjZV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZn
dDsgc3JjL21hbmFnZXIuYzptYW5hZ2VyX2dldF9pbnRlcmZhY2VfY2IoKTxicj4KJmd0OyBzcmMv
bWFuYWdlci5jOm1hbmFnZXJfdXNlX2RlZmF1bHQoKTxicj4KJmd0OyBzcmMvbmV0ZGV2LmM6bmV0
ZGV2X2NyZWF0ZV9mcm9tX2dlbmwoKSBDcmVhdGVkIGludGVyZmFjZSB3bGFuMFszIDFdPGJyPgom
Z3Q7IHNyYy9uZXRkZXYuYzpuZXRkZXZfbGlua19ub3RpZnkoKSBldmVudCAxNiBvbiBpZmluZGV4
IDM8YnI+CiZndDsgc3JjL25ldGRldi5jOm5ldGRldl9zZXRfNGFkZHIoKSBuZXRkZXY6IDMgdXNl
XzRhZGRyOiAwPGJyPgomZ3Q7IHNyYy9uZXRkZXYuYzpuZXRkZXZfaW5pdGlhbF91cF9jYigpIElu
dGVyZmFjZSAzIGluaXRpYWxpemVkPGJyPgomZ3Q7IDxicj4KJmd0OyBzdHJhbmdlIHRoaW5nIGlz
IHRoYXQgbW9zdCBvZiB0aG9zZSBmZWF0dXJlcyBhcmUgYnVpbHQgaW4gdGhlIGtlcm5lbC4gTXk8
YnI+CiZndDsga2VybmVsIGlzIDQuMTkuMTE0IGFuZCB0aGUgY29uZmlnIHNwZWNpZmllczo8YnI+
CiZndDsgIyBDT05GSUdfQ1JZUFRPX0hXIGlzIG5vdCBzZXQ8YnI+CiZndDsgQ09ORklHX0FTWU1N
RVRSSUNfS0VZX1RZUEU9eTxicj4KJmd0OyBDT05GSUdfQVNZTU1FVFJJQ19QVUJMSUNfS0VZX1NV
QlRZUEU9eTxicj4KJmd0OyBDT05GSUdfWDUwOV9DRVJUSUZJQ0FURV9QQVJTRVI9eTxicj4KJmd0
OyBDT05GSUdfUEtDUzdfTUVTU0FHRV9QQVJTRVI9eTxicj4KJmd0OyBJIGFtIGN1cnJlbnRseSBy
ZS1idWlsZGluZyB0aGUga2VybmVsIHdpdGg6PGJyPgomZ3Q7IENPTkZJR19LRVlfREhfT1BFUkFU
SU9OUz15PGJyPgomZ3Q7IGFzIGl0IHdhcyBwcmV2aW91c2x5IG5vdCBzZXQuPGJyPgomZ3Q7IFRo
ZXJlIGRvZXMgbm90IHNlZW0gdG8gYmUgYW55IHJlZmVyZW5jZSB0byBQS0NTOCBmb3IgdGhpcyBr
ZXJuZWwuPGJyPgomZ3Q7IDxicj4KJmd0OyBUaGFua3MhPGJyPgomZ3Q7IDxicj4KJmd0OyBLZWl0
aDxicj4KJmd0OyA8YnI+CiZndDsgT24gTW9uLCBBcHIgMjcsIDIwMjAgYXQgMjozNiBBTSBEYW5p
ZWwgV2FnbmVyICZsdDs8YSBocmVmPSJtYWlsdG86d2FnaUBtb25vbS5vcmciIHRhcmdldD0iX2Js
YW5rIj53YWdpQG1vbm9tLm9yZzwvYT4mZ3Q7IHdyb3RlOjxicj4KJmd0OyA8YnI+CiZndDsgJmd0
OyBPbiBTYXQsIEFwciAyNSwgMjAyMCBhdCAxMToyMDo0NUFNIC0wNTAwLCBLZWl0aEcgd3JvdGU6
PGJyPgomZ3Q7ICZndDsgJmd0OyBJIGxvb2tlZCBhdCB0aGUgSVdEIHJlYWRtZSBhbmQgY2Fubm90
IGVuYWJsZSB0aGlzIG9uIHRoZSBSUGk6PGJyPgomZ3Q7ICZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7
ICZndDsgIyBpcCBsaW5rIHNldCBkZXYgbmxtb24gYWxsbXVsdGljYXN0IG9uPGJyPgomZ3Q7ICZn
dDsgJmd0OyAmZ3Q7IENhbm5vdCBmaW5kIGRldmljZSAmcXVvdDtubG1vbiZxdW90Ozxicj4KJmd0
OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgVGhlIFJQaSBrZXJuZWwgaGFzIG5vIHN1cHBvcnQgZm9yIG5s
bW9uIGVuYWJsZWQuIElmIHlvdSB3YW50IHRvIGRlYnVnIHRoaXM8YnI+CiZndDsgJmd0OyB5b3U8
YnI+CiZndDsgJmd0OyBwcm9wYWJseSBuZWVkIHRvIGNvbXBpbGUgeW91ciBvd24gUlBpIGtlcm5l
bCB3aXRoIG5sbW9uIGVuYWJsZWQuPGJyPgomZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7IEkg
ZGlkIHZlcmlmeSBhIGNvdXBsZSB0aGluZ3MuIEkgZG8gaGF2ZSBpd2Qgc2V0IGV4cGxpY2l0bHkg
d2hlbiBJIHN0YXJ0PGJyPgomZ3Q7ICZndDsgJmd0OyBjb25ubWFuPGJyPgomZ3Q7ICZndDsgJmd0
O8KgIC91c3IvYmluL2Nvbm5tYW5kIC0td2lmaT1pd2RfYWdlbnQgLW4gLS1ub2Ruc3Byb3h5PGJy
PgomZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyAtLXdpZmk9aXdkX2FnZW50IGlzIHdyb25nLiBJZiB5
b3Ugd2FudCBpd2Qgc3VwcG9ydCB5b3UgbmVlZCB0byBkZWZpbmUgdGhpczxicj4KJmd0OyAmZ3Q7
IGF0IGNvbXBpbGUgdGltZSBvbmx5Ojxicj4KJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDvCoCDCoCAu
L2NvbmZpZ3VyZSAtLWVuYWJsZS1pd2QgLS1kaXNhYmxlLXdpZmk8YnI+CiZndDsgJmd0Ozxicj4K
Jmd0OyAmZ3Q7IHdoaWNoIGFkZHMgdGhlIGl3ZCBwbHVnaW4gYW5kIGRpc2FibGVzIHRoZSB3cGFf
c3VwcGxpY2FudCBwbHVnaW4uIEJ1dCBJPGJyPgomZ3Q7ICZndDsgZG9uJiMzOTt0PGJyPgomZ3Q7
ICZndDsgdGhpbmsgaXQgbWF0dGVyLiAtLWl3ZmktaXdkX2FnZW50IHdpbGwgYmUgaWdub3JlZCBh
bmQgQ29ubk1hbiB3aWxsPGJyPgomZ3Q7ICZndDsgZHluYW1pY2FsbHk8YnI+CiZndDsgJmd0OyBk
aXNjb3ZlciBpd2QuIEp1c3QgbWFrZSBzdXJlIHdwYV9zdXBwbGljYW50IGlzIG5vdCBydW5uaW5n
LiBXaXRoIHRoZSBhYm92ZTxicj4KJmd0OyAmZ3Q7IGNvbW1hbmQgbGluZSB5b3Ugd291bGQgbWFr
ZSBzdXJlIHdwYV9zdXBwbGljYW50IGlzIG5vdCBhY2NpZGVudGFsbHkgdXNlZC48YnI+CiZndDsg
Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgV2hlbiBJIGlzc3VlIHRoZSBjb21tYW5kIGZyb20gY29u
bm1hbiwgdGhlIG1vZGUgY2hhbmdlcyBpbiBpd2Q6PGJyPgomZ3Q7ICZndDsgJmd0Ozxicj4KJmd0
OyAmZ3Q7ICZndDsgJmd0OyAjIGNvbm5tYW5jdGwgdGV0aGVyIHdpZmkgb24gbXlzc2lkIHBhc3N3
b3JkPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7IFdpZmkgU1NJRCBzZXQ8YnI+CiZndDsgJmd0OyAm
Z3Q7ICZndDsgV2lmaSBwYXNzcGhyYXNlIHNldDxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyBFbmFi
bGVkIHRldGhlcmluZyBmb3Igd2lmaTxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAjIGlwIGFkZHI8
YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgMTogbG86ICZsdDtMT09QQkFDSyxVUCxMT1dFUl9VUCZn
dDsgbXR1IDY1NTM2IHFkaXNjIG5vcXVldWUgc3RhdGUgVU5LTk9XTjxicj4KJmd0OyAmZ3Q7IGdy
b3VwPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7IGRlZmF1bHQgcWxlbiAxMDAwPGJyPgomZ3Q7ICZn
dDsgJmd0OyAmZ3Q7wqAgwqAgwqBsaW5rL2xvb3BiYWNrIDAwOjAwOjAwOjAwOjAwOjAwIGJyZCAw
MDowMDowMDowMDowMDowMDxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgaW5ldCA8YSBo
cmVmPSJodHRwOi8vMTI3LjAuMC4xLzgiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsi
PjEyNy4wLjAuMS84PC9hPiBzY29wZSBob3N0IGxvPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAg
wqAgwqAgwqAgdmFsaWRfbGZ0IGZvcmV2ZXIgcHJlZmVycmVkX2xmdCBmb3JldmVyPGJyPgomZ3Q7
ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqBpbmV0NiA6OjEvMTI4IHNjb3BlIGhvc3Q8YnI+CiZndDsg
Jmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCB2YWxpZF9sZnQgZm9yZXZlciBwcmVmZXJyZWRfbGZ0
IGZvcmV2ZXI8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgMjogZXRoMDogJmx0O0JST0FEQ0FTVCxN
VUxUSUNBU1QsRFlOQU1JQyxVUCxMT1dFUl9VUCZndDsgbXR1IDE1MDAgcWRpc2M8YnI+CiZndDsg
Jmd0OyBmcV9jb2RlbDxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyBzdGF0ZSBVUCBncm91cCBkZWZh
dWx0IHFsZW4gMTAwMDxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgbGluay9ldGhlciBh
MDpjZTpjODoxMjplZDowNSBicmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmY8YnI+CiZndDsgJmd0OyAmZ3Q7
ICZndDvCoCDCoCDCoGluZXQgPGEgaHJlZj0iaHR0cDovLzE5Mi4xNjguMi4yNS8yNCIgcmVsPSJu
b3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+MTkyLjE2OC4yLjI1LzI0PC9hPiBicmQgMTkyLjE2
OC4yLjI1NSBzY29wZSBnbG9iYWwgZXRoMDxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKg
IMKgIHZhbGlkX2xmdCBmb3JldmVyIHByZWZlcnJlZF9sZnQgZm9yZXZlcjxicj4KJmd0OyAmZ3Q7
ICZndDsgJmd0O8KgIMKgIMKgaW5ldDYgZmU4MDo6YTJjZTpjOGZmOmZlMTI6ZWQwNS82NCBzY29w
ZSBsaW5rPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgdmFsaWRfbGZ0IGZvcmV2
ZXIgcHJlZmVycmVkX2xmdCBmb3JldmVyPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7IDM6IHdsYW4w
OiAmbHQ7Tk8tQ0FSUklFUixCUk9BRENBU1QsTVVMVElDQVNULFVQLExPV0VSX1VQJmd0OyBtdHUg
MTUwMCBxZGlzYzxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyBmcV9jb2RlbCBtYXN0ZXIgdGV0aGVy
IHN0YXRlIERPUk1BTlQgZ3JvdXAgZGVmYXVsdCBxbGVuIDEwMDA8YnI+CiZndDsgJmd0OyAmZ3Q7
ICZndDvCoCDCoCDCoGxpbmsvZXRoZXIgYjg6Mjc6ZWI6Mjg6MTg6NDggYnJkIGZmOmZmOmZmOmZm
OmZmOmZmPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7IDQ6IHRldGhlcjogJmx0O05PLUNBUlJJRVIs
QlJPQURDQVNULE1VTFRJQ0FTVCxEWU5BTUlDLFVQJmd0OyBtdHUgMTUwMCBxZGlzYzxicj4KJmd0
OyAmZ3Q7ICZndDsgJmd0OyBub3F1ZXVlIHN0YXRlIERPV04gZ3JvdXAgZGVmYXVsdCBxbGVuIDEw
MDA8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoGxpbmsvZXRoZXIgOWE6Njk6M2E6NDg6
YzE6MzIgYnJkIGZmOmZmOmZmOmZmOmZmOmZmPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAg
wqBpbmV0IDxhIGhyZWY9Imh0dHA6Ly8xOTIuMTY4LjAuMS8yNCIgcmVsPSJub3JlZmVycmVyIiB0
YXJnZXQ9Il9ibGFuayI+MTkyLjE2OC4wLjEvMjQ8L2E+IGJyZCAxOTIuMTY4LjAuMjU1IHNjb3Bl
IGdsb2JhbCB0ZXRoZXI8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCB2YWxpZF9s
ZnQgZm9yZXZlciBwcmVmZXJyZWRfbGZ0IGZvcmV2ZXI8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDvC
oCDCoCDCoGluZXQ2IGZlODA6OmQwMjQ6NWVmZjpmZTgwOjFhNTcvNjQgc2NvcGUgbGluazxicj4K
Jmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIHZhbGlkX2xmdCBmb3JldmVyIHByZWZlcnJl
ZF9sZnQgZm9yZXZlcjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAjIGl3Y3RsIGRldmljZSB3bGFu
MCBzaG93PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgRGV2aWNlOiB3bGFuMDxicj4KJmd0OyAmZ3Q7ICZndDsg
Jmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqBTZXR0YWJsZcKgIFByb3BlcnR5
wqAgwqAgwqAgwqAgwqAgwqAgVmFsdWU8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDs8YnI+CiZndDsg
Jmd0OyAmZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj4K
Jmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgTmFtZcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHdsYW4wPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgKsKg
IE1vZGXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBhcDxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0O8Kg
IMKgIMKgIMKgIMKgICrCoCBQb3dlcmVkwqAgwqAgwqAgwqAgwqAgwqAgwqBvbjxicj4KJmd0OyAm
Z3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgQWRkcmVzc8KgIMKgIMKgIMKgIMKgIMKg
IMKgYjg6Mjc6ZWI6Mjg6MTg6NDg8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoEFkYXB0ZXLCoCDCoCDCoCDCoCDCoCDCoCDCoHBoeTA8YnI+CiZndDsgJmd0OyAmZ3Q7
ICZndDs8YnI+CiZndDsgJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyBJIGdldCB0aGVzZSBy
ZXNwb25zZXMgaW4gdGhlIGpvdXJuYWwgd2hlbiBJIHRyeSB0byBjb25uZWN0IGJ1dCBpdCBuZXZl
cjxicj4KJmd0OyAmZ3Q7ICZndDsgY29ubmVjdHM6PGJyPgomZ3Q7ICZndDsgJmd0Ozxicj4KJmd0
OyAmZ3Q7ICZndDsgJmd0OyBzcmMvbmV0ZGV2LmM6bmV0ZGV2X21sbWVfbm90aWZ5KCkgTUxNRSBu
b3RpZmljYXRpb24gTmV3IFN0YXRpb24oMTkpPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7IHNyYy9u
ZXRkZXYuYzpuZXRkZXZfbWxtZV9ub3RpZnkoKSBNTE1FIG5vdGlmaWNhdGlvbiBEZWwgU3RhdGlv
bigyMCk8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgc3JjL25ldGRldi5jOm5ldGRldl9tbG1lX25v
dGlmeSgpIE1MTUUgbm90aWZpY2F0aW9uIERlbCBTdGF0aW9uKDIwKTxicj4KJmd0OyAmZ3Q7ICZn
dDsgJmd0Ozxicj4KJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgRGlkIHlvdSB0cnkgdG8gcnVuIGl3
ZCB3aXRoIGRlYnVnIGVuYWJsZWQgJiMzOTtpd2QgLWQmIzM5Oz8gTWF5YmUgdGhlcmUgaXMgbW9y
ZTxicj4KJmd0OyAmZ3Q7IGluZm8uIEFuZCBpZiB0aGVyZSBpc24mIzM5O3QgYW55IGNsdWUsIHRo
ZSBiZXN0IHdheSBmb3J3YXJkIGlzIHRvIGdldDxicj4KJmd0OyAmZ3Q7IG5sbW9uIHJ1bm5pbmcg
YW5kIHByb3ZpZGUgdGhlIGluZm9ybWF0aW9uIHRoZSBpd2QgZGV2ZWxvcGVycy4gRnJvbSB3aGF0
IEk8YnI+CiZndDsgJmd0OyBzZWUgQ29ubk1hbiBpcyB0YWxraW5nIHRvIGl3ZCBhbmQgc2V0dXBz
IHRoZSBBUCBtb2RlLjxicj4KJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyBJIGN1cnJlbnRs
eSB1c2UgaG9zdGFwZCBhbmQgZG5zbWFzcSB0byBoYXZlIHRoaXMgaGVhZGxlc3MgUlBpIGF1ZGlv
PGJyPgomZ3Q7ICZndDsgJmd0OyBhcHBsaWFuY2Ugd29yayBhcyBhbiBBUCBmb3IgaW5pdGlhbCBz
ZXR1cCwgYnV0IHdhbnQgdG8gcmVtb3ZlIGhvc3RhcGQgYW5kPGJyPgomZ3Q7ICZndDsgJmd0OyBk
bnNtYXNxIGlmIEkgY2FuIGdldCBjb25ubWFuL2l3ZCB0byBkbyB0aGUgc2FtZSB0aGluZy4gSSB0
cmllZCB0byBnZXQgaXdkPGJyPgomZ3Q7ICZndDsgJmd0OyB0byBnbyBpbnRvIGFwIG1vZGUgYW5k
IGNvbm5lY3QsIGJ1dCBjYW5ub3QgZG8gaXQgdGhlcmUsIGVpdGhlci4gSSBkbyBnZXQ8YnI+CiZn
dDsgJmd0OyAmZ3Q7IHNvbWUgbWVzc2FnZXMgYXQgc3RhcnR1cCBvZiBpd2QuIEkgZG8gbm90IHRo
aW5rIHRoZXNlIGFyZSB0aGUgcHJvYmxlbSw8YnI+CiZndDsgJmd0OyBidXQ8YnI+CiZndDsgJmd0
OyAmZ3Q7IHRoZXkgYXJlIG1pc3Npbmcga2VybmVsIG1vZHVsZXM6PGJyPgomZ3Q7ICZndDsgJmd0
Ozxicj4KJmd0OyAmZ3Q7ICZndDsgTm8gRGlmZmllLUhlbGxtYW4gc3VwcG9ydCBmb3VuZCwgV1BT
IHdpbGwgbm90IGJlIGF2YWlsYWJsZTxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyBObyBhc3ltbWV0
cmljIGtleSBzdXBwb3J0IGZvdW5kLjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyBUTFMgYmFzZWQg
V1BBLUVudGVycHJpc2UgYXV0aGVudGljYXRpb24gbWV0aG9kcyB3aWxsIG5vdCBmdW5jdGlvbi48
YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgS2VybmVsIDQuMjArIGlzIHJlcXVpcmVkIGZvciB0aGlz
IGZlYXR1cmUuPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7IFRoZSBmb2xsb3dpbmcgb3B0aW9ucyBh
cmUgbWlzc2luZyBpbiB0aGUga2VybmVsOjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgQ09ORklHX0FTWU1NRVRSSUNfS0VZX1RZUEU8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoENPTkZJR19LRVlfREhfT1BFUkFUSU9OUzxicj4KJmd0OyAmZ3Q7ICZndDsg
Jmd0O8KgIMKgIMKgIMKgIMKgQ09ORklHX0FTWU1NRVRSSUNfUFVCTElDX0tFWV9TVUJUWVBFPGJy
PgomZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqBDT05GSUdfUEtDUzdfTUVTU0FHRV9Q
QVJTRVI8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoENPTkZJR19YNTA5X0NF
UlRJRklDQVRFX1BBUlNFUjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgQ09O
RklHX1BLQ1M4X1BSSVZBVEVfS0VZX1BBUlNFUjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyBXaXJl
bGVzcyBkYWVtb24gdmVyc2lvbiAxLjY8YnI+CiZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7IEkgZG9u
JiMzOTt0IGtub3cgYnV0IEkgd291bGQgc3VnZ2VzdCB0byBhZGRyZXNzIHRoaXMgaW4gdGhlIHNh
bWUgZ28gd2hlbiB5b3U8YnI+CiZndDsgJmd0OyBidWlsZDxicj4KJmd0OyAmZ3Q7IGEgbmV3IGtl
cm5lbCB3aXRoIG5sbW9uIHN1cHBvcnQuPGJyPgomZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyBUaGFu
a3MsPGJyPgomZ3Q7ICZndDsgRGFuaWVsPGJyPgomZ3Q7ICZndDs8YnI+CjwvYmxvY2txdW90ZT48
L2Rpdj4K

--===============3207729875019642723==--

