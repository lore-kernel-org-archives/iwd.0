Content-Type: multipart/mixed; boundary="===============9101664887982082413=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: Wifi Tethering
Date: Sun, 24 May 2020 18:31:24 +0200
Message-ID: <6bf79364-be4c-b2a6-31ba-d370f09fe2fe@monom.org>
In-Reply-To: <CAG17S_MG7iSYXW+YJb1xS03ZNp0m=XLyZr_6JdncOmnDMkeY=Q@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9101664887982082413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 28.04.20 14:33, KeithG wrote:
> The pcap is here:
> https://drive.google.com/open?id=3D18G8cM5Ob88YENZ6WCWJjhBDREol7vW-9

The iwmon refuses to read this file, because it's of type =

PCAP_TYPE_NETLINK. The tool expects it to be of type PCAP_TYPE_LINUX_SLL =

[1].

I haven't look at what 'tcpdump -i nlmon' is supposed to do but it
doens't seem to work for me neithery. I've tried in on my system =

(following the instructions) and I also get a trace file of type =

PCAP_TYPE_NETLINK.

Changing the type check in monitor/main.c overcomes this problem:

--- a/monitor/main.c
+++ b/monitor/main.c
@@ -788,7 +788,7 @@ int main(int argc, char *argv[])
                         goto done;
                 }

-               if (pcap_get_type(pcap) !=3D PCAP_TYPE_LINUX_SLL) {
+               if (pcap_get_type(pcap) !=3D PCAP_TYPE_NETLINK) {
                         fprintf(stderr, "Invalid packet format\n");
                         exit_status =3D EXIT_FAILURE;
                 } else

With this small hack, I decoded your trace. And there is no 802.11 entry =

in it. Only routing and link setup packets.

I'd expected to see something like:

< Request: Get Wiphy (0x01) len 4 [ack,0x300] =

             16.731871
     Split Wiphy Dump: true
 > Result: New Wiphy (0x03) len 148 [multi] =

              16.731945
     Wiphy: 0 (0x00000000)
     Wiphy Name: phy0
     Generation: 1 (0x00000001)
     Wiphy Retry Short: 7 (0x07)
     Wiphy Retry Long: 4 (0x04)
     Wiphy Frag Threshold: 4294967295 (0xffffffff)
     Wiphy RTS Threshold: 4294967295 (0xffffffff)
     Wiphy Coverage Class: 0 (0x00)
     Max Number Scan SSIDs: 4 (0x04)
     Max Num Sched Scan SSIDs: 0 (0x00)
     Max Scan IE Length: 2257 (0x08d1)
     Max Sched Scan IE Len: 0 (0x0000)
     Max Match Sets: 0 (0x00)
     Reserved: len 4
         01 00 00 00                                      ....
     Reserved: len 4
         ff ff ff ff                                      ....
     Reserved: len 4
         00 00 00 00                                      ....
     Support IBSS RSN: true
     Support Mesh Auth: true
     TDLS Support: true
     TDLS External Setup: true

But there is nothing. This looks wrong to me. But now we are clearly in =

iwd's domain and not ConnMan anymore.

Thanks,
Daniel

[1] http://www.tcpdump.org/linktypes/LINKTYPE_LINUX_SLL.html
--===============9101664887982082413==--

