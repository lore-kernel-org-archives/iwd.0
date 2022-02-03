Content-Type: multipart/mixed; boundary="===============8080945613131952452=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd 1.21 stuck on connecting state
Date: Thu, 03 Feb 2022 13:41:33 -0800
Message-ID: <d023066c93eda551abca134bb130afeb706888e7.camel@gmail.com>
In-Reply-To: 20220203201055.3721.56890@ml01.vlan13.01.org

--===============8080945613131952452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-02-03 at 20:10 +0000,
54d22547-afc0-4701-b1fc-5a2a2e411646(a)simplelogin.co wrote:
> > This actually got merged an hour or two ago
> =

> I noticed right after posting. Classic hehe.
> =

> Issue seems solved. I get connectivity and according to logs iwd is
> discarding previous DHCP requests:
> =

> [DHCPv4] dhcp_client_send_discover:346
> [DHCPv4] l_dhcp_client_start:1210 Entering state:
> DHCP_STATE_SELECTING
> [DHCPv4] dhcp_client_timeout_resend:526
> [DHCPv4] dhcp_client_send_discover:346
> [DHCPv4] dhcp_client_rx_message:832
> [DHCPv4] dhcp_client_receive_offer:762
> [DHCPv4] dhcp_client_handle_offer:805 Entering state:
> DHCP_STATE_REQUESTING
> [DHCPv4] dhcp_client_send_request:396
> [DHCPv4] dhcp_client_rx_message:832
> [DHCPv4] dhcp_client_receive_offer:762
> [DHCPv4] dhcp_client_receive_offer:786 Server sent another offer,
> using it instead

Perfect, glad to see it worked.

> [DHCPv4] dhcp_client_handle_offer:805 Entering state:
> DHCP_STATE_REQUESTING
> [DHCPv4] dhcp_client_send_request:396
> [DHCPv4] dhcp_client_rx_message:832
> [DHCPv4] dhcp_client_receive_ack:684
> [DHCPv4] dhcp_client_rx_message:905 Entering state: DHCP_STATE_BOUND
> [DHCPv4] dhcp_client_rx_message:939 T1 expiring in 21600784 ms
> [DHCPv4] l_acd_start:447 Skipping probes and sending announcements
> [DHCPv4] announce_wait_timeout:166 No conflicts found for
> 192.168.1.39, announcing address
> [DHCPv4] acd_send_packet:146 sending packet with target IP
> 192.168.1.39
> =

> Would you create a release soon?

Yes, I think this is happening very soon.

> =

> Thanks!
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============8080945613131952452==--

