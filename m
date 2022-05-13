Content-Type: multipart/mixed; boundary="===============9214856828161268400=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: Re: DHCP renewal stops after disconnect
Date: Fri, 13 May 2022 12:27:30 +0100
Message-ID: <CACsRnHV6tmVL0051RjrST91qy+YghS0ZSUzhBbr-tdxkr-cpMA@mail.gmail.com>
In-Reply-To: a4b4eb3e-c569-084d-103e-f41ccd451bd2@gmail.com

--===============9214856828161268400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I've updated some of the clients in my test environment to use your
latest ell debug logging patch and I'll let you know what error I see.

On Thu, 12 May 2022 at 18:50, Denis Kenzior <denkenz(a)gmail.com> wrote:
> > May 12 15:05:02 r2-19006 iwd[475]: [DHCPv4] announce_wait_timeout:187
> > Failed to send ACD announcement
> > ```
>
> Yes, I saw that.  Looking at the code, we should fail to start acd if we'=
re
> running out of fds and this logic wouldn't be triggered...

I'm not sure this is related but I notice that in normal logging there
are never any retries of this method as this is never printed:
```
announce_wait_timeout: ACD_DEBUG("Done announcing");
```
which makes sense as the timeout object is NULL when "skip_probes" is true.
```
l_acd_start: announce_wait_timeout(NULL, acd);
```

Regards,
Michael
--===============9214856828161268400==--

