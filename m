Content-Type: multipart/mixed; boundary="===============7560468248471776371=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: DHCP renewal stops after disconnect
Date: Wed, 11 May 2022 11:53:28 +0100
Message-ID: <CACsRnHU00FE7T5XWf5Evc1m+DWMhmr0XDcfkY_Eor=YS04DKVQ@mail.gmail.com>

--===============7560468248471776371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hey,

I'm encountering a couple of issues with the DHCP client in iwd
specifically when the network environment is flaky.

The major issue I have is when the iwd client is disconnected either
from a channel change or just a low signal. The DHCP client gets a new
lease when it connects but never asks for a lease renewal which
eventually means it loses it after the expiration. This paste shows
the logs of this happening https://pastebin.com/yGJbUmVR  (I have
enabled IWD_DHCP_DEBUG=3D1 to get more data but I am still waiting for
it to happen again).

My plan is to see if I can reproduce the issue on a smaller scale (we
have ~130 clients running and it happens maybe twice a day) and once I
can reproduce I will update iwd and ell to see if that fixes it (I'm
using version 1.21 iwd and 0.47 ell). I looked through the new commits
since my versions and there was nothing explicitly about this but
c78ad1bb and b02c2034 look possibly related?

For now, I wonder if you know of an obvious place that a disconnect
might not be cleaning up the DHCP state fully which causes the T1
timer not to be set?


As for the second minor issue, it seems like iwd doesn't retry sending
a DHCPREQUEST once it's passed the T1 timer and in the RENEW state
which I believe it should based on
http://www.tcpipguide.com/free/t_DHCPLeaseRenewalandRebindingProcesses-2.ht=
m.
I have seen the first request being lost due to a bad signal and then
iwd didn't try again until T2 which is a more complete renewal. This
doesn't cause any interruption but does cause the lease to be removed
before being renewed.


Kind Regards,
Michael Johnson
--===============7560468248471776371==--

