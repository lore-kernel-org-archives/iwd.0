Content-Type: multipart/mixed; boundary="===============3327473864077199448=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: DHCP renewal stops after disconnect
Date: Thu, 12 May 2022 11:37:59 -0500
Message-ID: <6af01b85-1425-bf35-af59-cd8d193090ec@gmail.com>
In-Reply-To: CACsRnHUFixRz2QhQY=3cZi2e-2cr-de6AbJNmOt-XBHiNDjyXA@mail.gmail.com

--===============3327473864077199448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 5/12/22 11:19, Michael Johnson wrote:
> Hi Denis,
> =

> I'm trying out the ell patch on some clients and so far it's looking
> good. I also have some clients running without the patch but with

Cool

> IWD_DHCP_DEBUG enabled and I saw a very similar issue occur as the
> original major issue >
> This was caused by the retry timing out so wouldn't have happened with
> the patch but the result is not what I expected in that after we do a
> full rebind, we don't send a T1 renew. I expected that it would do a

So by a full rebind you mean:

May 12 15:03:45 r2-19006 iwd[475]: [DHCPv4] dhcp_client_t2_expired:607
May 12 15:03:45 r2-19006 iwd[475]: [DHCPv4] dhcp_client_t2_expired:614 Ente=
ring =

state: DHCP_STATE_REBINDING
May 12 15:05:01 r2-19006 iwd[475]: [DHCPv4] dhcp_client_lease_expired:596

Where we issue a l_dhcp_client_stop and l_dhcp_client_start() again.

> full state refresh and so it should go back to working after the T2
> timeout.

So the problem is that we do not reset the timer for T2 until after the T1 =
timer =

fires.  Each l_timeout object uses an fd from the kernel, so we try to mini=
mize =

the number of timers active.

As you point out, the timeout value is getting set correctly:

# T1 is set correctly
May 12 15:05:02 r2-19006 iwd[475]: [DHCPv4] dhcp_client_rx_message:943 T1 =

expiring in 299927 ms

So the only thing I can think of is that we're leaking the fd somehow, whic=
h =

would be pretty embarrassing.  Or we're running out of fds and can't create=
 the =

new timer.  Running under strace or putting in some extra debugs might help?

Regards,
-Denis
--===============3327473864077199448==--

