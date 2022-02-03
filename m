Content-Type: multipart/mixed; boundary="===============4426684871849880361=="
MIME-Version: 1.0
From: 54d22547-afc0-4701-b1fc-5a2a2e411646 at simplelogin.co
To: iwd at lists.01.org
Subject: Re: iwd 1.21 stuck on connecting state
Date: Thu, 03 Feb 2022 20:10:55 +0000
Message-ID: <20220203201055.3721.56890@ml01.vlan13.01.org>
In-Reply-To: 3a4f9626fdae0a61df24e6e9c9fd7d25f0dea9b7.camel@gmail.com

--===============4426684871849880361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> This actually got merged an hour or two ago

I noticed right after posting. Classic hehe.

Issue seems solved. I get connectivity and according to logs iwd is discard=
ing previous DHCP requests:

[DHCPv4] dhcp_client_send_discover:346
[DHCPv4] l_dhcp_client_start:1210 Entering state: DHCP_STATE_SELECTING
[DHCPv4] dhcp_client_timeout_resend:526
[DHCPv4] dhcp_client_send_discover:346
[DHCPv4] dhcp_client_rx_message:832
[DHCPv4] dhcp_client_receive_offer:762
[DHCPv4] dhcp_client_handle_offer:805 Entering state: DHCP_STATE_REQUESTING
[DHCPv4] dhcp_client_send_request:396
[DHCPv4] dhcp_client_rx_message:832
[DHCPv4] dhcp_client_receive_offer:762
[DHCPv4] dhcp_client_receive_offer:786 Server sent another offer, using it =
instead
[DHCPv4] dhcp_client_handle_offer:805 Entering state: DHCP_STATE_REQUESTING
[DHCPv4] dhcp_client_send_request:396
[DHCPv4] dhcp_client_rx_message:832
[DHCPv4] dhcp_client_receive_ack:684
[DHCPv4] dhcp_client_rx_message:905 Entering state: DHCP_STATE_BOUND
[DHCPv4] dhcp_client_rx_message:939 T1 expiring in 21600784 ms
[DHCPv4] l_acd_start:447 Skipping probes and sending announcements
[DHCPv4] announce_wait_timeout:166 No conflicts found for 192.168.1.39, ann=
ouncing address
[DHCPv4] acd_send_packet:146 sending packet with target IP 192.168.1.39

Would you create a release soon?

Thanks!
--===============4426684871849880361==--

