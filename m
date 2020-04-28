Content-Type: multipart/mixed; boundary="===============3385371810220565056=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: Wifi Tethering
Date: Tue, 28 Apr 2020 14:16:11 +0200
Message-ID: <20200428121611.7r5izwsizyzicrww@beryllium.lan>
In-Reply-To: <CAG17S_ObgzRRisCS5U0Q_rZ3jQfPJRTcnM2oQOb=FOx4ut=+6Q@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3385371810220565056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[Cc: iwd mailing list]

On Tue, Apr 28, 2020 at 06:45:25AM -0500, KeithG wrote:
> Daniel,
> =

> I built the kernel/modules (I am on Arch on an RPi and the kernel I am
> using is 4.19.114) and tried to diagnose the ap mode problem with nlmon a=
nd
> get this, though I am sure I am doing it wrong:
> # modprobe nlmon
> # ip link add name nlmon type nlmon
> # ip link set dev nlmon allmulticast on
> # ip link set dev nlmon up
> # tcpdump -i nlmon -w trace-file.pcap
> tcpdump: listening on nlmon, link-type NETLINK (Linux netlink), capture
> size 262144 bytes
> ^C158 packets captured
> 163 packets received by filter
> 0 packets dropped by kernel
> # iwmon -r trace-file.pcap
> Wireless monitor ver 1.6
> Invalid packet format

Could you upload the pcap file somewhere? I suppose the iwd developers might
be interested to inspect it.

> In another window, I did this to see what was going on:
> ~# connmanctl tether wifi on myssid password
> Wifi SSID set
> Wifi passphrase set
> Enabled tethering for wifi
> # ip addr
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group
> default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>     inet 127.0.0.1/8 scope host lo
>        valid_lft forever preferred_lft forever
>     inet6 ::1/128 scope host
>        valid_lft forever preferred_lft forever
> 2: eth0: <BROADCAST,MULTICAST,DYNAMIC,UP,LOWER_UP> mtu 1500 qdisc fq_codel
> state UP group default qlen 1000
>     link/ether a0:ce:c8:12:ed:05 brd ff:ff:ff:ff:ff:ff
>     inet 192.168.2.25/24 brd 192.168.2.255 scope global eth0
>        valid_lft forever preferred_lft forever
>     inet6 fe80::a2ce:c8ff:fe12:ed05/64 scope link
>        valid_lft forever preferred_lft forever
> 3: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
> fq_codel master tether state DORMANT group default qlen 1000
>     link/ether b8:27:eb:28:18:48 brd ff:ff:ff:ff:ff:ff
> 4: nlmon: <NOARP,ALLMULTI,UP,LOWER_UP> mtu 3904 qdisc noqueue state UNKNO=
WN
> group default qlen 1000
>     link/netlink
> 5: tether: <NO-CARRIER,BROADCAST,MULTICAST,DYNAMIC,UP> mtu 1500 qdisc
> noqueue state DOWN group default qlen 1000
>     link/ether 9a:69:3a:48:c1:32 brd ff:ff:ff:ff:ff:ff
>     inet 192.168.0.1/24 brd 192.168.0.255 scope global tether
>        valid_lft forever preferred_lft forever
>     inet6 fe80::c20:faff:fec4:92b9/64 scope link
>        valid_lft forever preferred_lft forever
> =

> I tried to connect to this AP with my Win10 laptop and get the response:
> "Can't connect to this network". My Arch Laptop likewise will not connect.
> =

> Now, when I run iwd -d, I get this:
> # /usr/lib/iwd/iwd -d
> No Diffie-Hellman support found, WPS will not be available
> No asymmetric key support found.
> TLS based WPA-Enterprise authentication methods will not function.
> Kernel 4.20+ is required for this feature.
> The following options are missing in the kernel:
>         CONFIG_ASYMMETRIC_KEY_TYPE
>         CONFIG_KEY_DH_OPERATIONS
>         CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>         CONFIG_PKCS7_MESSAGE_PARSER
>         CONFIG_X509_CERTIFICATE_PARSER
>         CONFIG_PKCS8_PRIVATE_KEY_PARSER
> Wireless daemon version 1.6
> src/main.c:main() Using configuration directory /etc/iwd
> src/storage.c:storage_create_dirs() Using state directory /var/lib/iwd
> src/main.c:nl80211_appeared() Found nl80211 interface
> src/module.c:iwd_modules_init()
> src/netdev.c:netdev_init() Opening route netlink socket
> netconfig: Network configuration is disabled.
> src/wsc.c:wsc_init()
> src/eap.c:__eap_method_enable()
> src/eap-wsc.c:eap_wsc_init()
> src/eap-md5.c:eap_md5_init()
> src/eap-tls.c:eap_tls_init()
> src/eap-ttls.c:eap_ttls_init()
> src/eap-mschapv2.c:eap_mschapv2_init()
> src/eap-sim.c:eap_sim_init()
> src/eap-aka.c:eap_aka_prime_init()
> src/eap-aka.c:eap_aka_init()
> src/eap-peap.c:eap_peap_init()
> src/eap-gtc.c:eap_gtc_init()
> src/eap-pwd.c:eap_pwd_init()
> plugins/sim_hardcoded.c:sim_hardcoded_init() IWD_SIM_KEYS not set in env
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/wiphy.c:parse_supported_bands()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/wiphy.c:parse_supported_bands()
> src/wiphy.c:parse_supported_frequencies()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/wiphy.c:parse_supported_bands()
> src/wiphy.c:parse_supported_frequencies()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/wiphy.c:parse_supported_bands()
> src/wiphy.c:parse_supported_frequencies()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/wiphy.c:parse_supported_bands()
> src/wiphy.c:parse_supported_frequencies()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/wiphy.c:parse_supported_bands()
> src/wiphy.c:parse_supported_frequencies()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/wiphy.c:parse_supported_bands()
> src/wiphy.c:parse_supported_frequencies()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/wiphy.c:parse_supported_bands()
> src/wiphy.c:parse_supported_frequencies()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/wiphy.c:parse_supported_bands()
> src/wiphy.c:parse_supported_frequencies()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/wiphy.c:parse_supported_bands()
> src/wiphy.c:parse_supported_frequencies()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/wiphy.c:parse_supported_bands()
> src/wiphy.c:parse_supported_frequencies()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/wiphy.c:parse_supported_bands()
> src/wiphy.c:parse_supported_frequencies()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/wiphy.c:parse_supported_bands()
> src/wiphy.c:parse_supported_frequencies()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/wiphy.c:parse_supported_bands()
> src/wiphy.c:parse_supported_frequencies()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/wiphy.c:parse_supported_bands()
> src/wiphy.c:parse_supported_frequencies()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/wiphy.c:parse_supported_bands()
> src/wiphy.c:parse_supported_frequencies()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/wiphy.c:parse_supported_bands()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/manager.c:manager_wiphy_dump_callback()
> src/wiphy.c:wiphy_update_from_genl()
> src/agent.c:agent_register() agent register called
> src/agent.c:agent_register() agent :1.7 path /net/connman/iwd_agent
> Wiphy: 0, Name: phy0
>         Permanent Address: b8:27:eb:28:18:48
>         Bands: 2.4 GHz
>         Ciphers: CCMP TKIP
>         Supported iftypes: ad-hoc station ap p2p-client p2p-go p2p-device
> Wiphy phy0 will only use the default interface
> src/manager.c:manager_interface_dump_callback()
> src/manager.c:manager_get_interface_cb()
> src/manager.c:manager_use_default()
> src/netdev.c:netdev_create_from_genl() Created interface wlan0[3 1]
> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> src/netdev.c:netdev_set_4addr() netdev: 3 use_4addr: 0
> src/netdev.c:netdev_initial_up_cb() Interface 3 initialized
> =

> strange thing is that most of those features are built in the kernel. My
> kernel is 4.19.114 and the config specifies:
> # CONFIG_CRYPTO_HW is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=3Dy
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy
> CONFIG_X509_CERTIFICATE_PARSER=3Dy
> CONFIG_PKCS7_MESSAGE_PARSER=3Dy
> I am currently re-building the kernel with:
> CONFIG_KEY_DH_OPERATIONS=3Dy
> as it was previously not set.
> There does not seem to be any reference to PKCS8 for this kernel.
> =

> Thanks!
> =

> Keith
> =

> On Mon, Apr 27, 2020 at 2:36 AM Daniel Wagner <wagi@monom.org> wrote:
> =

> > On Sat, Apr 25, 2020 at 11:20:45AM -0500, KeithG wrote:
> > > I looked at the IWD readme and cannot enable this on the RPi:
> > >
> > > # ip link set dev nlmon allmulticast on
> > > > Cannot find device "nlmon"
> >
> > The RPi kernel has no support for nlmon enabled. If you want to debug t=
his
> > you
> > propably need to compile your own RPi kernel with nlmon enabled.
> >
> > > I did verify a couple things. I do have iwd set explicitly when I sta=
rt
> > > connman
> > >  /usr/bin/connmand --wifi=3Diwd_agent -n --nodnsproxy
> >
> > --wifi=3Diwd_agent is wrong. If you want iwd support you need to define=
 this
> > at compile time only:
> >
> >    ./configure --enable-iwd --disable-wifi
> >
> > which adds the iwd plugin and disables the wpa_supplicant plugin. But I
> > don't
> > think it matter. --iwfi-iwd_agent will be ignored and ConnMan will
> > dynamically
> > discover iwd. Just make sure wpa_supplicant is not running. With the ab=
ove
> > command line you would make sure wpa_supplicant is not accidentally use=
d.
> >
> > > When I issue the command from connman, the mode changes in iwd:
> > >
> > > > # connmanctl tether wifi on myssid password
> > > > Wifi SSID set
> > > > Wifi passphrase set
> > > > Enabled tethering for wifi
> > > > # ip addr
> > > > 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
> > group
> > > > default qlen 1000
> > > >     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> > > >     inet 127.0.0.1/8 scope host lo
> > > >        valid_lft forever preferred_lft forever
> > > >     inet6 ::1/128 scope host
> > > >        valid_lft forever preferred_lft forever
> > > > 2: eth0: <BROADCAST,MULTICAST,DYNAMIC,UP,LOWER_UP> mtu 1500 qdisc
> > fq_codel
> > > > state UP group default qlen 1000
> > > >     link/ether a0:ce:c8:12:ed:05 brd ff:ff:ff:ff:ff:ff
> > > >     inet 192.168.2.25/24 brd 192.168.2.255 scope global eth0
> > > >        valid_lft forever preferred_lft forever
> > > >     inet6 fe80::a2ce:c8ff:fe12:ed05/64 scope link
> > > >        valid_lft forever preferred_lft forever
> > > > 3: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdi=
sc
> > > > fq_codel master tether state DORMANT group default qlen 1000
> > > >     link/ether b8:27:eb:28:18:48 brd ff:ff:ff:ff:ff:ff
> > > > 4: tether: <NO-CARRIER,BROADCAST,MULTICAST,DYNAMIC,UP> mtu 1500 qdi=
sc
> > > > noqueue state DOWN group default qlen 1000
> > > >     link/ether 9a:69:3a:48:c1:32 brd ff:ff:ff:ff:ff:ff
> > > >     inet 192.168.0.1/24 brd 192.168.0.255 scope global tether
> > > >        valid_lft forever preferred_lft forever
> > > >     inet6 fe80::d024:5eff:fe80:1a57/64 scope link
> > > >        valid_lft forever preferred_lft forever
> > > > # iwctl device wlan0 show
> > > >                                  Device: wlan0
> > > >
> > > >
> > -----------------------------------------------------------------------=
---------
> > > >   Settable  Property            Value
> > > >
> > > >
> > -----------------------------------------------------------------------=
---------
> > > >             Name                wlan0
> > > >          *  Mode                ap
> > > >          *  Powered             on
> > > >             Address             b8:27:eb:28:18:48
> > > >             Adapter             phy0
> > > >
> > >
> > > I get these responses in the journal when I try to connect but it nev=
er
> > > connects:
> > >
> > > > src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
> > > > src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
> > > > src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
> > > >
> >
> > Did you try to run iwd with debug enabled 'iwd -d'? Maybe there is more
> > info. And if there isn't any clue, the best way forward is to get
> > nlmon running and provide the information the iwd developers. From what=
 I
> > see ConnMan is talking to iwd and setups the AP mode.
> >
> > > I currently use hostapd and dnsmasq to have this headless RPi audio
> > > appliance work as an AP for initial setup, but want to remove hostapd=
 and
> > > dnsmasq if I can get connman/iwd to do the same thing. I tried to get=
 iwd
> > > to go into ap mode and connect, but cannot do it there, either. I do =
get
> > > some messages at startup of iwd. I do not think these are the problem,
> > but
> > > they are missing kernel modules:
> > >
> > > No Diffie-Hellman support found, WPS will not be available
> > > > No asymmetric key support found.
> > > > TLS based WPA-Enterprise authentication methods will not function.
> > > > Kernel 4.20+ is required for this feature.
> > > > The following options are missing in the kernel:
> > > >         CONFIG_ASYMMETRIC_KEY_TYPE
> > > >         CONFIG_KEY_DH_OPERATIONS
> > > >         CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > > >         CONFIG_PKCS7_MESSAGE_PARSER
> > > >         CONFIG_X509_CERTIFICATE_PARSER
> > > >         CONFIG_PKCS8_PRIVATE_KEY_PARSER
> > > > Wireless daemon version 1.6
> >
> > I don't know but I would suggest to address this in the same go when you
> > build
> > a new kernel with nlmon support.
> >
> > Thanks,
> > Daniel
> >
--===============3385371810220565056==--

