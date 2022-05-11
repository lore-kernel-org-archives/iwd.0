Content-Type: multipart/mixed; boundary="===============3465537792082126394=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: DHCP renewal stops after disconnect
Date: Wed, 11 May 2022 10:56:05 -0500
Message-ID: <afd7b5f5-f927-aa44-e677-eed5c1aa8273@gmail.com>
In-Reply-To: CACsRnHU00FE7T5XWf5Evc1m+DWMhmr0XDcfkY_Eor=YS04DKVQ@mail.gmail.com

--===============3465537792082126394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 5/11/22 05:53, Michael Johnson wrote:
> Hey,
> =

> I'm encountering a couple of issues with the DHCP client in iwd
> specifically when the network environment is flaky.
> =

> The major issue I have is when the iwd client is disconnected either
> from a channel change or just a low signal. The DHCP client gets a new
> lease when it connects but never asks for a lease renewal which
> eventually means it loses it after the expiration. This paste shows
> the logs of this happening https://pastebin.com/yGJbUmVR  (I have
> enabled IWD_DHCP_DEBUG=3D1 to get more data but I am still waiting for
> it to happen again).

Nothing jumps out at me right now.  The IWD_DHCP_DEBUG log would be helpful.

> =

> My plan is to see if I can reproduce the issue on a smaller scale (we
> have ~130 clients running and it happens maybe twice a day) and once I
> can reproduce I will update iwd and ell to see if that fixes it (I'm
> using version 1.21 iwd and 0.47 ell). I looked through the new commits
> since my versions and there was nothing explicitly about this but
> c78ad1bb and b02c2034 look possibly related?

c78ad1bb should only affect a code path that isn't being used by iwd right =
now.

I don't think b02c2034 should affect this either.

> =

> For now, I wonder if you know of an obvious place that a disconnect
> might not be cleaning up the DHCP state fully which causes the T1
> timer not to be set?
> =


Is the lease an inifinite lease by any chance?

> =

> As for the second minor issue, it seems like iwd doesn't retry sending
> a DHCPREQUEST once it's passed the T1 timer and in the RENEW state
> which I believe it should based on
> http://www.tcpipguide.com/free/t_DHCPLeaseRenewalandRebindingProcesses-2.=
htm.
> I have seen the first request being lost due to a bad signal and then
> iwd didn't try again until T2 which is a more complete renewal. This
> doesn't cause any interruption but does cause the lease to be removed
> before being renewed.

Yes, we definitely should be doing retransmissions in the RENEWAL state.  W=
e do =

start the retransmission timer dhcp_client_t1_expired(), so the same =

retransmission logic as during DISCOVER/REQUESTING states should apply.

The interesting thing is that T2 timer expiration updates the state, but st=
ill =

relies on the retransmission timer to fire so that the REBIND request can b=
e =

sent.  So that implies that retransmission timer is active.

Have you noticed any cases where the lease was not renewed at all?

Regards,
-Denis
--===============3465537792082126394==--

