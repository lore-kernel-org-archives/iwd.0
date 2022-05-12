Content-Type: multipart/mixed; boundary="===============5481674494897664641=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: Re: DHCP renewal stops after disconnect
Date: Thu, 12 May 2022 18:02:04 +0100
Message-ID: <CACsRnHW67Kv0TRCJaZQUVOWiyprw7Vckx+7jpY1EnJOxOsk_2A@mail.gmail.com>
In-Reply-To: 6af01b85-1425-bf35-af59-cd8d193090ec@gmail.com

--===============5481674494897664641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Ok, thanks! I'll try to add more debug logging and get back to you.
This error might be important if it is related to an fp?
```
May 12 15:05:02 r2-19006 iwd[475]: [DHCPv4] announce_wait_timeout:166
No conflicts found for 10.101.8.24, announcing address
May 12 15:05:02 r2-19006 iwd[475]: [DHCPv4] acd_send_packet:146
sending packet with target IP 10.101.8.24
May 12 15:05:02 r2-19006 iwd[475]: [DHCPv4] announce_wait_timeout:187
Failed to send ACD announcement
```

Regards,
Michael

On Thu, 12 May 2022 at 17:38, Denis Kenzior <denkenz(a)gmail.com> wrote:
>
> Hi Michael,
>
> On 5/12/22 11:19, Michael Johnson wrote:
> > Hi Denis,
> >
> > I'm trying out the ell patch on some clients and so far it's looking
> > good. I also have some clients running without the patch but with
>
> Cool
>
> > IWD_DHCP_DEBUG enabled and I saw a very similar issue occur as the
> > original major issue >
> > This was caused by the retry timing out so wouldn't have happened with
> > the patch but the result is not what I expected in that after we do a
> > full rebind, we don't send a T1 renew. I expected that it would do a
>
> So by a full rebind you mean:
>
> May 12 15:03:45 r2-19006 iwd[475]: [DHCPv4] dhcp_client_t2_expired:607
> May 12 15:03:45 r2-19006 iwd[475]: [DHCPv4] dhcp_client_t2_expired:614 En=
tering
> state: DHCP_STATE_REBINDING
> May 12 15:05:01 r2-19006 iwd[475]: [DHCPv4] dhcp_client_lease_expired:596
>
> Where we issue a l_dhcp_client_stop and l_dhcp_client_start() again.
>
> > full state refresh and so it should go back to working after the T2
> > timeout.
>
> So the problem is that we do not reset the timer for T2 until after the T=
1 timer
> fires.  Each l_timeout object uses an fd from the kernel, so we try to mi=
nimize
> the number of timers active.
>
> As you point out, the timeout value is getting set correctly:
>
> # T1 is set correctly
> May 12 15:05:02 r2-19006 iwd[475]: [DHCPv4] dhcp_client_rx_message:943 T1
> expiring in 299927 ms
>
> So the only thing I can think of is that we're leaking the fd somehow, wh=
ich
> would be pretty embarrassing.  Or we're running out of fds and can't crea=
te the
> new timer.  Running under strace or putting in some extra debugs might he=
lp?
>
> Regards,
> -Denis
--===============5481674494897664641==--

