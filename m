Content-Type: multipart/mixed; boundary="===============0214185843983038217=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: Wifi Tethering
Date: Tue, 05 May 2020 17:53:40 -0500
Message-ID: <CAG17S_MB31D12d4nmOu6pJd759AoSUjVCPnJiBHPAmh5V7H5qQ@mail.gmail.com>
In-Reply-To: <CAG17S_MG7iSYXW+YJb1xS03ZNp0m=XLyZr_6JdncOmnDMkeY=Q@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0214185843983038217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Daniel,

I am on Arch Linux on my Pi and the latest version of iwd just came out and
I tried this again. I get the same response. I cannot make a connection.
Something tells me that I am doing something very simple wrong.
Current iwd is 1.7 and connman is 1.38. I have built the kernel with the
iwmon module and more of the functions of iwd now show up correctly, now. I
do not know if it is because Arch finally went to 5.4 kernel from 4.19, but
anyway it does look different:

# journalctl | grep iwd
May 05 11:02:20 runeaudio iwd[253]: No Diffie-Hellman support found, WPS
will not be available
May 05 11:02:20 runeaudio iwd[253]: The following options are missing in
the kernel:
May 05 11:02:20 runeaudio iwd[253]:         CONFIG_KEY_DH_OPERATIONS
May 05 11:02:20 runeaudio iwd[253]: Wireless daemon version 1.7
May 05 11:02:20 runeaudio iwd[253]: netconfig: Network configuration is
disabled.
May 05 11:02:20 runeaudio iwd[253]: Wiphy: 0, Name: phy0
May 05 11:02:20 runeaudio iwd[253]:         Permanent Address:
b8:27:eb:28:18:48
May 05 11:02:20 runeaudio iwd[253]:         Bands: 2.4 GHz
May 05 11:02:20 runeaudio iwd[253]:         Ciphers: CCMP TKIP
May 05 11:02:20 runeaudio iwd[253]:         Supported iftypes: ad-hoc
station ap p2p-client p2p-go p2p-device
May 05 11:02:20 runeaudio iwd[253]: Wiphy phy0 will only use the default
interface
May 05 11:02:21 runeaudio iwd[253]: hardware_rekey not supported

When I type in the commands (either via connman or iwd) to enable AP mode,
all looks correct to me. I get the SSID to advertise. I can type in the
password, but Win10, linux and Android all refuse to connect to it.

Regards,

Keith



On Tue, Apr 28, 2020 at 7:33 AM KeithG <ys3al35l@gmail.com> wrote:

> Daniel,
>
> The pcap is here:
> https://drive.google.com/open?id=3D18G8cM5Ob88YENZ6WCWJjhBDREol7vW-9
>
> Regards,
>
> Keith
>
> On Tue, Apr 28, 2020 at 7:16 AM Daniel Wagner <wagi@monom.org> wrote:
>
>> [Cc: iwd mailing list]
>>
>> On Tue, Apr 28, 2020 at 06:45:25AM -0500, KeithG wrote:
>> > Daniel,
>> >
>> > I built the kernel/modules (I am on Arch on an RPi and the kernel I am
>> > using is 4.19.114) and tried to diagnose the ap mode problem with nlmon
>> and
>> > get this, though I am sure I am doing it wrong:
>> > # modprobe nlmon
>> > # ip link add name nlmon type nlmon
>> > # ip link set dev nlmon allmulticast on
>> > # ip link set dev nlmon up
>> > # tcpdump -i nlmon -w trace-file.pcap
>> > tcpdump: listening on nlmon, link-type NETLINK (Linux netlink), capture
>> > size 262144 bytes
>> > ^C158 packets captured
>> > 163 packets received by filter
>> > 0 packets dropped by kernel
>> > # iwmon -r trace-file.pcap
>> > Wireless monitor ver 1.6
>> > Invalid packet format
>>
>> Could you upload the pcap file somewhere? I suppose the iwd developers
>> might
>> be interested to inspect it.
>>
>> > In another window, I did this to see what was going on:
>> > ~# connmanctl tether wifi on myssid password
>> > Wifi SSID set
>> > Wifi passphrase set
>> > Enabled tethering for wifi
>> > # ip addr
>> > 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
>> group
>> > default qlen 1000
>> >     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>> >     inet 127.0.0.1/8 scope host lo
>> >        valid_lft forever preferred_lft forever
>> >     inet6 ::1/128 scope host
>> >        valid_lft forever preferred_lft forever
>> > 2: eth0: <BROADCAST,MULTICAST,DYNAMIC,UP,LOWER_UP> mtu 1500 qdisc
>> fq_codel
>> > state UP group default qlen 1000
>> >     link/ether a0:ce:c8:12:ed:05 brd ff:ff:ff:ff:ff:ff
>> >     inet 192.168.2.25/24 brd 192.168.2.255 scope global eth0
>> >        valid_lft forever preferred_lft forever
>> >     inet6 fe80::a2ce:c8ff:fe12:ed05/64 scope link
>> >        valid_lft forever preferred_lft forever
>> > 3: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
>> > fq_codel master tether state DORMANT group default qlen 1000
>> >     link/ether b8:27:eb:28:18:48 brd ff:ff:ff:ff:ff:ff
>> > 4: nlmon: <NOARP,ALLMULTI,UP,LOWER_UP> mtu 3904 qdisc noqueue state
>> UNKNOWN
>> > group default qlen 1000
>> >     link/netlink
>> > 5: tether: <NO-CARRIER,BROADCAST,MULTICAST,DYNAMIC,UP> mtu 1500 qdisc
>> > noqueue state DOWN group default qlen 1000
>> >     link/ether 9a:69:3a:48:c1:32 brd ff:ff:ff:ff:ff:ff
>> >     inet 192.168.0.1/24 brd 192.168.0.255 scope global tether
>> >        valid_lft forever preferred_lft forever
>> >     inet6 fe80::c20:faff:fec4:92b9/64 scope link
>> >        valid_lft forever preferred_lft forever
>> >
>> > I tried to connect to this AP with my Win10 laptop and get the respons=
e:
>> > "Can't connect to this network". My Arch Laptop likewise will not
>> connect.
>> >
>> > Now, when I run iwd -d, I get this:
>> > # /usr/lib/iwd/iwd -d
>> > No Diffie-Hellman support found, WPS will not be available
>> > No asymmetric key support found.
>> > TLS based WPA-Enterprise authentication methods will not function.
>> > Kernel 4.20+ is required for this feature.
>> > The following options are missing in the kernel:
>> >         CONFIG_ASYMMETRIC_KEY_TYPE
>> >         CONFIG_KEY_DH_OPERATIONS
>> >         CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>> >         CONFIG_PKCS7_MESSAGE_PARSER
>> >         CONFIG_X509_CERTIFICATE_PARSER
>> >         CONFIG_PKCS8_PRIVATE_KEY_PARSER
>> > Wireless daemon version 1.6
>> > src/main.c:main() Using configuration directory /etc/iwd
>> > src/storage.c:storage_create_dirs() Using state directory /var/lib/iwd
>> > src/main.c:nl80211_appeared() Found nl80211 interface
>> > src/module.c:iwd_modules_init()
>> > src/netdev.c:netdev_init() Opening route netlink socket
>> > netconfig: Network configuration is disabled.
>> > src/wsc.c:wsc_init()
>> > src/eap.c:__eap_method_enable()
>> > src/eap-wsc.c:eap_wsc_init()
>> > src/eap-md5.c:eap_md5_init()
>> > src/eap-tls.c:eap_tls_init()
>> > src/eap-ttls.c:eap_ttls_init()
>> > src/eap-mschapv2.c:eap_mschapv2_init()
>> > src/eap-sim.c:eap_sim_init()
>> > src/eap-aka.c:eap_aka_prime_init()
>> > src/eap-aka.c:eap_aka_init()
>> > src/eap-peap.c:eap_peap_init()
>> > src/eap-gtc.c:eap_gtc_init()
>> > src/eap-pwd.c:eap_pwd_init()
>> > plugins/sim_hardcoded.c:sim_hardcoded_init() IWD_SIM_KEYS not set in e=
nv
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/wiphy.c:parse_supported_bands()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/wiphy.c:parse_supported_bands()
>> > src/wiphy.c:parse_supported_frequencies()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/wiphy.c:parse_supported_bands()
>> > src/wiphy.c:parse_supported_frequencies()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/wiphy.c:parse_supported_bands()
>> > src/wiphy.c:parse_supported_frequencies()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/wiphy.c:parse_supported_bands()
>> > src/wiphy.c:parse_supported_frequencies()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/wiphy.c:parse_supported_bands()
>> > src/wiphy.c:parse_supported_frequencies()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/wiphy.c:parse_supported_bands()
>> > src/wiphy.c:parse_supported_frequencies()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/wiphy.c:parse_supported_bands()
>> > src/wiphy.c:parse_supported_frequencies()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/wiphy.c:parse_supported_bands()
>> > src/wiphy.c:parse_supported_frequencies()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/wiphy.c:parse_supported_bands()
>> > src/wiphy.c:parse_supported_frequencies()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/wiphy.c:parse_supported_bands()
>> > src/wiphy.c:parse_supported_frequencies()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/wiphy.c:parse_supported_bands()
>> > src/wiphy.c:parse_supported_frequencies()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/wiphy.c:parse_supported_bands()
>> > src/wiphy.c:parse_supported_frequencies()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/wiphy.c:parse_supported_bands()
>> > src/wiphy.c:parse_supported_frequencies()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/wiphy.c:parse_supported_bands()
>> > src/wiphy.c:parse_supported_frequencies()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/wiphy.c:parse_supported_bands()
>> > src/wiphy.c:parse_supported_frequencies()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/wiphy.c:parse_supported_bands()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/manager.c:manager_wiphy_dump_callback()
>> > src/wiphy.c:wiphy_update_from_genl()
>> > src/agent.c:agent_register() agent register called
>> > src/agent.c:agent_register() agent :1.7 path /net/connman/iwd_agent
>> > Wiphy: 0, Name: phy0
>> >         Permanent Address: b8:27:eb:28:18:48
>> >         Bands: 2.4 GHz
>> >         Ciphers: CCMP TKIP
>> >         Supported iftypes: ad-hoc station ap p2p-client p2p-go
>> p2p-device
>> > Wiphy phy0 will only use the default interface
>> > src/manager.c:manager_interface_dump_callback()
>> > src/manager.c:manager_get_interface_cb()
>> > src/manager.c:manager_use_default()
>> > src/netdev.c:netdev_create_from_genl() Created interface wlan0[3 1]
>> > src/netdev.c:netdev_link_notify() event 16 on ifindex 3
>> > src/netdev.c:netdev_set_4addr() netdev: 3 use_4addr: 0
>> > src/netdev.c:netdev_initial_up_cb() Interface 3 initialized
>> >
>> > strange thing is that most of those features are built in the kernel. =
My
>> > kernel is 4.19.114 and the config specifies:
>> > # CONFIG_CRYPTO_HW is not set
>> > CONFIG_ASYMMETRIC_KEY_TYPE=3Dy
>> > CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy
>> > CONFIG_X509_CERTIFICATE_PARSER=3Dy
>> > CONFIG_PKCS7_MESSAGE_PARSER=3Dy
>> > I am currently re-building the kernel with:
>> > CONFIG_KEY_DH_OPERATIONS=3Dy
>> > as it was previously not set.
>> > There does not seem to be any reference to PKCS8 for this kernel.
>> >
>> > Thanks!
>> >
>> > Keith
>> >
>> > On Mon, Apr 27, 2020 at 2:36 AM Daniel Wagner <wagi@monom.org> wrote:
>> >
>> > > On Sat, Apr 25, 2020 at 11:20:45AM -0500, KeithG wrote:
>> > > > I looked at the IWD readme and cannot enable this on the RPi:
>> > > >
>> > > > # ip link set dev nlmon allmulticast on
>> > > > > Cannot find device "nlmon"
>> > >
>> > > The RPi kernel has no support for nlmon enabled. If you want to debug
>> this
>> > > you
>> > > propably need to compile your own RPi kernel with nlmon enabled.
>> > >
>> > > > I did verify a couple things. I do have iwd set explicitly when I
>> start
>> > > > connman
>> > > >  /usr/bin/connmand --wifi=3Diwd_agent -n --nodnsproxy
>> > >
>> > > --wifi=3Diwd_agent is wrong. If you want iwd support you need to def=
ine
>> this
>> > > at compile time only:
>> > >
>> > >    ./configure --enable-iwd --disable-wifi
>> > >
>> > > which adds the iwd plugin and disables the wpa_supplicant plugin. But
>> I
>> > > don't
>> > > think it matter. --iwfi-iwd_agent will be ignored and ConnMan will
>> > > dynamically
>> > > discover iwd. Just make sure wpa_supplicant is not running. With the
>> above
>> > > command line you would make sure wpa_supplicant is not accidentally
>> used.
>> > >
>> > > > When I issue the command from connman, the mode changes in iwd:
>> > > >
>> > > > > # connmanctl tether wifi on myssid password
>> > > > > Wifi SSID set
>> > > > > Wifi passphrase set
>> > > > > Enabled tethering for wifi
>> > > > > # ip addr
>> > > > > 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state
>> UNKNOWN
>> > > group
>> > > > > default qlen 1000
>> > > > >     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>> > > > >     inet 127.0.0.1/8 scope host lo
>> > > > >        valid_lft forever preferred_lft forever
>> > > > >     inet6 ::1/128 scope host
>> > > > >        valid_lft forever preferred_lft forever
>> > > > > 2: eth0: <BROADCAST,MULTICAST,DYNAMIC,UP,LOWER_UP> mtu 1500 qdisc
>> > > fq_codel
>> > > > > state UP group default qlen 1000
>> > > > >     link/ether a0:ce:c8:12:ed:05 brd ff:ff:ff:ff:ff:ff
>> > > > >     inet 192.168.2.25/24 brd 192.168.2.255 scope global eth0
>> > > > >        valid_lft forever preferred_lft forever
>> > > > >     inet6 fe80::a2ce:c8ff:fe12:ed05/64 scope link
>> > > > >        valid_lft forever preferred_lft forever
>> > > > > 3: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
>> qdisc
>> > > > > fq_codel master tether state DORMANT group default qlen 1000
>> > > > >     link/ether b8:27:eb:28:18:48 brd ff:ff:ff:ff:ff:ff
>> > > > > 4: tether: <NO-CARRIER,BROADCAST,MULTICAST,DYNAMIC,UP> mtu 1500
>> qdisc
>> > > > > noqueue state DOWN group default qlen 1000
>> > > > >     link/ether 9a:69:3a:48:c1:32 brd ff:ff:ff:ff:ff:ff
>> > > > >     inet 192.168.0.1/24 brd 192.168.0.255 scope global tether
>> > > > >        valid_lft forever preferred_lft forever
>> > > > >     inet6 fe80::d024:5eff:fe80:1a57/64 scope link
>> > > > >        valid_lft forever preferred_lft forever
>> > > > > # iwctl device wlan0 show
>> > > > >                                  Device: wlan0
>> > > > >
>> > > > >
>> > >
>> ------------------------------------------------------------------------=
--------
>> > > > >   Settable  Property            Value
>> > > > >
>> > > > >
>> > >
>> ------------------------------------------------------------------------=
--------
>> > > > >             Name                wlan0
>> > > > >          *  Mode                ap
>> > > > >          *  Powered             on
>> > > > >             Address             b8:27:eb:28:18:48
>> > > > >             Adapter             phy0
>> > > > >
>> > > >
>> > > > I get these responses in the journal when I try to connect but it
>> never
>> > > > connects:
>> > > >
>> > > > > src/netdev.c:netdev_mlme_notify() MLME notification New
>> Station(19)
>> > > > > src/netdev.c:netdev_mlme_notify() MLME notification Del
>> Station(20)
>> > > > > src/netdev.c:netdev_mlme_notify() MLME notification Del
>> Station(20)
>> > > > >
>> > >
>> > > Did you try to run iwd with debug enabled 'iwd -d'? Maybe there is
>> more
>> > > info. And if there isn't any clue, the best way forward is to get
>> > > nlmon running and provide the information the iwd developers. From
>> what I
>> > > see ConnMan is talking to iwd and setups the AP mode.
>> > >
>> > > > I currently use hostapd and dnsmasq to have this headless RPi audio
>> > > > appliance work as an AP for initial setup, but want to remove
>> hostapd and
>> > > > dnsmasq if I can get connman/iwd to do the same thing. I tried to
>> get iwd
>> > > > to go into ap mode and connect, but cannot do it there, either. I
>> do get
>> > > > some messages at startup of iwd. I do not think these are the
>> problem,
>> > > but
>> > > > they are missing kernel modules:
>> > > >
>> > > > No Diffie-Hellman support found, WPS will not be available
>> > > > > No asymmetric key support found.
>> > > > > TLS based WPA-Enterprise authentication methods will not functio=
n.
>> > > > > Kernel 4.20+ is required for this feature.
>> > > > > The following options are missing in the kernel:
>> > > > >         CONFIG_ASYMMETRIC_KEY_TYPE
>> > > > >         CONFIG_KEY_DH_OPERATIONS
>> > > > >         CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>> > > > >         CONFIG_PKCS7_MESSAGE_PARSER
>> > > > >         CONFIG_X509_CERTIFICATE_PARSER
>> > > > >         CONFIG_PKCS8_PRIVATE_KEY_PARSER
>> > > > > Wireless daemon version 1.6
>> > >
>> > > I don't know but I would suggest to address this in the same go when
>> you
>> > > build
>> > > a new kernel with nlmon support.
>> > >
>> > > Thanks,
>> > > Daniel
>> > >
>>
>

--===============0214185843983038217==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5EYW5pZWwsPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGFt
IG9uIEFyY2ggTGludXggb24gbXkgUGkgYW5kIHRoZSBsYXRlc3QgdmVyc2lvbiBvZiBpd2QganVz
dCBjYW1lIG91dCBhbmQgSSB0cmllZCB0aGlzIGFnYWluLiBJIGdldCB0aGUgc2FtZSByZXNwb25z
ZS4gSSBjYW5ub3QgbWFrZSBhIGNvbm5lY3Rpb24uIFNvbWV0aGluZyB0ZWxscyBtZSB0aGF0IEkg
YW0gZG9pbmcgc29tZXRoaW5nIHZlcnkgc2ltcGxlIHdyb25nLiA8YnI+PC9kaXY+PGRpdj5DdXJy
ZW50IGl3ZCBpcyAxLjcgYW5kIGNvbm5tYW4gaXMgMS4zOC4gSSBoYXZlIGJ1aWx0IHRoZSBrZXJu
ZWwgd2l0aCB0aGUgaXdtb24gbW9kdWxlIGFuZCBtb3JlIG9mIHRoZSBmdW5jdGlvbnMgb2YgaXdk
IG5vdyBzaG93IHVwIGNvcnJlY3RseSwgbm93LiBJIGRvIG5vdCBrbm93IGlmIGl0IGlzIGJlY2F1
c2UgQXJjaCBmaW5hbGx5IHdlbnQgdG8gNS40IGtlcm5lbCBmcm9tIDQuMTksIGJ1dCBhbnl3YXkg
aXQgZG9lcyBsb29rIGRpZmZlcmVudDo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PiMgam91cm5h
bGN0bCB8IGdyZXAgaXdkPGJyPk1heSAwNSAxMTowMjoyMCBydW5lYXVkaW8gaXdkWzI1M106IE5v
IERpZmZpZS1IZWxsbWFuIHN1cHBvcnQgZm91bmQsIFdQUyB3aWxsIG5vdCBiZSBhdmFpbGFibGU8
YnI+TWF5IDA1IDExOjAyOjIwIHJ1bmVhdWRpbyBpd2RbMjUzXTogVGhlIGZvbGxvd2luZyBvcHRp
b25zIGFyZSBtaXNzaW5nIGluIHRoZSBrZXJuZWw6PGJyPk1heSAwNSAxMTowMjoyMCBydW5lYXVk
aW8gaXdkWzI1M106IMKgIMKgIMKgIMKgIENPTkZJR19LRVlfREhfT1BFUkFUSU9OUzxicj5NYXkg
MDUgMTE6MDI6MjAgcnVuZWF1ZGlvIGl3ZFsyNTNdOiBXaXJlbGVzcyBkYWVtb24gdmVyc2lvbiAx
Ljc8YnI+TWF5IDA1IDExOjAyOjIwIHJ1bmVhdWRpbyBpd2RbMjUzXTogbmV0Y29uZmlnOiBOZXR3
b3JrIGNvbmZpZ3VyYXRpb24gaXMgZGlzYWJsZWQuPGJyPk1heSAwNSAxMTowMjoyMCBydW5lYXVk
aW8gaXdkWzI1M106IFdpcGh5OiAwLCBOYW1lOiBwaHkwPGJyPk1heSAwNSAxMTowMjoyMCBydW5l
YXVkaW8gaXdkWzI1M106IMKgIMKgIMKgIMKgIFBlcm1hbmVudCBBZGRyZXNzOiBiODoyNzplYjoy
ODoxODo0ODxicj5NYXkgMDUgMTE6MDI6MjAgcnVuZWF1ZGlvIGl3ZFsyNTNdOiDCoCDCoCDCoCDC
oCBCYW5kczogMi40IEdIejxicj5NYXkgMDUgMTE6MDI6MjAgcnVuZWF1ZGlvIGl3ZFsyNTNdOiDC
oCDCoCDCoCDCoCBDaXBoZXJzOiBDQ01QIFRLSVA8YnI+TWF5IDA1IDExOjAyOjIwIHJ1bmVhdWRp
byBpd2RbMjUzXTogwqAgwqAgwqAgwqAgU3VwcG9ydGVkIGlmdHlwZXM6IGFkLWhvYyBzdGF0aW9u
IGFwIHAycC1jbGllbnQgcDJwLWdvIHAycC1kZXZpY2U8YnI+TWF5IDA1IDExOjAyOjIwIHJ1bmVh
dWRpbyBpd2RbMjUzXTogV2lwaHkgcGh5MCB3aWxsIG9ubHkgdXNlIHRoZSBkZWZhdWx0IGludGVy
ZmFjZTxicj5NYXkgMDUgMTE6MDI6MjEgcnVuZWF1ZGlvIGl3ZFsyNTNdOiBoYXJkd2FyZV9yZWtl
eSBub3Qgc3VwcG9ydGVkPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5XaGVuIEkgdHlwZSBpbiB0
aGUgY29tbWFuZHMgKGVpdGhlciB2aWEgY29ubm1hbiBvciBpd2QpIHRvIGVuYWJsZSBBUCBtb2Rl
LCBhbGwgbG9va3MgY29ycmVjdCB0byBtZS4gSSBnZXQgdGhlIFNTSUQgdG8gYWR2ZXJ0aXNlLiBJ
IGNhbiB0eXBlIGluIHRoZSBwYXNzd29yZCwgYnV0IFdpbjEwLCBsaW51eCBhbmQgQW5kcm9pZCBh
bGwgcmVmdXNlIHRvIGNvbm5lY3QgdG8gaXQuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5SZWdh
cmRzLDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+S2VpdGg8YnI+PC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2
IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gVHVlLCBBcHIgMjgsIDIwMjAgYXQgNzoz
MyBBTSBLZWl0aEcgJmx0OzxhIGhyZWY9Im1haWx0bzp5czNhbDM1bEBnbWFpbC5jb20iPnlzM2Fs
MzVsQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0i
Z21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6
MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0
ciI+PGRpdj5EYW5pZWwsPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGUgcGNhcCBpcyBoZXJl
OjwvZGl2PjxkaXY+PGEgaHJlZj0iaHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL29wZW4/aWQ9MThH
OGNNNU9iODhZRU5aNldDV0pqaEJEUkVvbDd2Vy05IiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9k
cml2ZS5nb29nbGUuY29tL29wZW4/aWQ9MThHOGNNNU9iODhZRU5aNldDV0pqaEJEUkVvbDd2Vy05
PC9hPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UmVnYXJkcyw8L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PktlaXRoPGJyPjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+
PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFR1ZSwgQXByIDI4LCAyMDIwIGF0
IDc6MTYgQU0gRGFuaWVsIFdhZ25lciAmbHQ7PGEgaHJlZj0ibWFpbHRvOndhZ2lAbW9ub20ub3Jn
IiB0YXJnZXQ9Il9ibGFuayI+d2FnaUBtb25vbS5vcmc8L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+
PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4
IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVm
dDoxZXgiPltDYzogaXdkIG1haWxpbmcgbGlzdF08YnI+Cjxicj4KT24gVHVlLCBBcHIgMjgsIDIw
MjAgYXQgMDY6NDU6MjVBTSAtMDUwMCwgS2VpdGhHIHdyb3RlOjxicj4KJmd0OyBEYW5pZWwsPGJy
PgomZ3Q7IDxicj4KJmd0OyBJIGJ1aWx0IHRoZSBrZXJuZWwvbW9kdWxlcyAoSSBhbSBvbiBBcmNo
IG9uIGFuIFJQaSBhbmQgdGhlIGtlcm5lbCBJIGFtPGJyPgomZ3Q7IHVzaW5nIGlzIDQuMTkuMTE0
KSBhbmQgdHJpZWQgdG8gZGlhZ25vc2UgdGhlIGFwIG1vZGUgcHJvYmxlbSB3aXRoIG5sbW9uIGFu
ZDxicj4KJmd0OyBnZXQgdGhpcywgdGhvdWdoIEkgYW0gc3VyZSBJIGFtIGRvaW5nIGl0IHdyb25n
Ojxicj4KJmd0OyAjIG1vZHByb2JlIG5sbW9uPGJyPgomZ3Q7ICMgaXAgbGluayBhZGQgbmFtZSBu
bG1vbiB0eXBlIG5sbW9uPGJyPgomZ3Q7ICMgaXAgbGluayBzZXQgZGV2IG5sbW9uIGFsbG11bHRp
Y2FzdCBvbjxicj4KJmd0OyAjIGlwIGxpbmsgc2V0IGRldiBubG1vbiB1cDxicj4KJmd0OyAjIHRj
cGR1bXAgLWkgbmxtb24gLXcgdHJhY2UtZmlsZS5wY2FwPGJyPgomZ3Q7IHRjcGR1bXA6IGxpc3Rl
bmluZyBvbiBubG1vbiwgbGluay10eXBlIE5FVExJTksgKExpbnV4IG5ldGxpbmspLCBjYXB0dXJl
PGJyPgomZ3Q7IHNpemUgMjYyMTQ0IGJ5dGVzPGJyPgomZ3Q7IF5DMTU4IHBhY2tldHMgY2FwdHVy
ZWQ8YnI+CiZndDsgMTYzIHBhY2tldHMgcmVjZWl2ZWQgYnkgZmlsdGVyPGJyPgomZ3Q7IDAgcGFj
a2V0cyBkcm9wcGVkIGJ5IGtlcm5lbDxicj4KJmd0OyAjIGl3bW9uIC1yIHRyYWNlLWZpbGUucGNh
cDxicj4KJmd0OyBXaXJlbGVzcyBtb25pdG9yIHZlciAxLjY8YnI+CiZndDsgSW52YWxpZCBwYWNr
ZXQgZm9ybWF0PGJyPgo8YnI+CkNvdWxkIHlvdSB1cGxvYWQgdGhlIHBjYXAgZmlsZSBzb21ld2hl
cmU/IEkgc3VwcG9zZSB0aGUgaXdkIGRldmVsb3BlcnMgbWlnaHQ8YnI+CmJlIGludGVyZXN0ZWQg
dG8gaW5zcGVjdCBpdC48YnI+Cjxicj4KJmd0OyBJbiBhbm90aGVyIHdpbmRvdywgSSBkaWQgdGhp
cyB0byBzZWUgd2hhdCB3YXMgZ29pbmcgb246PGJyPgomZ3Q7IH4jIGNvbm5tYW5jdGwgdGV0aGVy
IHdpZmkgb24gbXlzc2lkIHBhc3N3b3JkPGJyPgomZ3Q7IFdpZmkgU1NJRCBzZXQ8YnI+CiZndDsg
V2lmaSBwYXNzcGhyYXNlIHNldDxicj4KJmd0OyBFbmFibGVkIHRldGhlcmluZyBmb3Igd2lmaTxi
cj4KJmd0OyAjIGlwIGFkZHI8YnI+CiZndDsgMTogbG86ICZsdDtMT09QQkFDSyxVUCxMT1dFUl9V
UCZndDsgbXR1IDY1NTM2IHFkaXNjIG5vcXVldWUgc3RhdGUgVU5LTk9XTiBncm91cDxicj4KJmd0
OyBkZWZhdWx0IHFsZW4gMTAwMDxicj4KJmd0O8KgIMKgIMKgbGluay9sb29wYmFjayAwMDowMDow
MDowMDowMDowMCBicmQgMDA6MDA6MDA6MDA6MDA6MDA8YnI+CiZndDvCoCDCoCDCoGluZXQgPGEg
aHJlZj0iaHR0cDovLzEyNy4wLjAuMS84IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5r
Ij4xMjcuMC4wLjEvODwvYT4gc2NvcGUgaG9zdCBsbzxicj4KJmd0O8KgIMKgIMKgIMKgIHZhbGlk
X2xmdCBmb3JldmVyIHByZWZlcnJlZF9sZnQgZm9yZXZlcjxicj4KJmd0O8KgIMKgIMKgaW5ldDYg
OjoxLzEyOCBzY29wZSBob3N0PGJyPgomZ3Q7wqAgwqAgwqAgwqAgdmFsaWRfbGZ0IGZvcmV2ZXIg
cHJlZmVycmVkX2xmdCBmb3JldmVyPGJyPgomZ3Q7IDI6IGV0aDA6ICZsdDtCUk9BRENBU1QsTVVM
VElDQVNULERZTkFNSUMsVVAsTE9XRVJfVVAmZ3Q7IG10dSAxNTAwIHFkaXNjIGZxX2NvZGVsPGJy
PgomZ3Q7IHN0YXRlIFVQIGdyb3VwIGRlZmF1bHQgcWxlbiAxMDAwPGJyPgomZ3Q7wqAgwqAgwqBs
aW5rL2V0aGVyIGEwOmNlOmM4OjEyOmVkOjA1IGJyZCBmZjpmZjpmZjpmZjpmZjpmZjxicj4KJmd0
O8KgIMKgIMKgaW5ldCA8YSBocmVmPSJodHRwOi8vMTkyLjE2OC4yLjI1LzI0IiByZWw9Im5vcmVm
ZXJyZXIiIHRhcmdldD0iX2JsYW5rIj4xOTIuMTY4LjIuMjUvMjQ8L2E+IGJyZCAxOTIuMTY4LjIu
MjU1IHNjb3BlIGdsb2JhbCBldGgwPGJyPgomZ3Q7wqAgwqAgwqAgwqAgdmFsaWRfbGZ0IGZvcmV2
ZXIgcHJlZmVycmVkX2xmdCBmb3JldmVyPGJyPgomZ3Q7wqAgwqAgwqBpbmV0NiBmZTgwOjphMmNl
OmM4ZmY6ZmUxMjplZDA1LzY0IHNjb3BlIGxpbms8YnI+CiZndDvCoCDCoCDCoCDCoCB2YWxpZF9s
ZnQgZm9yZXZlciBwcmVmZXJyZWRfbGZ0IGZvcmV2ZXI8YnI+CiZndDsgMzogd2xhbjA6ICZsdDtO
Ty1DQVJSSUVSLEJST0FEQ0FTVCxNVUxUSUNBU1QsVVAsTE9XRVJfVVAmZ3Q7IG10dSAxNTAwIHFk
aXNjPGJyPgomZ3Q7IGZxX2NvZGVsIG1hc3RlciB0ZXRoZXIgc3RhdGUgRE9STUFOVCBncm91cCBk
ZWZhdWx0IHFsZW4gMTAwMDxicj4KJmd0O8KgIMKgIMKgbGluay9ldGhlciBiODoyNzplYjoyODox
ODo0OCBicmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmY8YnI+CiZndDsgNDogbmxtb246ICZsdDtOT0FSUCxB
TExNVUxUSSxVUCxMT1dFUl9VUCZndDsgbXR1IDM5MDQgcWRpc2Mgbm9xdWV1ZSBzdGF0ZSBVTktO
T1dOPGJyPgomZ3Q7IGdyb3VwIGRlZmF1bHQgcWxlbiAxMDAwPGJyPgomZ3Q7wqAgwqAgwqBsaW5r
L25ldGxpbms8YnI+CiZndDsgNTogdGV0aGVyOiAmbHQ7Tk8tQ0FSUklFUixCUk9BRENBU1QsTVVM
VElDQVNULERZTkFNSUMsVVAmZ3Q7IG10dSAxNTAwIHFkaXNjPGJyPgomZ3Q7IG5vcXVldWUgc3Rh
dGUgRE9XTiBncm91cCBkZWZhdWx0IHFsZW4gMTAwMDxicj4KJmd0O8KgIMKgIMKgbGluay9ldGhl
ciA5YTo2OTozYTo0ODpjMTozMiBicmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmY8YnI+CiZndDvCoCDCoCDC
oGluZXQgPGEgaHJlZj0iaHR0cDovLzE5Mi4xNjguMC4xLzI0IiByZWw9Im5vcmVmZXJyZXIiIHRh
cmdldD0iX2JsYW5rIj4xOTIuMTY4LjAuMS8yNDwvYT4gYnJkIDE5Mi4xNjguMC4yNTUgc2NvcGUg
Z2xvYmFsIHRldGhlcjxicj4KJmd0O8KgIMKgIMKgIMKgIHZhbGlkX2xmdCBmb3JldmVyIHByZWZl
cnJlZF9sZnQgZm9yZXZlcjxicj4KJmd0O8KgIMKgIMKgaW5ldDYgZmU4MDo6YzIwOmZhZmY6ZmVj
NDo5MmI5LzY0IHNjb3BlIGxpbms8YnI+CiZndDvCoCDCoCDCoCDCoCB2YWxpZF9sZnQgZm9yZXZl
ciBwcmVmZXJyZWRfbGZ0IGZvcmV2ZXI8YnI+CiZndDsgPGJyPgomZ3Q7IEkgdHJpZWQgdG8gY29u
bmVjdCB0byB0aGlzIEFQIHdpdGggbXkgV2luMTAgbGFwdG9wIGFuZCBnZXQgdGhlIHJlc3BvbnNl
Ojxicj4KJmd0OyAmcXVvdDtDYW4mIzM5O3QgY29ubmVjdCB0byB0aGlzIG5ldHdvcmsmcXVvdDsu
IE15IEFyY2ggTGFwdG9wIGxpa2V3aXNlIHdpbGwgbm90IGNvbm5lY3QuPGJyPgomZ3Q7IDxicj4K
Jmd0OyBOb3csIHdoZW4gSSBydW4gaXdkIC1kLCBJIGdldCB0aGlzOjxicj4KJmd0OyAjIC91c3Iv
bGliL2l3ZC9pd2QgLWQ8YnI+CiZndDsgTm8gRGlmZmllLUhlbGxtYW4gc3VwcG9ydCBmb3VuZCwg
V1BTIHdpbGwgbm90IGJlIGF2YWlsYWJsZTxicj4KJmd0OyBObyBhc3ltbWV0cmljIGtleSBzdXBw
b3J0IGZvdW5kLjxicj4KJmd0OyBUTFMgYmFzZWQgV1BBLUVudGVycHJpc2UgYXV0aGVudGljYXRp
b24gbWV0aG9kcyB3aWxsIG5vdCBmdW5jdGlvbi48YnI+CiZndDsgS2VybmVsIDQuMjArIGlzIHJl
cXVpcmVkIGZvciB0aGlzIGZlYXR1cmUuPGJyPgomZ3Q7IFRoZSBmb2xsb3dpbmcgb3B0aW9ucyBh
cmUgbWlzc2luZyBpbiB0aGUga2VybmVsOjxicj4KJmd0O8KgIMKgIMKgIMKgIMKgQ09ORklHX0FT
WU1NRVRSSUNfS0VZX1RZUEU8YnI+CiZndDvCoCDCoCDCoCDCoCDCoENPTkZJR19LRVlfREhfT1BF
UkFUSU9OUzxicj4KJmd0O8KgIMKgIMKgIMKgIMKgQ09ORklHX0FTWU1NRVRSSUNfUFVCTElDX0tF
WV9TVUJUWVBFPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqBDT05GSUdfUEtDUzdfTUVTU0FHRV9QQVJT
RVI8YnI+CiZndDvCoCDCoCDCoCDCoCDCoENPTkZJR19YNTA5X0NFUlRJRklDQVRFX1BBUlNFUjxi
cj4KJmd0O8KgIMKgIMKgIMKgIMKgQ09ORklHX1BLQ1M4X1BSSVZBVEVfS0VZX1BBUlNFUjxicj4K
Jmd0OyBXaXJlbGVzcyBkYWVtb24gdmVyc2lvbiAxLjY8YnI+CiZndDsgc3JjL21haW4uYzptYWlu
KCkgVXNpbmcgY29uZmlndXJhdGlvbiBkaXJlY3RvcnkgL2V0Yy9pd2Q8YnI+CiZndDsgc3JjL3N0
b3JhZ2UuYzpzdG9yYWdlX2NyZWF0ZV9kaXJzKCkgVXNpbmcgc3RhdGUgZGlyZWN0b3J5IC92YXIv
bGliL2l3ZDxicj4KJmd0OyBzcmMvbWFpbi5jOm5sODAyMTFfYXBwZWFyZWQoKSBGb3VuZCBubDgw
MjExIGludGVyZmFjZTxicj4KJmd0OyBzcmMvbW9kdWxlLmM6aXdkX21vZHVsZXNfaW5pdCgpPGJy
PgomZ3Q7IHNyYy9uZXRkZXYuYzpuZXRkZXZfaW5pdCgpIE9wZW5pbmcgcm91dGUgbmV0bGluayBz
b2NrZXQ8YnI+CiZndDsgbmV0Y29uZmlnOiBOZXR3b3JrIGNvbmZpZ3VyYXRpb24gaXMgZGlzYWJs
ZWQuPGJyPgomZ3Q7IHNyYy93c2MuYzp3c2NfaW5pdCgpPGJyPgomZ3Q7IHNyYy9lYXAuYzpfX2Vh
cF9tZXRob2RfZW5hYmxlKCk8YnI+CiZndDsgc3JjL2VhcC13c2MuYzplYXBfd3NjX2luaXQoKTxi
cj4KJmd0OyBzcmMvZWFwLW1kNS5jOmVhcF9tZDVfaW5pdCgpPGJyPgomZ3Q7IHNyYy9lYXAtdGxz
LmM6ZWFwX3Rsc19pbml0KCk8YnI+CiZndDsgc3JjL2VhcC10dGxzLmM6ZWFwX3R0bHNfaW5pdCgp
PGJyPgomZ3Q7IHNyYy9lYXAtbXNjaGFwdjIuYzplYXBfbXNjaGFwdjJfaW5pdCgpPGJyPgomZ3Q7
IHNyYy9lYXAtc2ltLmM6ZWFwX3NpbV9pbml0KCk8YnI+CiZndDsgc3JjL2VhcC1ha2EuYzplYXBf
YWthX3ByaW1lX2luaXQoKTxicj4KJmd0OyBzcmMvZWFwLWFrYS5jOmVhcF9ha2FfaW5pdCgpPGJy
PgomZ3Q7IHNyYy9lYXAtcGVhcC5jOmVhcF9wZWFwX2luaXQoKTxicj4KJmd0OyBzcmMvZWFwLWd0
Yy5jOmVhcF9ndGNfaW5pdCgpPGJyPgomZ3Q7IHNyYy9lYXAtcHdkLmM6ZWFwX3B3ZF9pbml0KCk8
YnI+CiZndDsgcGx1Z2lucy9zaW1faGFyZGNvZGVkLmM6c2ltX2hhcmRjb2RlZF9pbml0KCkgSVdE
X1NJTV9LRVlTIG5vdCBzZXQgaW4gZW52PGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93
aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zy
b21fZ2VubCgpPGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxi
YWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgom
Z3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZndDsg
c3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNyYy9tYW5hZ2Vy
LmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lw
aHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRl
ZF9iYW5kcygpPGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxi
YWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgom
Z3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9iYW5kcygpPGJyPgomZ3Q7IHNyYy93aXBo
eS5jOnBhcnNlX3N1cHBvcnRlZF9mcmVxdWVuY2llcygpPGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6
bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlf
dXBkYXRlX2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9i
YW5kcygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9mcmVxdWVuY2llcygp
PGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+
CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNyYy93
aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9iYW5kcygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNl
X3N1cHBvcnRlZF9mcmVxdWVuY2llcygpPGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93
aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zy
b21fZ2VubCgpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9iYW5kcygpPGJy
PgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9mcmVxdWVuY2llcygpPGJyPgomZ3Q7
IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZndDsgc3Jj
L3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBh
cnNlX3N1cHBvcnRlZF9iYW5kcygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRl
ZF9mcmVxdWVuY2llcygpPGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93aXBoeV9kdW1w
X2NhbGxiYWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgp
PGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9iYW5kcygpPGJyPgomZ3Q7IHNy
Yy93aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9mcmVxdWVuY2llcygpPGJyPgomZ3Q7IHNyYy9tYW5h
Z2VyLmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6
d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBv
cnRlZF9iYW5kcygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9mcmVxdWVu
Y2llcygpPGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxiYWNr
KCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgomZ3Q7
IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9iYW5kcygpPGJyPgomZ3Q7IHNyYy93aXBoeS5j
OnBhcnNlX3N1cHBvcnRlZF9mcmVxdWVuY2llcygpPGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFu
YWdlcl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBk
YXRlX2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9iYW5k
cygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9mcmVxdWVuY2llcygpPGJy
PgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZn
dDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNyYy93aXBo
eS5jOnBhcnNlX3N1cHBvcnRlZF9iYW5kcygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1
cHBvcnRlZF9mcmVxdWVuY2llcygpPGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93aXBo
eV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zyb21f
Z2VubCgpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9iYW5kcygpPGJyPgom
Z3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9mcmVxdWVuY2llcygpPGJyPgomZ3Q7IHNy
Yy9tYW5hZ2VyLmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZndDsgc3JjL3dp
cGh5LmM6d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNl
X3N1cHBvcnRlZF9iYW5kcygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9m
cmVxdWVuY2llcygpPGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93aXBoeV9kdW1wX2Nh
bGxiYWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJy
PgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9iYW5kcygpPGJyPgomZ3Q7IHNyYy93
aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9mcmVxdWVuY2llcygpPGJyPgomZ3Q7IHNyYy9tYW5hZ2Vy
LmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lw
aHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRl
ZF9iYW5kcygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9mcmVxdWVuY2ll
cygpPGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8
YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNy
Yy93aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9iYW5kcygpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBh
cnNlX3N1cHBvcnRlZF9mcmVxdWVuY2llcygpPGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdl
cl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRl
X2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOnBhcnNlX3N1cHBvcnRlZF9iYW5kcygp
PGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+
CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNyYy9t
YW5hZ2VyLmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5
LmM6d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdl
cl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRl
X2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93aXBoeV9kdW1wX2Nh
bGxiYWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJy
PgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZn
dDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNyYy9tYW5h
Z2VyLmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6
d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93
aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zy
b21fZ2VubCgpPGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxi
YWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgom
Z3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZndDsg
c3JjL3dpcGh5LmM6d2lwaHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNyYy9tYW5hZ2Vy
LmM6bWFuYWdlcl93aXBoeV9kdW1wX2NhbGxiYWNrKCk8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lw
aHlfdXBkYXRlX2Zyb21fZ2VubCgpPGJyPgomZ3Q7IHNyYy9hZ2VudC5jOmFnZW50X3JlZ2lzdGVy
KCkgYWdlbnQgcmVnaXN0ZXIgY2FsbGVkPGJyPgomZ3Q7IHNyYy9hZ2VudC5jOmFnZW50X3JlZ2lz
dGVyKCkgYWdlbnQgOjEuNyBwYXRoIC9uZXQvY29ubm1hbi9pd2RfYWdlbnQ8YnI+CiZndDsgV2lw
aHk6IDAsIE5hbWU6IHBoeTA8YnI+CiZndDvCoCDCoCDCoCDCoCDCoFBlcm1hbmVudCBBZGRyZXNz
OiBiODoyNzplYjoyODoxODo0ODxicj4KJmd0O8KgIMKgIMKgIMKgIMKgQmFuZHM6IDIuNCBHSHo8
YnI+CiZndDvCoCDCoCDCoCDCoCDCoENpcGhlcnM6IENDTVAgVEtJUDxicj4KJmd0O8KgIMKgIMKg
IMKgIMKgU3VwcG9ydGVkIGlmdHlwZXM6IGFkLWhvYyBzdGF0aW9uIGFwIHAycC1jbGllbnQgcDJw
LWdvIHAycC1kZXZpY2U8YnI+CiZndDsgV2lwaHkgcGh5MCB3aWxsIG9ubHkgdXNlIHRoZSBkZWZh
dWx0IGludGVyZmFjZTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfaW50ZXJmYWNlX2R1
bXBfY2FsbGJhY2soKTxicj4KJmd0OyBzcmMvbWFuYWdlci5jOm1hbmFnZXJfZ2V0X2ludGVyZmFj
ZV9jYigpPGJyPgomZ3Q7IHNyYy9tYW5hZ2VyLmM6bWFuYWdlcl91c2VfZGVmYXVsdCgpPGJyPgom
Z3Q7IHNyYy9uZXRkZXYuYzpuZXRkZXZfY3JlYXRlX2Zyb21fZ2VubCgpIENyZWF0ZWQgaW50ZXJm
YWNlIHdsYW4wWzMgMV08YnI+CiZndDsgc3JjL25ldGRldi5jOm5ldGRldl9saW5rX25vdGlmeSgp
IGV2ZW50IDE2IG9uIGlmaW5kZXggMzxicj4KJmd0OyBzcmMvbmV0ZGV2LmM6bmV0ZGV2X3NldF80
YWRkcigpIG5ldGRldjogMyB1c2VfNGFkZHI6IDA8YnI+CiZndDsgc3JjL25ldGRldi5jOm5ldGRl
dl9pbml0aWFsX3VwX2NiKCkgSW50ZXJmYWNlIDMgaW5pdGlhbGl6ZWQ8YnI+CiZndDsgPGJyPgom
Z3Q7IHN0cmFuZ2UgdGhpbmcgaXMgdGhhdCBtb3N0IG9mIHRob3NlIGZlYXR1cmVzIGFyZSBidWls
dCBpbiB0aGUga2VybmVsLiBNeTxicj4KJmd0OyBrZXJuZWwgaXMgNC4xOS4xMTQgYW5kIHRoZSBj
b25maWcgc3BlY2lmaWVzOjxicj4KJmd0OyAjIENPTkZJR19DUllQVE9fSFcgaXMgbm90IHNldDxi
cj4KJmd0OyBDT05GSUdfQVNZTU1FVFJJQ19LRVlfVFlQRT15PGJyPgomZ3Q7IENPTkZJR19BU1lN
TUVUUklDX1BVQkxJQ19LRVlfU1VCVFlQRT15PGJyPgomZ3Q7IENPTkZJR19YNTA5X0NFUlRJRklD
QVRFX1BBUlNFUj15PGJyPgomZ3Q7IENPTkZJR19QS0NTN19NRVNTQUdFX1BBUlNFUj15PGJyPgom
Z3Q7IEkgYW0gY3VycmVudGx5IHJlLWJ1aWxkaW5nIHRoZSBrZXJuZWwgd2l0aDo8YnI+CiZndDsg
Q09ORklHX0tFWV9ESF9PUEVSQVRJT05TPXk8YnI+CiZndDsgYXMgaXQgd2FzIHByZXZpb3VzbHkg
bm90IHNldC48YnI+CiZndDsgVGhlcmUgZG9lcyBub3Qgc2VlbSB0byBiZSBhbnkgcmVmZXJlbmNl
IHRvIFBLQ1M4IGZvciB0aGlzIGtlcm5lbC48YnI+CiZndDsgPGJyPgomZ3Q7IFRoYW5rcyE8YnI+
CiZndDsgPGJyPgomZ3Q7IEtlaXRoPGJyPgomZ3Q7IDxicj4KJmd0OyBPbiBNb24sIEFwciAyNywg
MjAyMCBhdCAyOjM2IEFNIERhbmllbCBXYWduZXIgJmx0OzxhIGhyZWY9Im1haWx0bzp3YWdpQG1v
bm9tLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPndhZ2lAbW9ub20ub3JnPC9hPiZndDsgd3JvdGU6PGJy
PgomZ3Q7IDxicj4KJmd0OyAmZ3Q7IE9uIFNhdCwgQXByIDI1LCAyMDIwIGF0IDExOjIwOjQ1QU0g
LTA1MDAsIEtlaXRoRyB3cm90ZTo8YnI+CiZndDsgJmd0OyAmZ3Q7IEkgbG9va2VkIGF0IHRoZSBJ
V0QgcmVhZG1lIGFuZCBjYW5ub3QgZW5hYmxlIHRoaXMgb24gdGhlIFJQaTo8YnI+CiZndDsgJmd0
OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAjIGlwIGxpbmsgc2V0IGRldiBubG1vbiBhbGxtdWx0
aWNhc3Qgb248YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgQ2Fubm90IGZpbmQgZGV2aWNlICZxdW90
O25sbW9uJnF1b3Q7PGJyPgomZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyBUaGUgUlBpIGtlcm5lbCBo
YXMgbm8gc3VwcG9ydCBmb3Igbmxtb24gZW5hYmxlZC4gSWYgeW91IHdhbnQgdG8gZGVidWcgdGhp
czxicj4KJmd0OyAmZ3Q7IHlvdTxicj4KJmd0OyAmZ3Q7IHByb3BhYmx5IG5lZWQgdG8gY29tcGls
ZSB5b3VyIG93biBSUGkga2VybmVsIHdpdGggbmxtb24gZW5hYmxlZC48YnI+CiZndDsgJmd0Ozxi
cj4KJmd0OyAmZ3Q7ICZndDsgSSBkaWQgdmVyaWZ5IGEgY291cGxlIHRoaW5ncy4gSSBkbyBoYXZl
IGl3ZCBzZXQgZXhwbGljaXRseSB3aGVuIEkgc3RhcnQ8YnI+CiZndDsgJmd0OyAmZ3Q7IGNvbm5t
YW48YnI+CiZndDsgJmd0OyAmZ3Q7wqAgL3Vzci9iaW4vY29ubm1hbmQgLS13aWZpPWl3ZF9hZ2Vu
dCAtbiAtLW5vZG5zcHJveHk8YnI+CiZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7IC0td2lmaT1pd2Rf
YWdlbnQgaXMgd3JvbmcuIElmIHlvdSB3YW50IGl3ZCBzdXBwb3J0IHlvdSBuZWVkIHRvIGRlZmlu
ZSB0aGlzPGJyPgomZ3Q7ICZndDsgYXQgY29tcGlsZSB0aW1lIG9ubHk6PGJyPgomZ3Q7ICZndDs8
YnI+CiZndDsgJmd0O8KgIMKgIC4vY29uZmlndXJlIC0tZW5hYmxlLWl3ZCAtLWRpc2FibGUtd2lm
aTxicj4KJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgd2hpY2ggYWRkcyB0aGUgaXdkIHBsdWdpbiBh
bmQgZGlzYWJsZXMgdGhlIHdwYV9zdXBwbGljYW50IHBsdWdpbi4gQnV0IEk8YnI+CiZndDsgJmd0
OyBkb24mIzM5O3Q8YnI+CiZndDsgJmd0OyB0aGluayBpdCBtYXR0ZXIuIC0taXdmaS1pd2RfYWdl
bnQgd2lsbCBiZSBpZ25vcmVkIGFuZCBDb25uTWFuIHdpbGw8YnI+CiZndDsgJmd0OyBkeW5hbWlj
YWxseTxicj4KJmd0OyAmZ3Q7IGRpc2NvdmVyIGl3ZC4gSnVzdCBtYWtlIHN1cmUgd3BhX3N1cHBs
aWNhbnQgaXMgbm90IHJ1bm5pbmcuIFdpdGggdGhlIGFib3ZlPGJyPgomZ3Q7ICZndDsgY29tbWFu
ZCBsaW5lIHlvdSB3b3VsZCBtYWtlIHN1cmUgd3BhX3N1cHBsaWNhbnQgaXMgbm90IGFjY2lkZW50
YWxseSB1c2VkLjxicj4KJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyBXaGVuIEkgaXNzdWUg
dGhlIGNvbW1hbmQgZnJvbSBjb25ubWFuLCB0aGUgbW9kZSBjaGFuZ2VzIGluIGl3ZDo8YnI+CiZn
dDsgJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7ICMgY29ubm1hbmN0bCB0ZXRoZXIg
d2lmaSBvbiBteXNzaWQgcGFzc3dvcmQ8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgV2lmaSBTU0lE
IHNldDxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyBXaWZpIHBhc3NwaHJhc2Ugc2V0PGJyPgomZ3Q7
ICZndDsgJmd0OyAmZ3Q7IEVuYWJsZWQgdGV0aGVyaW5nIGZvciB3aWZpPGJyPgomZ3Q7ICZndDsg
Jmd0OyAmZ3Q7ICMgaXAgYWRkcjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAxOiBsbzogJmx0O0xP
T1BCQUNLLFVQLExPV0VSX1VQJmd0OyBtdHUgNjU1MzYgcWRpc2Mgbm9xdWV1ZSBzdGF0ZSBVTktO
T1dOPGJyPgomZ3Q7ICZndDsgZ3JvdXA8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgZGVmYXVsdCBx
bGVuIDEwMDA8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoGxpbmsvbG9vcGJhY2sgMDA6
MDA6MDA6MDA6MDA6MDAgYnJkIDAwOjAwOjAwOjAwOjAwOjAwPGJyPgomZ3Q7ICZndDsgJmd0OyAm
Z3Q7wqAgwqAgwqBpbmV0IDxhIGhyZWY9Imh0dHA6Ly8xMjcuMC4wLjEvOCIgcmVsPSJub3JlZmVy
cmVyIiB0YXJnZXQ9Il9ibGFuayI+MTI3LjAuMC4xLzg8L2E+IHNjb3BlIGhvc3QgbG88YnI+CiZn
dDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCB2YWxpZF9sZnQgZm9yZXZlciBwcmVmZXJyZWRf
bGZ0IGZvcmV2ZXI8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoGluZXQ2IDo6MS8xMjgg
c2NvcGUgaG9zdDxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIHZhbGlkX2xmdCBm
b3JldmVyIHByZWZlcnJlZF9sZnQgZm9yZXZlcjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyAyOiBl
dGgwOiAmbHQ7QlJPQURDQVNULE1VTFRJQ0FTVCxEWU5BTUlDLFVQLExPV0VSX1VQJmd0OyBtdHUg
MTUwMCBxZGlzYzxicj4KJmd0OyAmZ3Q7IGZxX2NvZGVsPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7
IHN0YXRlIFVQIGdyb3VwIGRlZmF1bHQgcWxlbiAxMDAwPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7
wqAgwqAgwqBsaW5rL2V0aGVyIGEwOmNlOmM4OjEyOmVkOjA1IGJyZCBmZjpmZjpmZjpmZjpmZjpm
Zjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgaW5ldCA8YSBocmVmPSJodHRwOi8vMTky
LjE2OC4yLjI1LzI0IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj4xOTIuMTY4LjIu
MjUvMjQ8L2E+IGJyZCAxOTIuMTY4LjIuMjU1IHNjb3BlIGdsb2JhbCBldGgwPGJyPgomZ3Q7ICZn
dDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgdmFsaWRfbGZ0IGZvcmV2ZXIgcHJlZmVycmVkX2xmdCBm
b3JldmVyPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqBpbmV0NiBmZTgwOjphMmNlOmM4
ZmY6ZmUxMjplZDA1LzY0IHNjb3BlIGxpbms8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDC
oCDCoCB2YWxpZF9sZnQgZm9yZXZlciBwcmVmZXJyZWRfbGZ0IGZvcmV2ZXI8YnI+CiZndDsgJmd0
OyAmZ3Q7ICZndDsgMzogd2xhbjA6ICZsdDtOTy1DQVJSSUVSLEJST0FEQ0FTVCxNVUxUSUNBU1Qs
VVAsTE9XRVJfVVAmZ3Q7IG10dSAxNTAwIHFkaXNjPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7IGZx
X2NvZGVsIG1hc3RlciB0ZXRoZXIgc3RhdGUgRE9STUFOVCBncm91cCBkZWZhdWx0IHFsZW4gMTAw
MDxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgbGluay9ldGhlciBiODoyNzplYjoyODox
ODo0OCBicmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmY8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgNDogdGV0
aGVyOiAmbHQ7Tk8tQ0FSUklFUixCUk9BRENBU1QsTVVMVElDQVNULERZTkFNSUMsVVAmZ3Q7IG10
dSAxNTAwIHFkaXNjPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7IG5vcXVldWUgc3RhdGUgRE9XTiBn
cm91cCBkZWZhdWx0IHFsZW4gMTAwMDxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgbGlu
ay9ldGhlciA5YTo2OTozYTo0ODpjMTozMiBicmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmY8YnI+CiZndDsg
Jmd0OyAmZ3Q7ICZndDvCoCDCoCDCoGluZXQgPGEgaHJlZj0iaHR0cDovLzE5Mi4xNjguMC4xLzI0
IiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj4xOTIuMTY4LjAuMS8yNDwvYT4gYnJk
IDE5Mi4xNjguMC4yNTUgc2NvcGUgZ2xvYmFsIHRldGhlcjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0
O8KgIMKgIMKgIMKgIHZhbGlkX2xmdCBmb3JldmVyIHByZWZlcnJlZF9sZnQgZm9yZXZlcjxicj4K
Jmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgaW5ldDYgZmU4MDo6ZDAyNDo1ZWZmOmZlODA6MWE1
Ny82NCBzY29wZSBsaW5rPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgdmFsaWRf
bGZ0IGZvcmV2ZXIgcHJlZmVycmVkX2xmdCBmb3JldmVyPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7
ICMgaXdjdGwgZGV2aWNlIHdsYW4wIHNob3c8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBEZXZpY2U6IHdsYW4w
PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7PGJyPgomZ3Q7
ICZndDsgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDvCoCDC
oFNldHRhYmxlwqAgUHJvcGVydHnCoCDCoCDCoCDCoCDCoCDCoCBWYWx1ZTxicj4KJmd0OyAmZ3Q7
ICZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7IC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqBOYW1lwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgd2xhbjA8YnI+CiZndDsgJmd0OyAmZ3Q7ICZn
dDvCoCDCoCDCoCDCoCDCoCAqwqAgTW9kZcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGFwPGJyPgom
Z3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgKsKgIFBvd2VyZWTCoCDCoCDCoCDCoCDC
oCDCoCDCoG9uPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBBZGRy
ZXNzwqAgwqAgwqAgwqAgwqAgwqAgwqBiODoyNzplYjoyODoxODo0ODxicj4KJmd0OyAmZ3Q7ICZn
dDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgQWRhcHRlcsKgIMKgIMKgIMKgIMKgIMKgIMKgcGh5
MDxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0Ozxicj4KJmd0OyAmZ3Q7ICZndDs8YnI+CiZndDsgJmd0
OyAmZ3Q7IEkgZ2V0IHRoZXNlIHJlc3BvbnNlcyBpbiB0aGUgam91cm5hbCB3aGVuIEkgdHJ5IHRv
IGNvbm5lY3QgYnV0IGl0IG5ldmVyPGJyPgomZ3Q7ICZndDsgJmd0OyBjb25uZWN0czo8YnI+CiZn
dDsgJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7IHNyYy9uZXRkZXYuYzpuZXRkZXZf
bWxtZV9ub3RpZnkoKSBNTE1FIG5vdGlmaWNhdGlvbiBOZXcgU3RhdGlvbigxOSk8YnI+CiZndDsg
Jmd0OyAmZ3Q7ICZndDsgc3JjL25ldGRldi5jOm5ldGRldl9tbG1lX25vdGlmeSgpIE1MTUUgbm90
aWZpY2F0aW9uIERlbCBTdGF0aW9uKDIwKTxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyBzcmMvbmV0
ZGV2LmM6bmV0ZGV2X21sbWVfbm90aWZ5KCkgTUxNRSBub3RpZmljYXRpb24gRGVsIFN0YXRpb24o
MjApPGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDs8YnI+CiZndDsgJmd0OyBE
aWQgeW91IHRyeSB0byBydW4gaXdkIHdpdGggZGVidWcgZW5hYmxlZCAmIzM5O2l3ZCAtZCYjMzk7
PyBNYXliZSB0aGVyZSBpcyBtb3JlPGJyPgomZ3Q7ICZndDsgaW5mby4gQW5kIGlmIHRoZXJlIGlz
biYjMzk7dCBhbnkgY2x1ZSwgdGhlIGJlc3Qgd2F5IGZvcndhcmQgaXMgdG8gZ2V0PGJyPgomZ3Q7
ICZndDsgbmxtb24gcnVubmluZyBhbmQgcHJvdmlkZSB0aGUgaW5mb3JtYXRpb24gdGhlIGl3ZCBk
ZXZlbG9wZXJzLiBGcm9tIHdoYXQgSTxicj4KJmd0OyAmZ3Q7IHNlZSBDb25uTWFuIGlzIHRhbGtp
bmcgdG8gaXdkIGFuZCBzZXR1cHMgdGhlIEFQIG1vZGUuPGJyPgomZ3Q7ICZndDs8YnI+CiZndDsg
Jmd0OyAmZ3Q7IEkgY3VycmVudGx5IHVzZSBob3N0YXBkIGFuZCBkbnNtYXNxIHRvIGhhdmUgdGhp
cyBoZWFkbGVzcyBSUGkgYXVkaW88YnI+CiZndDsgJmd0OyAmZ3Q7IGFwcGxpYW5jZSB3b3JrIGFz
IGFuIEFQIGZvciBpbml0aWFsIHNldHVwLCBidXQgd2FudCB0byByZW1vdmUgaG9zdGFwZCBhbmQ8
YnI+CiZndDsgJmd0OyAmZ3Q7IGRuc21hc3EgaWYgSSBjYW4gZ2V0IGNvbm5tYW4vaXdkIHRvIGRv
IHRoZSBzYW1lIHRoaW5nLiBJIHRyaWVkIHRvIGdldCBpd2Q8YnI+CiZndDsgJmd0OyAmZ3Q7IHRv
IGdvIGludG8gYXAgbW9kZSBhbmQgY29ubmVjdCwgYnV0IGNhbm5vdCBkbyBpdCB0aGVyZSwgZWl0
aGVyLiBJIGRvIGdldDxicj4KJmd0OyAmZ3Q7ICZndDsgc29tZSBtZXNzYWdlcyBhdCBzdGFydHVw
IG9mIGl3ZC4gSSBkbyBub3QgdGhpbmsgdGhlc2UgYXJlIHRoZSBwcm9ibGVtLDxicj4KJmd0OyAm
Z3Q7IGJ1dDxicj4KJmd0OyAmZ3Q7ICZndDsgdGhleSBhcmUgbWlzc2luZyBrZXJuZWwgbW9kdWxl
czo8YnI+CiZndDsgJmd0OyAmZ3Q7PGJyPgomZ3Q7ICZndDsgJmd0OyBObyBEaWZmaWUtSGVsbG1h
biBzdXBwb3J0IGZvdW5kLCBXUFMgd2lsbCBub3QgYmUgYXZhaWxhYmxlPGJyPgomZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IE5vIGFzeW1tZXRyaWMga2V5IHN1cHBvcnQgZm91bmQuPGJyPgomZ3Q7ICZndDsg
Jmd0OyAmZ3Q7IFRMUyBiYXNlZCBXUEEtRW50ZXJwcmlzZSBhdXRoZW50aWNhdGlvbiBtZXRob2Rz
IHdpbGwgbm90IGZ1bmN0aW9uLjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0OyBLZXJuZWwgNC4yMCsg
aXMgcmVxdWlyZWQgZm9yIHRoaXMgZmVhdHVyZS48YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDsgVGhl
IGZvbGxvd2luZyBvcHRpb25zIGFyZSBtaXNzaW5nIGluIHRoZSBrZXJuZWw6PGJyPgomZ3Q7ICZn
dDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqBDT05GSUdfQVNZTU1FVFJJQ19LRVlfVFlQRTxicj4K
Jmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKgIMKgIMKgQ09ORklHX0tFWV9ESF9PUEVSQVRJT05T
PGJyPgomZ3Q7ICZndDsgJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqBDT05GSUdfQVNZTU1FVFJJQ19Q
VUJMSUNfS0VZX1NVQlRZUEU8YnI+CiZndDsgJmd0OyAmZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoENP
TkZJR19QS0NTN19NRVNTQUdFX1BBUlNFUjxicj4KJmd0OyAmZ3Q7ICZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgQ09ORklHX1g1MDlfQ0VSVElGSUNBVEVfUEFSU0VSPGJyPgomZ3Q7ICZndDsgJmd0OyAm
Z3Q7wqAgwqAgwqAgwqAgwqBDT05GSUdfUEtDUzhfUFJJVkFURV9LRVlfUEFSU0VSPGJyPgomZ3Q7
ICZndDsgJmd0OyAmZ3Q7IFdpcmVsZXNzIGRhZW1vbiB2ZXJzaW9uIDEuNjxicj4KJmd0OyAmZ3Q7
PGJyPgomZ3Q7ICZndDsgSSBkb24mIzM5O3Qga25vdyBidXQgSSB3b3VsZCBzdWdnZXN0IHRvIGFk
ZHJlc3MgdGhpcyBpbiB0aGUgc2FtZSBnbyB3aGVuIHlvdTxicj4KJmd0OyAmZ3Q7IGJ1aWxkPGJy
PgomZ3Q7ICZndDsgYSBuZXcga2VybmVsIHdpdGggbmxtb24gc3VwcG9ydC48YnI+CiZndDsgJmd0
Ozxicj4KJmd0OyAmZ3Q7IFRoYW5rcyw8YnI+CiZndDsgJmd0OyBEYW5pZWw8YnI+CiZndDsgJmd0
Ozxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============0214185843983038217==--

