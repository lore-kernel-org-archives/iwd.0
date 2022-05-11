Content-Type: multipart/mixed; boundary="===============4609020476535135748=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: Re: DHCP renewal stops after disconnect
Date: Wed, 11 May 2022 17:22:22 +0100
Message-ID: <CACsRnHUk-iYZHfHOkNyESzyoyOWCnw4ymD5nbyp6w-gXVEU9tQ@mail.gmail.com>
In-Reply-To: afd7b5f5-f927-aa44-e677-eed5c1aa8273@gmail.com

--===============4609020476535135748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thanks for the prompt response.

On Wed, 11 May 2022 at 16:56, Denis Kenzior <denkenz(a)gmail.com> wrote:
> Nothing jumps out at me right now.  The IWD_DHCP_DEBUG log would be helpf=
ul.

Ok, thanks. I'm still waiting for this to happen again. I tried to
reproduce locally but I've been unsuccessful. None of kicking clients,
restarting the AP, lowering the power, or changing channels caused it
on their own so there must be a hidden variable I'm missing. Or its a
race thing and I've just not hit it.

> Is the lease an inifinite lease by any chance?

The lease should always be 2 hours if dhcpd is working correctly. The
ones I've seen are always this value.

> Yes, we definitely should be doing retransmissions in the RENEWAL state. =
 We do
> start the retransmission timer dhcp_client_t1_expired(), so the same
> retransmission logic as during DISCOVER/REQUESTING states should apply.
>
> The interesting thing is that T2 timer expiration updates the state, but =
still
> relies on the retransmission timer to fire so that the REBIND request can=
 be
> sent.  So that implies that retransmission timer is active.
>
> Have you noticed any cases where the lease was not renewed at all?

For this one I did have DHCP debug on. You seem to be right, it looks
like we didn't renew until we timed out completely.

```
May 10 13:03:59 p3-153 iwd[1327599]: [DHCPv4] dhcp_client_t1_expired:628
May 10 13:03:59 p3-153 iwd[1327599]: [DHCPv4]
dhcp_client_t1_expired:630 Entering state: DHCP_STATE_RENEWING
May 10 13:03:59 p3-153 iwd[1327599]: [DHCPv4] dhcp_client_send_request:396
May 10 13:03:59 p3-153 iwd[1327599]: [DHCPv4] dhcp_client_rx_message:791
May 10 13:03:59 p3-153 iwd[1327599]: [DHCPv4] dhcp_client_receive_ack:684
May 10 13:03:59 p3-153 iwd[1327599]: [DHCPv4]
dhcp_client_rx_message:869 Entering state: DHCP_STATE_BOUND
May 10 13:03:59 p3-153 iwd[1327599]:
src/netconfig.c:netconfig_ipv4_dhcp_event_handler() DHCPv4 event 3
May 10 13:03:59 p3-153 iwd[1327599]: [DHCPv4]
dhcp_client_rx_message:903 T1 expiring in 3600841 ms
May 10 14:04:00 p3-153 iwd[1327599]: [DHCPv4] dhcp_client_t1_expired:628
May 10 14:04:00 p3-153 iwd[1327599]: [DHCPv4]
dhcp_client_t1_expired:630 Entering state: DHCP_STATE_RENEWING
May 10 14:04:00 p3-153 iwd[1327599]: [DHCPv4] dhcp_client_send_request:396
# no response
May 10 14:49:01 p3-153 iwd[1327599]: [DHCPv4] dhcp_client_t2_expired:607
May 10 14:49:01 p3-153 iwd[1327599]: [DHCPv4]
dhcp_client_t2_expired:614 Entering state: DHCP_STATE_REBINDING
# why nothing here?
May 10 15:04:01 p3-153 iwd[1327599]: [DHCPv4] dhcp_client_lease_expired:596
May 10 15:04:01 p3-153 iwd[1327599]: [DHCPv4] dhcp_client_send_release:489
May 10 15:04:01 p3-153 iwd[1327599]: [DHCPv4] l_dhcp_client_stop:1219
Entering state: DHCP_STATE_INIT
```

Regards,
Michael
--===============4609020476535135748==--

