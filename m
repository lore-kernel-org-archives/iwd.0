Content-Type: multipart/mixed; boundary="===============6305707490087205933=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: broadcom fmac ap mode testing - how to set iwd as dhcp server?
Date: Thu, 28 Jan 2021 19:23:41 -0600
Message-ID: <CAG17S_NPTw0uyaygZ1FWHm9ar6KCMMr57iVY0apAN-ejeNc+Ew@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6305707490087205933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Group,

I noticed that the latest patches posted for iwd appeared to addres the
broadcom fmac in ap mode. I compiled the latest from git and tried it out.
It will make a connection. Big improvement from before. This is a log of
the connection on my RPi running iwctl in ap mode. I am connecting from a
dell laptop.

# iwmon
Wireless monitor ver 1.11
Created interface nlmon
> Event: New Station (0x13) len 168
                                       1611882622.696232
    Interface Index: 3 (0x00000003)
    MAC Address 60:F2:62:AE:70:FE
    Generation: 9 (0x00000009)
    Station Info: len 0
    Information Elements: len 129
        SSID: RuneAudioAP1
            52 75 6e 65 41 75 64 69 6f 41 50 31              RuneAudioAP1
        Supported rates:
            1.0(B) 2.0(B) 5.5(B) 11.0(B) 6.0 9.0 12.0 18.0 Mbit/s
            82 84 8b 96 0c 12 18 24                          .......$
        Tag 33: len 2
            00 0f                                            ..
        Tag 36: len 50
            24 01 28 01 2c 01 30 01 34 01 38 01 3c 01 40 01
 $.(.,.0.4.8.<.(a).
            64 01 68 01 6c 01 70 01 74 01 78 01 7c 01 80 01
 d.h.l.p.t.x.|...
            84 01 88 01 8c 01 90 01 95 01 99 01 9d 01 a1 01
 ................
            a5 01                                            ..
        RSN:
            Group Data Cipher Suite: len 4
                CCMP (00:0f:ac) suite  04
            Pairwise Cipher Suite: len 4
                CCMP (00:0f:ac) suite  04
            AKM Suite: len 4
                PSK; RSNA PSK (00:0f:ac) suite  02
            RSN capabilities: bits  2 - 3: 1 replay counter per PTKSA
            RSN capabilities: bits  4 - 5: 1 replay counter per GTKSA
            01 00 00 0f ac 04 01 00 00 0f ac 04 01 00 00 0f
 ................
            ac 02 00 00 00 00                                ......
        Extended supported rates:
            24.0 36.0 48.0 54.0 Mbit/s
            30 48 60 6c                                      0H`l
        RM Enabled Capabilities: len 5
            Enabled: bit  1: Neighbor Report
            Enabled: bit  4: Beacon Passive Measurement
            Enabled: bit  5: Beacon Active Measurement
            Enabled: bit  6: Beacon Table Measurement
            Operating Channel Max Measurement Duration: 0
            Non-Operating Channel Max Measurement Duration: 0
            Measurement Pilot Capability: 0
            72 00 00 00 00                                   r....
        Extended yCapabilities: len 10
            Capability: bit  2: Extended channel switching
            Capability: bit 19: BSS transition
            Capability: bit 22: Multiple BSSID
            Capability: bit 23: Timing measurement
            Capability: bit 31: Interworking
            Capability: bit 32: QoS Map
            Capability: bit 46: WNM- Notification
            04 00 c8 80 01 40 00 00 00 00                    .....@....
< Request: Set Station (0x12) len 32 [ack]
                                        1611882622.696372
    Interface Index: 3 (0x00000003)
    MAC Address 60:F2:62:AE:70:FE
    Station Flags 2: len 8
        Mask: 0x00000002
            Authorized
        Set: 0x00000000
> Response: Set Station (0x12) len 4 [root]
                                       1611882622.697255
    Status: Success (0)
< Request: New Key (0x0b) len 48 [ack]
                                        1611882622.697359
    Interface Index: 3 (0x00000003)
    Key: len 36
        14 00 01 00 c4 79 49 79 56 8f 90 f3 d7 9a be 73  .....yIyV......s
        8a ba 6e 6f 08 00 03 00 04 ac 0f 00 05 00 02 00  ..no............
        01 00 00 00                                      ....
> Response: New Key (0x0b) len 4 [0x100]
                                        1611882622.698943
    Status: Success (0)
< Request: Set Key (0x0a) len 32 [ack]
                                        1611882622.699011
    Interface Index: 3 (0x00000003)
    Key: len 20
        05 00 02 00 01 00 00 00 04 00 05 00 08 00 08 80  ................
        04 00 02 00                                      ....
> Response: Set Key (0x0a) len 4 [0x100]
                                        1611882622.699725
    Status: Success (0)
< Request: Get Key (0x09) len 16 [ack]
                                        1611882622.699782
    Interface Index: 3 (0x00000003)
    Key Index: 1 (0x01)
> Result: New Key (0x0b) len 44
                                       1611882622.700248
    Interface Index: 3 (0x00000003)
    Key Index: 1 (0x01)
    Key Cipher: BIP (00:0f:ac) suite  06
    Key: len 16
        08 00 03 00 06 ac 0f 00 05 00 02 00 01 00 00 00  ................
< PAE: len 121
                                                 0.700570
    Interface Index: 3
    EAPoL: len 121
        Protocol Version: 2 (802.1X-2004)
        Type: 3 (Key)
        Length: 117
        Descriptor Type: 2
        Key MIC: false
        Secure: false
        Error: false
        Request: false
        Encrypted Key Data: false
        SMK Message: false
        Key Descriptor Version: 2 (02)
        Key Type: true
        Install: false
        Key ACK: true
        Key Length: 16
        Key Replay Counter: 1
        Key NONCE
            47 6e 2d 93 73 84 22 f1 1c 6a 5d 3d 95 e4 9b 74
 Gn-.s."..j]=3D...t
            5d f8 d5 48 06 7a e8 49 2e 44 98 98 59 c7 92 00
 ]..H.z.I.D..Y...
        Key IV
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
        Key RSC
            00 00 00 00 00 00 00 00                          ........
        Key MIC Data
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
        Key Data: len 22
            Vendor specific: len 20
                IEEE 802.11 (00:0f:ac) type: 04
                PMKID KDE
                00 0f ac 04 54 72 65 62 5c 4b e4 40 60 01 9c e8
 ....Treb\K.@`...
                5f 33 0f 78                                      _3.x
        02 03 00 75 02 00 8a 00 10 00 00 00 00 00 00 00  ...u............
        01 47 6e 2d 93 73 84 22 f1 1c 6a 5d 3d 95 e4 9b  .Gn-.s."..j]=3D...
        74 5d f8 d5 48 06 7a e8 49 2e 44 98 98 59 c7 92  t]..H.z.I.D..Y..
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 16 dd 14 00 0f ac 04 54 72 65 62 5c 4b e4  .........Treb\K.
        40 60 01 9c e8 5f 33 0f 78                       @`..._3.x
> Response: Get Key (0x09) len 4 [0x100]
                                                 0.700267
    Status: Success (0)
> PAE: len 123
                                                 0.707588
    Interface Index: 3
    EAPoL: len 123
        Protocol Version: 1 (802.1X-2001)
        Type: 3 (Key)
        Length: 119
        Descriptor Type: 2
        Key MIC: true
        Secure: false
        Error: false
        Request: false
        Encrypted Key Data: false
        SMK Message: false
        Key Descriptor Version: 2 (02)
        Key Type: true
        Install: false
        Key ACK: false
        Key Length: 0
        Key Replay Counter: 1
        Key NONCE
            29 7a a9 c3 84 c6 ed 06 c0 00 75 68 57 3d 16 78
 )z........uhW=3D.x
            d4 3e 1e 62 1d 48 5d c6 01 da a0 8f 7f 16 b3 cd
 .>.b.H].........
        Key IV
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
        Key RSC
            00 00 00 00 00 00 00 00                          ........
        Key MIC Data
            cf aa 34 82 65 28 93 a7 62 c2 0a b4 e0 d9 dd 59
 ..4.e(..b......Y
        Key Data: len 24
            RSN:
                Group Data Cipher Suite: len 4
                    CCMP (00:0f:ac) suite  04
                Pairwise Cipher Suite: len 4
                    CCMP (00:0f:ac) suite  04
                AKM Suite: len 4
                    PSK; RSNA PSK (00:0f:ac) suite  02
                RSN capabilities: bits  2 - 3: 1 replay counter per PTKSA
                RSN capabilities: bits  4 - 5: 1 replay counter per GTKSA
                01 00 00 0f ac 04 01 00 00 0f ac 04 01 00 00 0f
 ................
                ac 02 00 00 00 00                                ......
        01 03 00 77 02 01 0a 00 00 00 00 00 00 00 00 00  ...w............
        01 29 7a a9 c3 84 c6 ed 06 c0 00 75 68 57 3d 16  .)z........uhW=3D.
        78 d4 3e 1e 62 1d 48 5d c6 01 da a0 8f 7f 16 b3  x.>.b.H]........
        cd 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 cf aa 34 82 65 28 93 a7 62 c2 0a b4 e0 d9 dd  ...4.e(..b......
        59 00 18 30 16 01 00 00 0f ac 04 01 00 00 0f ac  Y..0............
        04 01 00 00 0f ac 02 00 00 00 00                 ...........
< PAE: len 155
                                                 0.708697
    Interface Index: 3
    EAPoL: len 155
        Protocol Version: 2 (802.1X-2004)
        Type: 3 (Key)
        Length: 151
        Descriptor Type: 2
        Key MIC: true
        Secure: true
        Error: false
        Request: false
        Encrypted Key Data: true
        SMK Message: false
        Key Descriptor Version: 2 (02)
        Key Type: true
        Install: true
        Key ACK: true
        Key Length: 16
        Key Replay Counter: 2
        Key NONCE
            47 6e 2d 93 73 84 22 f1 1c 6a 5d 3d 95 e4 9b 74
 Gn-.s."..j]=3D...t
            5d f8 d5 48 06 7a e8 49 2e 44 98 98 59 c7 92 00
 ]..H.z.I.D..Y...
        Key IV
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
        Key RSC
            00 00 00 00 00 00 00 00                          ........
        Key MIC Data
            6e b0 eb f8 83 f8 20 31 ad b8 96 df bf 7f 8f 75  n.....
1.......u
        Key Data: len 56
            cd d7 94 40 e2 7d 9e 63 dc f3 fa b1 3e f4 c7 3a
 ...@.}.c....>..:
            ec 81 46 6a a9 ea 6e b3 ed 22 d7 81 f7 cf 60 fc
 ..Fj..n.."....`.
            64 31 d2 9e 1b 44 da 7a 50 ff 05 aa 25 51 2f 8e
 d1...D.zP...%Q/.
            f5 d2 d4 96 b4 65 d3 41                          .....e.A
        02 03 00 97 02 13 ca 00 10 00 00 00 00 00 00 00  ................
        02 47 6e 2d 93 73 84 22 f1 1c 6a 5d 3d 95 e4 9b  .Gn-.s."..j]=3D...
        74 5d f8 d5 48 06 7a e8 49 2e 44 98 98 59 c7 92  t]..H.z.I.D..Y..
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 6e b0 eb f8 83 f8 20 31 ad b8 96 df bf 7f 8f  .n..... 1.......
        75 00 38 cd d7 94 40 e2 7d 9e 63 dc f3 fa b1 3e  u.8...(a).}.c....>
        f4 c7 3a ec 81 46 6a a9 ea 6e b3 ed 22 d7 81 f7  ..:..Fj..n.."...
        cf 60 fc 64 31 d2 9e 1b 44 da 7a 50 ff 05 aa 25  .`.d1...D.zP...%
        51 2f 8e f5 d2 d4 96 b4 65 d3 41                 Q/......e.A
> PAE: len 99
                                                0.717237
    Interface Index: 3
    EAPoL: len 99
        Protocol Version: 1 (802.1X-2001)
        Type: 3 (Key)
        Length: 95
        Descriptor Type: 2
        Key MIC: true
        Secure: true
        Error: false
        Request: false
        Encrypted Key Data: false
        SMK Message: false
        Key Descriptor Version: 2 (02)
        Key Type: true
        Install: false
        Key ACK: false
        Key Length: 0
        Key Replay Counter: 2
        Key NONCE
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
        Key IV
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
        Key RSC
            00 00 00 00 00 00 00 00                          ........
        Key MIC Data
            58 61 8f 4a fb 79 4e a5 58 36 31 0e b7 71 c3 4f
 Xa.J.yN.X61..q.O
        Key Data: len 0
        01 03 00 5f 02 03 0a 00 00 00 00 00 00 00 00 00  ..._............
        02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 58 61 8f 4a fb 79 4e a5 58 36 31 0e b7 71 c3  .Xa.J.yN.X61..q.
        4f 00 00                                         O..
< Request: New Key (0x0b) len 56 [ack]
                                                 0.717527
    Key Data: len 16
        ab aa cd 37 2e ef 97 7f 15 f8 72 a5 90 2c c0 20  ...7......r..,.
    Key Cipher: CCMP (00:0f:ac) suite  04
    MAC Address 60:F2:62:AE:70:FE
    Key Index: 0 (0x00)
    Interface Index: 3 (0x00000003)
> Response: New Key (0x0b) len 4 [0x100]
                                                 0.718200
    Status: Success (0)
< Request: Set Station (0x12) len 32 [ack]
                                                 0.718256
    Interface Index: 3 (0x00000003)
    MAC Address 60:F2:62:AE:70:FE
    Station Flags 2: len 8
        Mask: 0x00000002
            Authorized
        Set: 0x00000002
            Authorized
> Response: Set Station (0x12) len 4 [root]
                                                0.718608
    Status: Success (0)
< RTNL: Set Link (0x13) len 32 [request,ack]
                                                 0.718663
    Flags: 5 (0x005)
    Sequence number: 8 (0x00000008)
    Port ID: 81225
> RTNL: New Link (0x10) len 1308
                                                 0.718871
    Flags: 0 (0x000)
    Sequence number: 0 (0x00000000)
    Port ID: 0
    IFLA Family: Unknown
    IFLA Type: 1
    IFLA Index: 3
    IFLA ChangeMask: 0
    IFLA Flags: (0x1043) [up,broadcast,running,multicast]
        IfName (len:6): wlan0
        Txqlen: 1000 (0x000003e8)
        OperState: up (6)
        LinkMode: userspace controlled (1)
        MTU: 1500 (0x000005dc)
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 1
        Qdisc (len:9): fq_codel
        Reserved: len 4
        Reserved: len 1
        Reserved: len 4
        Reserved: len 4
        Map: len 32
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
        Interface Address: b8:27:eb:52:cc:d0
        Broadcast Address: ff:ff:ff:ff:ff:ff
        Reserved: len 192
        Stats: len 96
            7c 10 22 00 f1 7f 03 00 5a a1 b5 16 db b9 57 03
 |.".....Z.....W.
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
            45 f2 1e 00 00 00 00 00 00 00 00 00 00 00 00 00
 E...............
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
        Reserved: len 8
        Reserved: len 756
> RTNL: New Link (0x10) len 1308
                                                 0.718888
    Flags: 0 (0x000)
    Sequence number: 0 (0x00000000)
    Port ID: 0
    IFLA Family: Unknown
    IFLA Type: 1
    IFLA Index: 3
    IFLA ChangeMask: 0
    IFLA Flags: (0x1043) [up,broadcast,running,multicast]
        IfName (len:6): wlan0
        Txqlen: 1000 (0x000003e8)
        OperState: up (6)
        LinkMode: userspace controlled (1)
        MTU: 1500 (0x000005dc)
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 1
        Qdisc (len:9): fq_codel
        Reserved: len 4
        Reserved: len 1
        Reserved: len 4
        Reserved: len 4
        Map: len 32
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
        Interface Address: b8:27:eb:52:cc:d0
        Broadcast Address: ff:ff:ff:ff:ff:ff
        Reserved: len 192
        Stats: len 96
            7c 10 22 00 f1 7f 03 00 5a a1 b5 16 db b9 57 03
 |.".....Z.....W.
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
            45 f2 1e 00 00 00 00 00 00 00 00 00 00 00 00 00
 E...............
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
        Reserved: len 8
        Reserved: len 756
> RTNL: New Link (0x10) len 1308
                                                 0.718896
    Flags: 0 (0x000)
    Sequence number: 0 (0x00000000)
    Port ID: 0
    IFLA Family: Unknown
    IFLA Type: 1
    IFLA Index: 3
    IFLA ChangeMask: 0
    IFLA Flags: (0x1043) [up,broadcast,running,multicast]
        IfName (len:6): wlan0
        Txqlen: 1000 (0x000003e8)
        OperState: up (6)
        LinkMode: userspace controlled (1)
        MTU: 1500 (0x000005dc)
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 4
        Reserved: len 1
        Qdisc (len:9): fq_codel
        Reserved: len 4
        Reserved: len 1
        Reserved: len 4
        Reserved: len 4
        Map: len 32
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
        Interface Address: b8:27:eb:52:cc:d0
        Broadcast Address: ff:ff:ff:ff:ff:ff
        Reserved: len 192
        Stats: len 96
            7c 10 22 00 f1 7f 03 00 5a a1 b5 16 db b9 57 03
 |.".....Z.....W.
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
            45 f2 1e 00 00 00 00 00 00 00 00 00 00 00 00 00
 E...............
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ................
        Reserved: len 8
        Reserved: len 756
> RTNL: Error (0x02) len 20 [0x100]
                                                0.718926
    Flags: 256 (0x100)
    Sequence number: 8 (0x00000008)
    Port ID: 81225
    ACK: 0

Still gives an RTNL error but I do not kow what that means. And once
connected, I could not disconnect and reconnect without restarting the ap.
I would get an immediate dsiconnect and iwmon shows:

> Event: Del Station (0x14) len 32
                                               474.439927
    Interface Index: 3 (0x00000003)
    MAC Address 60:F2:62:AE:70:FE
    Generation: 0 (0x00000000)
    Station Info: len 0

When I restart the AP from iwct, I can connect again.
What I do not yet know how to do, though, is assign an ip address to the ap
and then have it be a dhcp server to serve out a dhcp address to the
connecting computer. I found this online and took a stab, but it did not
assign an address, though the computer did 'attach'.

How do you set it up for iwd to be a dhcp server? If iwd cannot do it, can
I use dhcpd? dnsmasq? I have found very little info in my searches.

Thanks for this! It will help with adoption of iwd in the RPi community.

--===============6305707490087205933==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5Hcm91cCw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pkkgbm90
aWNlZCB0aGF0IHRoZSBsYXRlc3QgcGF0Y2hlcyBwb3N0ZWQgZm9yIGl3ZCBhcHBlYXJlZCB0byBh
ZGRyZXMgdGhlIGJyb2FkY29tIGZtYWMgaW4gYXAgbW9kZS4gSSBjb21waWxlZCB0aGUgbGF0ZXN0
IGZyb20gZ2l0IGFuZCB0cmllZCBpdCBvdXQuIEl0IHdpbGwgbWFrZSBhIGNvbm5lY3Rpb24uIEJp
ZyBpbXByb3ZlbWVudCBmcm9tIGJlZm9yZS4gVGhpcyBpcyBhIGxvZyBvZiB0aGUgY29ubmVjdGlv
biBvbiBteSBSUGkgcnVubmluZyBpd2N0bCBpbiBhcCBtb2RlLiBJIGFtIGNvbm5lY3RpbmcgZnJv
bSBhIGRlbGwgbGFwdG9wLjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PiMgaXdtb248YnI+
V2lyZWxlc3MgbW9uaXRvciB2ZXIgMS4xMTxicj5DcmVhdGVkIGludGVyZmFjZSBubG1vbjxicj4m
Z3Q7IEV2ZW50OiBOZXcgU3RhdGlvbiAoMHgxMykgbGVuIDE2OCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDE2MTE4ODI2MjIuNjk2
MjMyPGJyPsKgIMKgIEludGVyZmFjZSBJbmRleDogMyAoMHgwMDAwMDAwMyk8YnI+wqAgwqAgTUFD
IEFkZHJlc3MgNjA6RjI6NjI6QUU6NzA6RkU8YnI+wqAgwqAgR2VuZXJhdGlvbjogOSAoMHgwMDAw
MDAwOSk8YnI+wqAgwqAgU3RhdGlvbiBJbmZvOiBsZW4gMDxicj7CoCDCoCBJbmZvcm1hdGlvbiBF
bGVtZW50czogbGVuIDEyOTxicj7CoCDCoCDCoCDCoCBTU0lEOiBSdW5lQXVkaW9BUDE8YnI+wqAg
wqAgwqAgwqAgwqAgwqAgNTIgNzUgNmUgNjUgNDEgNzUgNjQgNjkgNmYgNDEgNTAgMzEgwqAgwqAg
wqAgwqAgwqAgwqAgwqBSdW5lQXVkaW9BUDE8YnI+wqAgwqAgwqAgwqAgU3VwcG9ydGVkIHJhdGVz
Ojxicj7CoCDCoCDCoCDCoCDCoCDCoCAxLjAoQikgMi4wKEIpIDUuNShCKSAxMS4wKEIpIDYuMCA5
LjAgMTIuMCAxOC4wIE1iaXQvczxicj7CoCDCoCDCoCDCoCDCoCDCoCA4MiA4NCA4YiA5NiAwYyAx
MiAxOCAyNCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC4uLi4uLi4kPGJy
PsKgIMKgIMKgIMKgIFRhZyAzMzogbGVuIDI8YnI+wqAgwqAgwqAgwqAgwqAgwqAgMDAgMGYgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAuLjxicj7CoCDCoCDCoCDCoCBUYWcgMzY6IGxlbiA1MDxicj7CoCDCoCDCoCDCoCDCoCDC
oCAyNCAwMSAyOCAwMSAyYyAwMSAzMCAwMSAzNCAwMSAzOCAwMSAzYyAwMSA0MCAwMSDCoCQuKC4s
LjAuNC44LiZsdDsuQC48YnI+wqAgwqAgwqAgwqAgwqAgwqAgNjQgMDEgNjggMDEgNmMgMDEgNzAg
MDEgNzQgMDEgNzggMDEgN2MgMDEgODAgMDEgwqBkLmgubC5wLnQueC58Li4uPGJyPsKgIMKgIMKg
IMKgIMKgIMKgIDg0IDAxIDg4IDAxIDhjIDAxIDkwIDAxIDk1IDAxIDk5IDAxIDlkIDAxIGExIDAx
IMKgLi4uLi4uLi4uLi4uLi4uLjxicj7CoCDCoCDCoCDCoCDCoCDCoCBhNSAwMSDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC4u
PGJyPsKgIMKgIMKgIMKgIFJTTjo8YnI+wqAgwqAgwqAgwqAgwqAgwqAgR3JvdXAgRGF0YSBDaXBo
ZXIgU3VpdGU6IGxlbiA0PGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIENDTVAgKDAwOjBmOmFj
KSBzdWl0ZSDCoDA0PGJyPsKgIMKgIMKgIMKgIMKgIMKgIFBhaXJ3aXNlIENpcGhlciBTdWl0ZTog
bGVuIDQ8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQ0NNUCAoMDA6MGY6YWMpIHN1aXRlIMKg
MDQ8YnI+wqAgwqAgwqAgwqAgwqAgwqAgQUtNIFN1aXRlOiBsZW4gNDxicj7CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBQU0s7IFJTTkEgUFNLICgwMDowZjphYykgc3VpdGUgwqAwMjxicj7CoCDCoCDC
oCDCoCDCoCDCoCBSU04gY2FwYWJpbGl0aWVzOiBiaXRzIMKgMiAtIDM6IDEgcmVwbGF5IGNvdW50
ZXIgcGVyIFBUS1NBPGJyPsKgIMKgIMKgIMKgIMKgIMKgIFJTTiBjYXBhYmlsaXRpZXM6IGJpdHMg
wqA0IC0gNTogMSByZXBsYXkgY291bnRlciBwZXIgR1RLU0E8YnI+wqAgwqAgwqAgwqAgwqAgwqAg
MDEgMDAgMDAgMGYgYWMgMDQgMDEgMDAgMDAgMGYgYWMgMDQgMDEgMDAgMDAgMGYgwqAuLi4uLi4u
Li4uLi4uLi4uPGJyPsKgIMKgIMKgIMKgIMKgIMKgIGFjIDAyIDAwIDAwIDAwIDAwIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLi4uLi4uPGJyPsKgIMKgIMKg
IMKgIEV4dGVuZGVkIHN1cHBvcnRlZCByYXRlczo8YnI+wqAgwqAgwqAgwqAgwqAgwqAgMjQuMCAz
Ni4wIDQ4LjAgNTQuMCBNYml0L3M8YnI+wqAgwqAgwqAgwqAgwqAgwqAgMzAgNDggNjAgNmMgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAwSGBs
PGJyPsKgIMKgIMKgIMKgIFJNIEVuYWJsZWQgQ2FwYWJpbGl0aWVzOiBsZW4gNTxicj7CoCDCoCDC
oCDCoCDCoCDCoCBFbmFibGVkOiBiaXQgwqAxOiBOZWlnaGJvciBSZXBvcnQ8YnI+wqAgwqAgwqAg
wqAgwqAgwqAgRW5hYmxlZDogYml0IMKgNDogQmVhY29uIFBhc3NpdmUgTWVhc3VyZW1lbnQ8YnI+
wqAgwqAgwqAgwqAgwqAgwqAgRW5hYmxlZDogYml0IMKgNTogQmVhY29uIEFjdGl2ZSBNZWFzdXJl
bWVudDxicj7CoCDCoCDCoCDCoCDCoCDCoCBFbmFibGVkOiBiaXQgwqA2OiBCZWFjb24gVGFibGUg
TWVhc3VyZW1lbnQ8YnI+wqAgwqAgwqAgwqAgwqAgwqAgT3BlcmF0aW5nIENoYW5uZWwgTWF4IE1l
YXN1cmVtZW50IER1cmF0aW9uOiAwPGJyPsKgIMKgIMKgIMKgIMKgIMKgIE5vbi1PcGVyYXRpbmcg
Q2hhbm5lbCBNYXggTWVhc3VyZW1lbnQgRHVyYXRpb246IDA8YnI+wqAgwqAgwqAgwqAgwqAgwqAg
TWVhc3VyZW1lbnQgUGlsb3QgQ2FwYWJpbGl0eTogMDxicj7CoCDCoCDCoCDCoCDCoCDCoCA3MiAw
MCAwMCAwMCAwMCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCByLi4uLjxicj7CoCDCoCDCoCDCoCBFeHRlbmRlZCB5Q2FwYWJpbGl0aWVzOiBsZW4gMTA8
YnI+wqAgwqAgwqAgwqAgwqAgwqAgQ2FwYWJpbGl0eTogYml0IMKgMjogRXh0ZW5kZWQgY2hhbm5l
bCBzd2l0Y2hpbmc8YnI+wqAgwqAgwqAgwqAgwqAgwqAgQ2FwYWJpbGl0eTogYml0IDE5OiBCU1Mg
dHJhbnNpdGlvbjxicj7CoCDCoCDCoCDCoCDCoCDCoCBDYXBhYmlsaXR5OiBiaXQgMjI6IE11bHRp
cGxlIEJTU0lEPGJyPsKgIMKgIMKgIMKgIMKgIMKgIENhcGFiaWxpdHk6IGJpdCAyMzogVGltaW5n
IG1lYXN1cmVtZW50PGJyPsKgIMKgIMKgIMKgIMKgIMKgIENhcGFiaWxpdHk6IGJpdCAzMTogSW50
ZXJ3b3JraW5nPGJyPsKgIMKgIMKgIMKgIMKgIMKgIENhcGFiaWxpdHk6IGJpdCAzMjogUW9TIE1h
cDxicj7CoCDCoCDCoCDCoCDCoCDCoCBDYXBhYmlsaXR5OiBiaXQgNDY6IFdOTS0gTm90aWZpY2F0
aW9uPGJyPsKgIMKgIMKgIMKgIMKgIMKgIDA0IDAwIGM4IDgwIDAxIDQwIDAwIDAwIDAwIDAwIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLi4uLi5ALi4uLjxicj4mbHQ7IFJlcXVlc3Q6IFNl
dCBTdGF0aW9uICgweDEyKSBsZW4gMzIgW2Fja10gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMTYxMTg4MjYyMi42OTYzNzI8YnI+wqAgwqAgSW50ZXJm
YWNlIEluZGV4OiAzICgweDAwMDAwMDAzKTxicj7CoCDCoCBNQUMgQWRkcmVzcyA2MDpGMjo2MjpB
RTo3MDpGRTxicj7CoCDCoCBTdGF0aW9uIEZsYWdzIDI6IGxlbiA4PGJyPsKgIMKgIMKgIMKgIE1h
c2s6IDB4MDAwMDAwMDI8YnI+wqAgwqAgwqAgwqAgwqAgwqAgQXV0aG9yaXplZDxicj7CoCDCoCDC
oCDCoCBTZXQ6IDB4MDAwMDAwMDA8YnI+Jmd0OyBSZXNwb25zZTogU2V0IFN0YXRpb24gKDB4MTIp
IGxlbiA0IFtyb290XSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDE2MTE4ODI2MjIuNjk3MjU1PGJyPsKgIMKgIFN0YXR1czogU3VjY2VzcyAoMCk8YnI+
Jmx0OyBSZXF1ZXN0OiBOZXcgS2V5ICgweDBiKSBsZW4gNDggW2Fja10gwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMTYxMTg4MjYyMi42OTcz
NTk8YnI+wqAgwqAgSW50ZXJmYWNlIEluZGV4OiAzICgweDAwMDAwMDAzKTxicj7CoCDCoCBLZXk6
IGxlbiAzNjxicj7CoCDCoCDCoCDCoCAxNCAwMCAwMSAwMCBjNCA3OSA0OSA3OSA1NiA4ZiA5MCBm
MyBkNyA5YSBiZSA3MyDCoC4uLi4ueUl5Vi4uLi4uLnM8YnI+wqAgwqAgwqAgwqAgOGEgYmEgNmUg
NmYgMDggMDAgMDMgMDAgMDQgYWMgMGYgMDAgMDUgMDAgMDIgMDAgwqAuLm5vLi4uLi4uLi4uLi4u
PGJyPsKgIMKgIMKgIMKgIDAxIDAwIDAwIDAwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLi4uLjxicj4mZ3Q7IFJlc3BvbnNlOiBOZXcgS2V5
ICgweDBiKSBsZW4gNCBbMHgxMDBdIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIDE2MTE4ODI2MjIuNjk4OTQzPGJyPsKgIMKgIFN0YXR1czogU3Vj
Y2VzcyAoMCk8YnI+Jmx0OyBSZXF1ZXN0OiBTZXQgS2V5ICgweDBhKSBsZW4gMzIgW2Fja10gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMTYx
MTg4MjYyMi42OTkwMTE8YnI+wqAgwqAgSW50ZXJmYWNlIEluZGV4OiAzICgweDAwMDAwMDAzKTxi
cj7CoCDCoCBLZXk6IGxlbiAyMDxicj7CoCDCoCDCoCDCoCAwNSAwMCAwMiAwMCAwMSAwMCAwMCAw
MCAwNCAwMCAwNSAwMCAwOCAwMCAwOCA4MCDCoC4uLi4uLi4uLi4uLi4uLi48YnI+wqAgwqAgwqAg
wqAgMDQgMDAgMDIgMDAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAuLi4uPGJyPiZndDsgUmVzcG9uc2U6IFNldCBLZXkgKDB4MGEpIGxlbiA0
IFsweDEwMF0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgMTYxMTg4MjYyMi42OTk3MjU8YnI+wqAgwqAgU3RhdHVzOiBTdWNjZXNzICgwKTxicj4m
bHQ7IFJlcXVlc3Q6IEdldCBLZXkgKDB4MDkpIGxlbiAxNiBbYWNrXSDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAxNjExODgyNjIyLjY5OTc4
Mjxicj7CoCDCoCBJbnRlcmZhY2UgSW5kZXg6IDMgKDB4MDAwMDAwMDMpPGJyPsKgIMKgIEtleSBJ
bmRleDogMSAoMHgwMSk8YnI+Jmd0OyBSZXN1bHQ6IE5ldyBLZXkgKDB4MGIpIGxlbiA0NCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDE2MTE4ODI2MjIuNzAwMjQ4PGJyPsKgIMKgIEludGVyZmFjZSBJbmRleDogMyAoMHgw
MDAwMDAwMyk8YnI+wqAgwqAgS2V5IEluZGV4OiAxICgweDAxKTxicj7CoCDCoCBLZXkgQ2lwaGVy
OiBCSVAgKDAwOjBmOmFjKSBzdWl0ZSDCoDA2PGJyPsKgIMKgIEtleTogbGVuIDE2PGJyPsKgIMKg
IMKgIMKgIDA4IDAwIDAzIDAwIDA2IGFjIDBmIDAwIDA1IDAwIDAyIDAwIDAxIDAwIDAwIDAwIMKg
Li4uLi4uLi4uLi4uLi4uLjxicj4mbHQ7IFBBRTogbGVuIDEyMSDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDAuNzAwNTcwPGJyPsKgIMKgIEludGVyZmFj
ZSBJbmRleDogMzxicj7CoCDCoCBFQVBvTDogbGVuIDEyMTxicj7CoCDCoCDCoCDCoCBQcm90b2Nv
bCBWZXJzaW9uOiAyICg4MDIuMVgtMjAwNCk8YnI+wqAgwqAgwqAgwqAgVHlwZTogMyAoS2V5KTxi
cj7CoCDCoCDCoCDCoCBMZW5ndGg6IDExNzxicj7CoCDCoCDCoCDCoCBEZXNjcmlwdG9yIFR5cGU6
IDI8YnI+wqAgwqAgwqAgwqAgS2V5IE1JQzogZmFsc2U8YnI+wqAgwqAgwqAgwqAgU2VjdXJlOiBm
YWxzZTxicj7CoCDCoCDCoCDCoCBFcnJvcjogZmFsc2U8YnI+wqAgwqAgwqAgwqAgUmVxdWVzdDog
ZmFsc2U8YnI+wqAgwqAgwqAgwqAgRW5jcnlwdGVkIEtleSBEYXRhOiBmYWxzZTxicj7CoCDCoCDC
oCDCoCBTTUsgTWVzc2FnZTogZmFsc2U8YnI+wqAgwqAgwqAgwqAgS2V5IERlc2NyaXB0b3IgVmVy
c2lvbjogMiAoMDIpPGJyPsKgIMKgIMKgIMKgIEtleSBUeXBlOiB0cnVlPGJyPsKgIMKgIMKgIMKg
IEluc3RhbGw6IGZhbHNlPGJyPsKgIMKgIMKgIMKgIEtleSBBQ0s6IHRydWU8YnI+wqAgwqAgwqAg
wqAgS2V5IExlbmd0aDogMTY8YnI+wqAgwqAgwqAgwqAgS2V5IFJlcGxheSBDb3VudGVyOiAxPGJy
PsKgIMKgIMKgIMKgIEtleSBOT05DRTxicj7CoCDCoCDCoCDCoCDCoCDCoCA0NyA2ZSAyZCA5MyA3
MyA4NCAyMiBmMSAxYyA2YSA1ZCAzZCA5NSBlNCA5YiA3NCDCoEduLS5zLiZxdW90Oy4ual09Li4u
dDxicj7CoCDCoCDCoCDCoCDCoCDCoCA1ZCBmOCBkNSA0OCAwNiA3YSBlOCA0OSAyZSA0NCA5OCA5
OCA1OSBjNyA5MiAwMCDCoF0uLkguei5JLkQuLlkuLi48YnI+wqAgwqAgwqAgwqAgS2V5IElWPGJy
PsKgIMKgIMKgIMKgIMKgIMKgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIMKgLi4uLi4uLi4uLi4uLi4uLjxicj7CoCDCoCDCoCDCoCBLZXkgUlNDPGJyPsKg
IMKgIMKgIMKgIMKgIMKgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgLi4uLi4uLi48YnI+wqAgwqAgwqAgwqAgS2V5IE1JQyBEYXRh
PGJyPsKgIMKgIMKgIMKgIMKgIMKgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIMKgLi4uLi4uLi4uLi4uLi4uLjxicj7CoCDCoCDCoCDCoCBLZXkgRGF0YTog
bGVuIDIyPGJyPsKgIMKgIMKgIMKgIMKgIMKgIFZlbmRvciBzcGVjaWZpYzogbGVuIDIwPGJyPsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIElFRUUgODAyLjExICgwMDowZjphYykgdHlwZTogMDQ8YnI+
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUE1LSUQgS0RFPGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIDAwIDBmIGFjIDA0IDU0IDcyIDY1IDYyIDVjIDRiIGU0IDQwIDYwIDAxIDljIGU4IMKgLi4u
LlRyZWJcSy5AYC4uLjxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA1ZiAzMyAwZiA3OCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF8zLng8
YnI+wqAgwqAgwqAgwqAgMDIgMDMgMDAgNzUgMDIgMDAgOGEgMDAgMTAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgwqAuLi51Li4uLi4uLi4uLi4uPGJyPsKgIMKgIMKgIMKgIDAxIDQ3IDZlIDJkIDkzIDcz
IDg0IDIyIGYxIDFjIDZhIDVkIDNkIDk1IGU0IDliIMKgLkduLS5zLiZxdW90Oy4ual09Li4uPGJy
PsKgIMKgIMKgIMKgIDc0IDVkIGY4IGQ1IDQ4IDA2IDdhIGU4IDQ5IDJlIDQ0IDk4IDk4IDU5IGM3
IDkyIMKgdF0uLkguei5JLkQuLlkuLjxicj7CoCDCoCDCoCDCoCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCDCoC4uLi4uLi4uLi4uLi4uLi48YnI+wqAgwqAg
wqAgwqAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgwqAu
Li4uLi4uLi4uLi4uLi4uPGJyPsKgIMKgIMKgIMKgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIMKgLi4uLi4uLi4uLi4uLi4uLjxicj7CoCDCoCDCoCDCoCAw
MCAwMCAxNiBkZCAxNCAwMCAwZiBhYyAwNCA1NCA3MiA2NSA2MiA1YyA0YiBlNCDCoC4uLi4uLi4u
LlRyZWJcSy48YnI+wqAgwqAgwqAgwqAgNDAgNjAgMDEgOWMgZTggNWYgMzMgMGYgNzggwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQGAuLi5fMy54PGJyPiZndDsgUmVzcG9uc2U6IEdl
dCBLZXkgKDB4MDkpIGxlbiA0IFsweDEwMF0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAwLjcwMDI2Nzxicj7CoCDCoCBT
dGF0dXM6IFN1Y2Nlc3MgKDApPGJyPiZndDsgUEFFOiBsZW4gMTIzIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMC43MDc1ODg8YnI+wqAgwqAgSW50ZXJm
YWNlIEluZGV4OiAzPGJyPsKgIMKgIEVBUG9MOiBsZW4gMTIzPGJyPsKgIMKgIMKgIMKgIFByb3Rv
Y29sIFZlcnNpb246IDEgKDgwMi4xWC0yMDAxKTxicj7CoCDCoCDCoCDCoCBUeXBlOiAzIChLZXkp
PGJyPsKgIMKgIMKgIMKgIExlbmd0aDogMTE5PGJyPsKgIMKgIMKgIMKgIERlc2NyaXB0b3IgVHlw
ZTogMjxicj7CoCDCoCDCoCDCoCBLZXkgTUlDOiB0cnVlPGJyPsKgIMKgIMKgIMKgIFNlY3VyZTog
ZmFsc2U8YnI+wqAgwqAgwqAgwqAgRXJyb3I6IGZhbHNlPGJyPsKgIMKgIMKgIMKgIFJlcXVlc3Q6
IGZhbHNlPGJyPsKgIMKgIMKgIMKgIEVuY3J5cHRlZCBLZXkgRGF0YTogZmFsc2U8YnI+wqAgwqAg
wqAgwqAgU01LIE1lc3NhZ2U6IGZhbHNlPGJyPsKgIMKgIMKgIMKgIEtleSBEZXNjcmlwdG9yIFZl
cnNpb246IDIgKDAyKTxicj7CoCDCoCDCoCDCoCBLZXkgVHlwZTogdHJ1ZTxicj7CoCDCoCDCoCDC
oCBJbnN0YWxsOiBmYWxzZTxicj7CoCDCoCDCoCDCoCBLZXkgQUNLOiBmYWxzZTxicj7CoCDCoCDC
oCDCoCBLZXkgTGVuZ3RoOiAwPGJyPsKgIMKgIMKgIMKgIEtleSBSZXBsYXkgQ291bnRlcjogMTxi
cj7CoCDCoCDCoCDCoCBLZXkgTk9OQ0U8YnI+wqAgwqAgwqAgwqAgwqAgwqAgMjkgN2EgYTkgYzMg
ODQgYzYgZWQgMDYgYzAgMDAgNzUgNjggNTcgM2QgMTYgNzggwqApei4uLi4uLi4udWhXPS54PGJy
PsKgIMKgIMKgIMKgIMKgIMKgIGQ0IDNlIDFlIDYyIDFkIDQ4IDVkIGM2IDAxIGRhIGEwIDhmIDdm
IDE2IGIzIGNkIMKgLiZndDsuYi5IXS4uLi4uLi4uLjxicj7CoCDCoCDCoCDCoCBLZXkgSVY8YnI+
wqAgwqAgwqAgwqAgwqAgwqAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgwqAuLi4uLi4uLi4uLi4uLi4uPGJyPsKgIMKgIMKgIMKgIEtleSBSU0M8YnI+wqAg
wqAgwqAgwqAgwqAgwqAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAuLi4uLi4uLjxicj7CoCDCoCDCoCDCoCBLZXkgTUlDIERhdGE8
YnI+wqAgwqAgwqAgwqAgwqAgwqAgY2YgYWEgMzQgODIgNjUgMjggOTMgYTcgNjIgYzIgMGEgYjQg
ZTAgZDkgZGQgNTkgwqAuLjQuZSguLmIuLi4uLi5ZPGJyPsKgIMKgIMKgIMKgIEtleSBEYXRhOiBs
ZW4gMjQ8YnI+wqAgwqAgwqAgwqAgwqAgwqAgUlNOOjxicj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBHcm91cCBEYXRhIENpcGhlciBTdWl0ZTogbGVuIDQ8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgQ0NNUCAoMDA6MGY6YWMpIHN1aXRlIMKgMDQ8YnI+wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgUGFpcndpc2UgQ2lwaGVyIFN1aXRlOiBsZW4gNDxicj7CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBDQ01QICgwMDowZjphYykgc3VpdGUgwqAwNDxicj7CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBBS00gU3VpdGU6IGxlbiA0PGJyPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IFBTSzsgUlNOQSBQU0sgKDAwOjBmOmFjKSBzdWl0ZSDCoDAyPGJyPsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIFJTTiBjYXBhYmlsaXRpZXM6IGJpdHMgwqAyIC0gMzogMSByZXBsYXkgY291bnRlciBw
ZXIgUFRLU0E8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgUlNOIGNhcGFiaWxpdGllczogYml0
cyDCoDQgLSA1OiAxIHJlcGxheSBjb3VudGVyIHBlciBHVEtTQTxicj7CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAwMSAwMCAwMCAwZiBhYyAwNCAwMSAwMCAwMCAwZiBhYyAwNCAwMSAwMCAwMCAwZiDC
oC4uLi4uLi4uLi4uLi4uLi48YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYWMgMDIgMDAgMDAg
MDAgMDAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuLi4u
Li48YnI+wqAgwqAgwqAgwqAgMDEgMDMgMDAgNzcgMDIgMDEgMGEgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgwqAuLi53Li4uLi4uLi4uLi4uPGJyPsKgIMKgIMKgIMKgIDAxIDI5IDdhIGE5IGMz
IDg0IGM2IGVkIDA2IGMwIDAwIDc1IDY4IDU3IDNkIDE2IMKgLil6Li4uLi4uLi51aFc9Ljxicj7C
oCDCoCDCoCDCoCA3OCBkNCAzZSAxZSA2MiAxZCA0OCA1ZCBjNiAwMSBkYSBhMCA4ZiA3ZiAxNiBi
MyDCoHguJmd0Oy5iLkhdLi4uLi4uLi48YnI+wqAgwqAgwqAgwqAgY2QgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgwqAuLi4uLi4uLi4uLi4uLi4uPGJyPsKgIMKg
IMKgIMKgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIMKg
Li4uLi4uLi4uLi4uLi4uLjxicj7CoCDCoCDCoCDCoCAwMCBjZiBhYSAzNCA4MiA2NSAyOCA5MyBh
NyA2MiBjMiAwYSBiNCBlMCBkOSBkZCDCoC4uLjQuZSguLmIuLi4uLi48YnI+wqAgwqAgwqAgwqAg
NTkgMDAgMTggMzAgMTYgMDEgMDAgMDAgMGYgYWMgMDQgMDEgMDAgMDAgMGYgYWMgwqBZLi4wLi4u
Li4uLi4uLi4uPGJyPsKgIMKgIMKgIMKgIDA0IDAxIDAwIDAwIDBmIGFjIDAyIDAwIDAwIDAwIDAw
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC4uLi4uLi4uLi4uPGJyPiZsdDsgUEFFOiBsZW4gMTU1
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMC43MDg2
OTc8YnI+wqAgwqAgSW50ZXJmYWNlIEluZGV4OiAzPGJyPsKgIMKgIEVBUG9MOiBsZW4gMTU1PGJy
PsKgIMKgIMKgIMKgIFByb3RvY29sIFZlcnNpb246IDIgKDgwMi4xWC0yMDA0KTxicj7CoCDCoCDC
oCDCoCBUeXBlOiAzIChLZXkpPGJyPsKgIMKgIMKgIMKgIExlbmd0aDogMTUxPGJyPsKgIMKgIMKg
IMKgIERlc2NyaXB0b3IgVHlwZTogMjxicj7CoCDCoCDCoCDCoCBLZXkgTUlDOiB0cnVlPGJyPsKg
IMKgIMKgIMKgIFNlY3VyZTogdHJ1ZTxicj7CoCDCoCDCoCDCoCBFcnJvcjogZmFsc2U8YnI+wqAg
wqAgwqAgwqAgUmVxdWVzdDogZmFsc2U8YnI+wqAgwqAgwqAgwqAgRW5jcnlwdGVkIEtleSBEYXRh
OiB0cnVlPGJyPsKgIMKgIMKgIMKgIFNNSyBNZXNzYWdlOiBmYWxzZTxicj7CoCDCoCDCoCDCoCBL
ZXkgRGVzY3JpcHRvciBWZXJzaW9uOiAyICgwMik8YnI+wqAgwqAgwqAgwqAgS2V5IFR5cGU6IHRy
dWU8YnI+wqAgwqAgwqAgwqAgSW5zdGFsbDogdHJ1ZTxicj7CoCDCoCDCoCDCoCBLZXkgQUNLOiB0
cnVlPGJyPsKgIMKgIMKgIMKgIEtleSBMZW5ndGg6IDE2PGJyPsKgIMKgIMKgIMKgIEtleSBSZXBs
YXkgQ291bnRlcjogMjxicj7CoCDCoCDCoCDCoCBLZXkgTk9OQ0U8YnI+wqAgwqAgwqAgwqAgwqAg
wqAgNDcgNmUgMmQgOTMgNzMgODQgMjIgZjEgMWMgNmEgNWQgM2QgOTUgZTQgOWIgNzQgwqBHbi0u
cy4mcXVvdDsuLmpdPS4uLnQ8YnI+wqAgwqAgwqAgwqAgwqAgwqAgNWQgZjggZDUgNDggMDYgN2Eg
ZTggNDkgMmUgNDQgOTggOTggNTkgYzcgOTIgMDAgwqBdLi5ILnouSS5ELi5ZLi4uPGJyPsKgIMKg
IMKgIMKgIEtleSBJVjxicj7CoCDCoCDCoCDCoCDCoCDCoCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCDCoC4uLi4uLi4uLi4uLi4uLi48YnI+wqAgwqAgwqAg
wqAgS2V5IFJTQzxicj7CoCDCoCDCoCDCoCDCoCDCoCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC4uLi4uLi4uPGJyPsKgIMKgIMKg
IMKgIEtleSBNSUMgRGF0YTxicj7CoCDCoCDCoCDCoCDCoCDCoCA2ZSBiMCBlYiBmOCA4MyBmOCAy
MCAzMSBhZCBiOCA5NiBkZiBiZiA3ZiA4ZiA3NSDCoG4uLi4uLiAxLi4uLi4uLnU8YnI+wqAgwqAg
wqAgwqAgS2V5IERhdGE6IGxlbiA1Njxicj7CoCDCoCDCoCDCoCDCoCDCoCBjZCBkNyA5NCA0MCBl
MiA3ZCA5ZSA2MyBkYyBmMyBmYSBiMSAzZSBmNCBjNyAzYSDCoC4uLkAufS5jLi4uLiZndDsuLjo8
YnI+wqAgwqAgwqAgwqAgwqAgwqAgZWMgODEgNDYgNmEgYTkgZWEgNmUgYjMgZWQgMjIgZDcgODEg
ZjcgY2YgNjAgZmMgwqAuLkZqLi5uLi4mcXVvdDsuLi4uYC48YnI+wqAgwqAgwqAgwqAgwqAgwqAg
NjQgMzEgZDIgOWUgMWIgNDQgZGEgN2EgNTAgZmYgMDUgYWEgMjUgNTEgMmYgOGUgwqBkMS4uLkQu
elAuLi4lUS8uPGJyPsKgIMKgIMKgIMKgIMKgIMKgIGY1IGQyIGQ0IDk2IGI0IDY1IGQzIDQxIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLi4uLi5lLkE8YnI+wqAgwqAgwqAg
wqAgMDIgMDMgMDAgOTcgMDIgMTMgY2EgMDAgMTAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgwqAuLi4u
Li4uLi4uLi4uLi4uPGJyPsKgIMKgIMKgIMKgIDAyIDQ3IDZlIDJkIDkzIDczIDg0IDIyIGYxIDFj
IDZhIDVkIDNkIDk1IGU0IDliIMKgLkduLS5zLiZxdW90Oy4ual09Li4uPGJyPsKgIMKgIMKgIMKg
IDc0IDVkIGY4IGQ1IDQ4IDA2IDdhIGU4IDQ5IDJlIDQ0IDk4IDk4IDU5IGM3IDkyIMKgdF0uLkgu
ei5JLkQuLlkuLjxicj7CoCDCoCDCoCDCoCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCDCoC4uLi4uLi4uLi4uLi4uLi48YnI+wqAgwqAgwqAgwqAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgwqAuLi4uLi4uLi4uLi4u
Li4uPGJyPsKgIMKgIMKgIMKgIDAwIDZlIGIwIGViIGY4IDgzIGY4IDIwIDMxIGFkIGI4IDk2IGRm
IGJmIDdmIDhmIMKgLm4uLi4uLiAxLi4uLi4uLjxicj7CoCDCoCDCoCDCoCA3NSAwMCAzOCBjZCBk
NyA5NCA0MCBlMiA3ZCA5ZSA2MyBkYyBmMyBmYSBiMSAzZSDCoHUuOC4uLkAufS5jLi4uLiZndDs8
YnI+wqAgwqAgwqAgwqAgZjQgYzcgM2EgZWMgODEgNDYgNmEgYTkgZWEgNmUgYjMgZWQgMjIgZDcg
ODEgZjcgwqAuLjouLkZqLi5uLi4mcXVvdDsuLi48YnI+wqAgwqAgwqAgwqAgY2YgNjAgZmMgNjQg
MzEgZDIgOWUgMWIgNDQgZGEgN2EgNTAgZmYgMDUgYWEgMjUgwqAuYC5kMS4uLkQuelAuLi4lPGJy
PsKgIMKgIMKgIMKgIDUxIDJmIDhlIGY1IGQyIGQ0IDk2IGI0IDY1IGQzIDQxIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIFEvLi4uLi4uZS5BPGJyPiZndDsgUEFFOiBsZW4gOTkgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMC43MTcyMzc8YnI+wqAgwqAg
SW50ZXJmYWNlIEluZGV4OiAzPGJyPsKgIMKgIEVBUG9MOiBsZW4gOTk8YnI+wqAgwqAgwqAgwqAg
UHJvdG9jb2wgVmVyc2lvbjogMSAoODAyLjFYLTIwMDEpPGJyPsKgIMKgIMKgIMKgIFR5cGU6IDMg
KEtleSk8YnI+wqAgwqAgwqAgwqAgTGVuZ3RoOiA5NTxicj7CoCDCoCDCoCDCoCBEZXNjcmlwdG9y
IFR5cGU6IDI8YnI+wqAgwqAgwqAgwqAgS2V5IE1JQzogdHJ1ZTxicj7CoCDCoCDCoCDCoCBTZWN1
cmU6IHRydWU8YnI+wqAgwqAgwqAgwqAgRXJyb3I6IGZhbHNlPGJyPsKgIMKgIMKgIMKgIFJlcXVl
c3Q6IGZhbHNlPGJyPsKgIMKgIMKgIMKgIEVuY3J5cHRlZCBLZXkgRGF0YTogZmFsc2U8YnI+wqAg
wqAgwqAgwqAgU01LIE1lc3NhZ2U6IGZhbHNlPGJyPsKgIMKgIMKgIMKgIEtleSBEZXNjcmlwdG9y
IFZlcnNpb246IDIgKDAyKTxicj7CoCDCoCDCoCDCoCBLZXkgVHlwZTogdHJ1ZTxicj7CoCDCoCDC
oCDCoCBJbnN0YWxsOiBmYWxzZTxicj7CoCDCoCDCoCDCoCBLZXkgQUNLOiBmYWxzZTxicj7CoCDC
oCDCoCDCoCBLZXkgTGVuZ3RoOiAwPGJyPsKgIMKgIMKgIMKgIEtleSBSZXBsYXkgQ291bnRlcjog
Mjxicj7CoCDCoCDCoCDCoCBLZXkgTk9OQ0U8YnI+wqAgwqAgwqAgwqAgwqAgwqAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgwqAuLi4uLi4uLi4uLi4uLi4u
PGJyPsKgIMKgIMKgIMKgIMKgIMKgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIMKgLi4uLi4uLi4uLi4uLi4uLjxicj7CoCDCoCDCoCDCoCBLZXkgSVY8YnI+
wqAgwqAgwqAgwqAgwqAgwqAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgwqAuLi4uLi4uLi4uLi4uLi4uPGJyPsKgIMKgIMKgIMKgIEtleSBSU0M8YnI+wqAg
wqAgwqAgwqAgwqAgwqAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAuLi4uLi4uLjxicj7CoCDCoCDCoCDCoCBLZXkgTUlDIERhdGE8
YnI+wqAgwqAgwqAgwqAgwqAgwqAgNTggNjEgOGYgNGEgZmIgNzkgNGUgYTUgNTggMzYgMzEgMGUg
YjcgNzEgYzMgNGYgwqBYYS5KLnlOLlg2MS4ucS5PPGJyPsKgIMKgIMKgIMKgIEtleSBEYXRhOiBs
ZW4gMDxicj7CoCDCoCDCoCDCoCAwMSAwMyAwMCA1ZiAwMiAwMyAwYSAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCDCoC4uLl8uLi4uLi4uLi4uLi48YnI+wqAgwqAgwqAgwqAgMDIgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgwqAuLi4uLi4uLi4uLi4uLi4uPGJy
PsKgIMKgIMKgIMKgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIMKgLi4uLi4uLi4uLi4uLi4uLjxicj7CoCDCoCDCoCDCoCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCDCoC4uLi4uLi4uLi4uLi4uLi48YnI+wqAgwqAg
wqAgwqAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgwqAu
Li4uLi4uLi4uLi4uLi4uPGJyPsKgIMKgIMKgIMKgIDAwIDU4IDYxIDhmIDRhIGZiIDc5IDRlIGE1
IDU4IDM2IDMxIDBlIGI3IDcxIGMzIMKgLlhhLkoueU4uWDYxLi5xLjxicj7CoCDCoCDCoCDCoCA0
ZiAwMCAwMCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBPLi48YnI+Jmx0OyBSZXF1ZXN0OiBOZXcgS2V5ICgweDBiKSBsZW4gNTYgW2Fj
a10gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAwLjcxNzUyNzxicj7CoCDCoCBLZXkgRGF0YTogbGVuIDE2PGJyPsKg
IMKgIMKgIMKgIGFiIGFhIGNkIDM3IDJlIGVmIDk3IDdmIDE1IGY4IDcyIGE1IDkwIDJjIGMwIDIw
IMKgLi4uNy4uLi4uLnIuLiwuPGJyPsKgIMKgIEtleSBDaXBoZXI6IENDTVAgKDAwOjBmOmFjKSBz
dWl0ZSDCoDA0PGJyPsKgIMKgIE1BQyBBZGRyZXNzIDYwOkYyOjYyOkFFOjcwOkZFPGJyPsKgIMKg
IEtleSBJbmRleDogMCAoMHgwMCk8YnI+wqAgwqAgSW50ZXJmYWNlIEluZGV4OiAzICgweDAwMDAw
MDAzKTxicj4mZ3Q7IFJlc3BvbnNlOiBOZXcgS2V5ICgweDBiKSBsZW4gNCBbMHgxMDBdIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgMC43MTgyMDA8YnI+wqAgwqAgU3RhdHVzOiBTdWNjZXNzICgwKTxicj4mbHQ7IFJlcXVl
c3Q6IFNldCBTdGF0aW9uICgweDEyKSBsZW4gMzIgW2Fja10gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAwLjcxODI1Njxicj7C
oCDCoCBJbnRlcmZhY2UgSW5kZXg6IDMgKDB4MDAwMDAwMDMpPGJyPsKgIMKgIE1BQyBBZGRyZXNz
IDYwOkYyOjYyOkFFOjcwOkZFPGJyPsKgIMKgIFN0YXRpb24gRmxhZ3MgMjogbGVuIDg8YnI+wqAg
wqAgwqAgwqAgTWFzazogMHgwMDAwMDAwMjxicj7CoCDCoCDCoCDCoCDCoCDCoCBBdXRob3JpemVk
PGJyPsKgIMKgIMKgIMKgIFNldDogMHgwMDAwMDAwMjxicj7CoCDCoCDCoCDCoCDCoCDCoCBBdXRo
b3JpemVkPGJyPiZndDsgUmVzcG9uc2U6IFNldCBTdGF0aW9uICgweDEyKSBsZW4gNCBbcm9vdF0g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgMC43MTg2MDg8YnI+wqAgwqAgU3RhdHVzOiBTdWNjZXNzICgwKTxicj4mbHQ7IFJUTkw6
IFNldCBMaW5rICgweDEzKSBsZW4gMzIgW3JlcXVlc3QsYWNrXSDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDAuNzE4NjYzPGJyPsKg
IMKgIEZsYWdzOiA1ICgweDAwNSk8YnI+wqAgwqAgU2VxdWVuY2UgbnVtYmVyOiA4ICgweDAwMDAw
MDA4KTxicj7CoCDCoCBQb3J0IElEOiA4MTIyNTxicj4mZ3Q7IFJUTkw6IE5ldyBMaW5rICgweDEw
KSBsZW4gMTMwOCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDAuNzE4ODcxPGJyPsKgIMKgIEZsYWdz
OiAwICgweDAwMCk8YnI+wqAgwqAgU2VxdWVuY2UgbnVtYmVyOiAwICgweDAwMDAwMDAwKTxicj7C
oCDCoCBQb3J0IElEOiAwPGJyPsKgIMKgIElGTEEgRmFtaWx5OiBVbmtub3duPGJyPsKgIMKgIElG
TEEgVHlwZTogMTxicj7CoCDCoCBJRkxBIEluZGV4OiAzPGJyPsKgIMKgIElGTEEgQ2hhbmdlTWFz
azogMDxicj7CoCDCoCBJRkxBIEZsYWdzOiAoMHgxMDQzKSBbdXAsYnJvYWRjYXN0LHJ1bm5pbmcs
bXVsdGljYXN0XTxicj7CoCDCoCDCoCDCoCBJZk5hbWUgKGxlbjo2KTogd2xhbjA8YnI+wqAgwqAg
wqAgwqAgVHhxbGVuOiAxMDAwICgweDAwMDAwM2U4KTxicj7CoCDCoCDCoCDCoCBPcGVyU3RhdGU6
IHVwICg2KTxicj7CoCDCoCDCoCDCoCBMaW5rTW9kZTogdXNlcnNwYWNlIGNvbnRyb2xsZWQgKDEp
PGJyPsKgIMKgIMKgIMKgIE1UVTogMTUwMCAoMHgwMDAwMDVkYyk8YnI+wqAgwqAgwqAgwqAgUmVz
ZXJ2ZWQ6IGxlbiA0PGJyPsKgIMKgIMKgIMKgIFJlc2VydmVkOiBsZW4gNDxicj7CoCDCoCDCoCDC
oCBSZXNlcnZlZDogbGVuIDQ8YnI+wqAgwqAgwqAgwqAgUmVzZXJ2ZWQ6IGxlbiA0PGJyPsKgIMKg
IMKgIMKgIFJlc2VydmVkOiBsZW4gNDxicj7CoCDCoCDCoCDCoCBSZXNlcnZlZDogbGVuIDQ8YnI+
wqAgwqAgwqAgwqAgUmVzZXJ2ZWQ6IGxlbiA0PGJyPsKgIMKgIMKgIMKgIFJlc2VydmVkOiBsZW4g
NDxicj7CoCDCoCDCoCDCoCBSZXNlcnZlZDogbGVuIDE8YnI+wqAgwqAgwqAgwqAgUWRpc2MgKGxl
bjo5KTogZnFfY29kZWw8YnI+wqAgwqAgwqAgwqAgUmVzZXJ2ZWQ6IGxlbiA0PGJyPsKgIMKgIMKg
IMKgIFJlc2VydmVkOiBsZW4gMTxicj7CoCDCoCDCoCDCoCBSZXNlcnZlZDogbGVuIDQ8YnI+wqAg
wqAgwqAgwqAgUmVzZXJ2ZWQ6IGxlbiA0PGJyPsKgIMKgIMKgIMKgIE1hcDogbGVuIDMyPGJyPsKg
IMKgIMKgIMKgIMKgIMKgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIMKgLi4uLi4uLi4uLi4uLi4uLjxicj7CoCDCoCDCoCDCoCDCoCDCoCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCDCoC4uLi4uLi4uLi4uLi4uLi48
YnI+wqAgwqAgwqAgwqAgSW50ZXJmYWNlIEFkZHJlc3M6IGI4OjI3OmViOjUyOmNjOmQwPGJyPsKg
IMKgIMKgIMKgIEJyb2FkY2FzdCBBZGRyZXNzOiBmZjpmZjpmZjpmZjpmZjpmZjxicj7CoCDCoCDC
oCDCoCBSZXNlcnZlZDogbGVuIDE5Mjxicj7CoCDCoCDCoCDCoCBTdGF0czogbGVuIDk2PGJyPsKg
IMKgIMKgIMKgIMKgIMKgIDdjIDEwIDIyIDAwIGYxIDdmIDAzIDAwIDVhIGExIGI1IDE2IGRiIGI5
IDU3IDAzIMKgfC4mcXVvdDsuLi4uLlouLi4uLlcuPGJyPsKgIMKgIMKgIMKgIMKgIMKgIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIMKgLi4uLi4uLi4uLi4u
Li4uLjxicj7CoCDCoCDCoCDCoCDCoCDCoCA0NSBmMiAxZSAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCDCoEUuLi4uLi4uLi4uLi4uLi48YnI+wqAgwqAgwqAgwqAgwqAgwqAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgwqAuLi4uLi4u
Li4uLi4uLi4uPGJyPsKgIMKgIMKgIMKgIMKgIMKgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIMKgLi4uLi4uLi4uLi4uLi4uLjxicj7CoCDCoCDCoCDCoCDC
oCDCoCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCDCoC4u
Li4uLi4uLi4uLi4uLi48YnI+wqAgwqAgwqAgwqAgUmVzZXJ2ZWQ6IGxlbiA4PGJyPsKgIMKgIMKg
IMKgIFJlc2VydmVkOiBsZW4gNzU2PGJyPiZndDsgUlROTDogTmV3IExpbmsgKDB4MTApIGxlbiAx
MzA4IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMC43MTg4ODg8YnI+wqAgwqAgRmxhZ3M6IDAgKDB4
MDAwKTxicj7CoCDCoCBTZXF1ZW5jZSBudW1iZXI6IDAgKDB4MDAwMDAwMDApPGJyPsKgIMKgIFBv
cnQgSUQ6IDA8YnI+wqAgwqAgSUZMQSBGYW1pbHk6IFVua25vd248YnI+wqAgwqAgSUZMQSBUeXBl
OiAxPGJyPsKgIMKgIElGTEEgSW5kZXg6IDM8YnI+wqAgwqAgSUZMQSBDaGFuZ2VNYXNrOiAwPGJy
PsKgIMKgIElGTEEgRmxhZ3M6ICgweDEwNDMpIFt1cCxicm9hZGNhc3QscnVubmluZyxtdWx0aWNh
c3RdPGJyPsKgIMKgIMKgIMKgIElmTmFtZSAobGVuOjYpOiB3bGFuMDxicj7CoCDCoCDCoCDCoCBU
eHFsZW46IDEwMDAgKDB4MDAwMDAzZTgpPGJyPsKgIMKgIMKgIMKgIE9wZXJTdGF0ZTogdXAgKDYp
PGJyPsKgIMKgIMKgIMKgIExpbmtNb2RlOiB1c2Vyc3BhY2UgY29udHJvbGxlZCAoMSk8YnI+wqAg
wqAgwqAgwqAgTVRVOiAxNTAwICgweDAwMDAwNWRjKTxicj7CoCDCoCDCoCDCoCBSZXNlcnZlZDog
bGVuIDQ8YnI+wqAgwqAgwqAgwqAgUmVzZXJ2ZWQ6IGxlbiA0PGJyPsKgIMKgIMKgIMKgIFJlc2Vy
dmVkOiBsZW4gNDxicj7CoCDCoCDCoCDCoCBSZXNlcnZlZDogbGVuIDQ8YnI+wqAgwqAgwqAgwqAg
UmVzZXJ2ZWQ6IGxlbiA0PGJyPsKgIMKgIMKgIMKgIFJlc2VydmVkOiBsZW4gNDxicj7CoCDCoCDC
oCDCoCBSZXNlcnZlZDogbGVuIDQ8YnI+wqAgwqAgwqAgwqAgUmVzZXJ2ZWQ6IGxlbiA0PGJyPsKg
IMKgIMKgIMKgIFJlc2VydmVkOiBsZW4gMTxicj7CoCDCoCDCoCDCoCBRZGlzYyAobGVuOjkpOiBm
cV9jb2RlbDxicj7CoCDCoCDCoCDCoCBSZXNlcnZlZDogbGVuIDQ8YnI+wqAgwqAgwqAgwqAgUmVz
ZXJ2ZWQ6IGxlbiAxPGJyPsKgIMKgIMKgIMKgIFJlc2VydmVkOiBsZW4gNDxicj7CoCDCoCDCoCDC
oCBSZXNlcnZlZDogbGVuIDQ8YnI+wqAgwqAgwqAgwqAgTWFwOiBsZW4gMzI8YnI+wqAgwqAgwqAg
wqAgwqAgwqAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
wqAuLi4uLi4uLi4uLi4uLi4uPGJyPsKgIMKgIMKgIMKgIMKgIMKgIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIMKgLi4uLi4uLi4uLi4uLi4uLjxicj7CoCDC
oCDCoCDCoCBJbnRlcmZhY2UgQWRkcmVzczogYjg6Mjc6ZWI6NTI6Y2M6ZDA8YnI+wqAgwqAgwqAg
wqAgQnJvYWRjYXN0IEFkZHJlc3M6IGZmOmZmOmZmOmZmOmZmOmZmPGJyPsKgIMKgIMKgIMKgIFJl
c2VydmVkOiBsZW4gMTkyPGJyPsKgIMKgIMKgIMKgIFN0YXRzOiBsZW4gOTY8YnI+wqAgwqAgwqAg
wqAgwqAgwqAgN2MgMTAgMjIgMDAgZjEgN2YgMDMgMDAgNWEgYTEgYjUgMTYgZGIgYjkgNTcgMDMg
wqB8LiZxdW90Oy4uLi4uWi4uLi4uVy48YnI+wqAgwqAgwqAgwqAgwqAgwqAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgwqAuLi4uLi4uLi4uLi4uLi4uPGJy
PsKgIMKgIMKgIMKgIMKgIMKgIDQ1IGYyIDFlIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIMKgRS4uLi4uLi4uLi4uLi4uLjxicj7CoCDCoCDCoCDCoCDCoCDCoCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCDCoC4uLi4uLi4uLi4uLi4u
Li48YnI+wqAgwqAgwqAgwqAgwqAgwqAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgwqAuLi4uLi4uLi4uLi4uLi4uPGJyPsKgIMKgIMKgIMKgIMKgIMKgIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIMKgLi4uLi4uLi4u
Li4uLi4uLjxicj7CoCDCoCDCoCDCoCBSZXNlcnZlZDogbGVuIDg8YnI+wqAgwqAgwqAgwqAgUmVz
ZXJ2ZWQ6IGxlbiA3NTY8YnI+Jmd0OyBSVE5MOiBOZXcgTGluayAoMHgxMCkgbGVuIDEzMDggwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAwLjcxODg5Njxicj7CoCDCoCBGbGFnczogMCAoMHgwMDApPGJy
PsKgIMKgIFNlcXVlbmNlIG51bWJlcjogMCAoMHgwMDAwMDAwMCk8YnI+wqAgwqAgUG9ydCBJRDog
MDxicj7CoCDCoCBJRkxBIEZhbWlseTogVW5rbm93bjxicj7CoCDCoCBJRkxBIFR5cGU6IDE8YnI+
wqAgwqAgSUZMQSBJbmRleDogMzxicj7CoCDCoCBJRkxBIENoYW5nZU1hc2s6IDA8YnI+wqAgwqAg
SUZMQSBGbGFnczogKDB4MTA0MykgW3VwLGJyb2FkY2FzdCxydW5uaW5nLG11bHRpY2FzdF08YnI+
wqAgwqAgwqAgwqAgSWZOYW1lIChsZW46Nik6IHdsYW4wPGJyPsKgIMKgIMKgIMKgIFR4cWxlbjog
MTAwMCAoMHgwMDAwMDNlOCk8YnI+wqAgwqAgwqAgwqAgT3BlclN0YXRlOiB1cCAoNik8YnI+wqAg
wqAgwqAgwqAgTGlua01vZGU6IHVzZXJzcGFjZSBjb250cm9sbGVkICgxKTxicj7CoCDCoCDCoCDC
oCBNVFU6IDE1MDAgKDB4MDAwMDA1ZGMpPGJyPsKgIMKgIMKgIMKgIFJlc2VydmVkOiBsZW4gNDxi
cj7CoCDCoCDCoCDCoCBSZXNlcnZlZDogbGVuIDQ8YnI+wqAgwqAgwqAgwqAgUmVzZXJ2ZWQ6IGxl
biA0PGJyPsKgIMKgIMKgIMKgIFJlc2VydmVkOiBsZW4gNDxicj7CoCDCoCDCoCDCoCBSZXNlcnZl
ZDogbGVuIDQ8YnI+wqAgwqAgwqAgwqAgUmVzZXJ2ZWQ6IGxlbiA0PGJyPsKgIMKgIMKgIMKgIFJl
c2VydmVkOiBsZW4gNDxicj7CoCDCoCDCoCDCoCBSZXNlcnZlZDogbGVuIDQ8YnI+wqAgwqAgwqAg
wqAgUmVzZXJ2ZWQ6IGxlbiAxPGJyPsKgIMKgIMKgIMKgIFFkaXNjIChsZW46OSk6IGZxX2NvZGVs
PGJyPsKgIMKgIMKgIMKgIFJlc2VydmVkOiBsZW4gNDxicj7CoCDCoCDCoCDCoCBSZXNlcnZlZDog
bGVuIDE8YnI+wqAgwqAgwqAgwqAgUmVzZXJ2ZWQ6IGxlbiA0PGJyPsKgIMKgIMKgIMKgIFJlc2Vy
dmVkOiBsZW4gNDxicj7CoCDCoCDCoCDCoCBNYXA6IGxlbiAzMjxicj7CoCDCoCDCoCDCoCDCoCDC
oCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCDCoC4uLi4u
Li4uLi4uLi4uLi48YnI+wqAgwqAgwqAgwqAgwqAgwqAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgwqAuLi4uLi4uLi4uLi4uLi4uPGJyPsKgIMKgIMKgIMKg
IEludGVyZmFjZSBBZGRyZXNzOiBiODoyNzplYjo1MjpjYzpkMDxicj7CoCDCoCDCoCDCoCBCcm9h
ZGNhc3QgQWRkcmVzczogZmY6ZmY6ZmY6ZmY6ZmY6ZmY8YnI+wqAgwqAgwqAgwqAgUmVzZXJ2ZWQ6
IGxlbiAxOTI8YnI+wqAgwqAgwqAgwqAgU3RhdHM6IGxlbiA5Njxicj7CoCDCoCDCoCDCoCDCoCDC
oCA3YyAxMCAyMiAwMCBmMSA3ZiAwMyAwMCA1YSBhMSBiNSAxNiBkYiBiOSA1NyAwMyDCoHwuJnF1
b3Q7Li4uLi5aLi4uLi5XLjxicj7CoCDCoCDCoCDCoCDCoCDCoCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCDCoC4uLi4uLi4uLi4uLi4uLi48YnI+wqAgwqAg
wqAgwqAgwqAgwqAgNDUgZjIgMWUgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgwqBFLi4uLi4uLi4uLi4uLi4uPGJyPsKgIMKgIMKgIMKgIMKgIMKgIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIMKgLi4uLi4uLi4uLi4uLi4uLjxicj7C
oCDCoCDCoCDCoCDCoCDCoCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCDCoC4uLi4uLi4uLi4uLi4uLi48YnI+wqAgwqAgwqAgwqAgwqAgwqAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgwqAuLi4uLi4uLi4uLi4uLi4u
PGJyPsKgIMKgIMKgIMKgIFJlc2VydmVkOiBsZW4gODxicj7CoCDCoCDCoCDCoCBSZXNlcnZlZDog
bGVuIDc1Njxicj4mZ3Q7IFJUTkw6IEVycm9yICgweDAyKSBsZW4gMjAgWzB4MTAwXSDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAwLjcxODkyNjxicj7CoCDCoCBGbGFnczogMjU2ICgweDEwMCk8YnI+wqAgwqAg
U2VxdWVuY2UgbnVtYmVyOiA4ICgweDAwMDAwMDA4KTxicj7CoCDCoCBQb3J0IElEOiA4MTIyNTxi
cj7CoCDCoCBBQ0s6IDA8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlN0aWxsIGdpdmVzIGFuIFJU
TkwgZXJyb3IgYnV0IEkgZG8gbm90IGtvdyB3aGF0IHRoYXQgbWVhbnMuIEFuZCBvbmNlIGNvbm5l
Y3RlZCwgSSBjb3VsZCBub3QgZGlzY29ubmVjdCBhbmQgcmVjb25uZWN0IHdpdGhvdXQgcmVzdGFy
dGluZyB0aGUgYXAuIEkgd291bGQgZ2V0IGFuIGltbWVkaWF0ZSBkc2ljb25uZWN0IGFuZCBpd21v
biBzaG93czo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PiZndDsgRXZlbnQ6IERlbCBTdGF0aW9u
ICgweDE0KSBsZW4gMzIgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA0NzQuNDM5OTI3PGJyPsKgIMKgIEludGVy
ZmFjZSBJbmRleDogMyAoMHgwMDAwMDAwMyk8YnI+wqAgwqAgTUFDIEFkZHJlc3MgNjA6RjI6NjI6
QUU6NzA6RkU8YnI+wqAgwqAgR2VuZXJhdGlvbjogMCAoMHgwMDAwMDAwMCk8YnI+wqAgwqAgU3Rh
dGlvbiBJbmZvOiBsZW4gMDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+IFdoZW4gSSByZXN0YXJ0
IHRoZSBBUCBmcm9tIGl3Y3QsIEkgY2FuIGNvbm5lY3QgYWdhaW4uIDxicj48L2Rpdj48ZGl2Pldo
YXQgSSBkbyBub3QgeWV0IGtub3cgaG93IHRvIGRvLCB0aG91Z2gsIGlzIGFzc2lnbiBhbiBpcCBh
ZGRyZXNzIHRvIHRoZSBhcCBhbmQgdGhlbiBoYXZlIGl0IGJlIGEgZGhjcCBzZXJ2ZXIgdG8gc2Vy
dmUgb3V0IGEgZGhjcCBhZGRyZXNzIHRvIHRoZSBjb25uZWN0aW5nIGNvbXB1dGVyLiBJIGZvdW5k
IHRoaXMgb25saW5lIGFuZCB0b29rIGEgc3RhYiwgYnV0IGl0IGRpZCBub3QgYXNzaWduIGFuIGFk
ZHJlc3MsIHRob3VnaCB0aGUgY29tcHV0ZXIgZGlkICYjMzk7YXR0YWNoJiMzOTsuPC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj5Ib3cgZG8geW91IHNldCBpdCB1cCBmb3IgaXdkIHRvIGJlIGEgZGhj
cCBzZXJ2ZXI/IElmIGl3ZCBjYW5ub3QgZG8gaXQsIGNhbiBJIHVzZSBkaGNwZD8gZG5zbWFzcT8g
SSBoYXZlIGZvdW5kIHZlcnkgbGl0dGxlIGluZm8gaW4gbXkgc2VhcmNoZXMuIDxicj48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rcyBmb3IgdGhpcyEgSXQgd2lsbCBoZWxwIHdpdGggYWRv
cHRpb24gb2YgaXdkIGluIHRoZSBSUGkgY29tbXVuaXR5Ljxicj48L2Rpdj48L2Rpdj4NCg==

--===============6305707490087205933==--

