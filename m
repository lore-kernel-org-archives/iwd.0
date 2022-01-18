Content-Type: multipart/mixed; boundary="===============7717844588316906983=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd 1.21 stuck on connecting state
Date: Tue, 18 Jan 2022 09:39:22 -0800
Message-ID: <a37fbc925b5695daedd33be9f110d13d2776eaf3.camel@gmail.com>
In-Reply-To: 20220118114332.2807.583@ml01.vlan13.01.org

--===============7717844588316906983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

It looks like the DHCP server sent some packet that we did not accept.
There isn't enough debug printing to know what exactly so we'll need to
get a network capture PCAP and see what data it sent. You can use
tcpdump/wireshark to get this. Just ensure you see DHCP packets in the
capture.

Something like:

tcpdump -i <iface> port 67 or port 68 -s 0 -w dhcp.pcap

Thanks,
James

On Tue, 2022-01-18 at 11:43 +0000,
54d22547-afc0-4701-b1fc-5a2a2e411646(a)simplelogin.co wrote:
> These are the logs with IWD_DHCP_DEBUG=3D1.
> =

> https://termbin.com/yn9k
> =

> On first attempt I didn't manage to get a connection due to DHCP, but
> after stopping/starting it worked.
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============7717844588316906983==--

