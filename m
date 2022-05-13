Content-Type: multipart/mixed; boundary="===============6735772579614389213=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: Re: DHCP renewal stops after disconnect
Date: Fri, 13 May 2022 10:58:02 +0100
Message-ID: <CACsRnHU_6Cp2Uz1=CaNUW47R3DYSX6_yksveJQZc0_6Kq8RB2A@mail.gmail.com>
In-Reply-To: a4b4eb3e-c569-084d-103e-f41ccd451bd2@gmail.com

--===============6735772579614389213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

When enabling the DHCP debug logs I also upgraded the version of iwd
and ell in my test environment to 1.27 and 0.50 respectively so the
most recent logs should be closer to you at least.

Regards,
Michael

On Thu, 12 May 2022 at 18:50, Denis Kenzior <denkenz(a)gmail.com> wrote:
>
> Hi Michael,
>
> On 5/12/22 12:02, Michael Johnson wrote:
> > Hi Denis,
> >
> > Ok, thanks! I'll try to add more debug logging and get back to you.
> > This error might be important if it is related to an fp?
> > ```
> > May 12 15:05:02 r2-19006 iwd[475]: [DHCPv4] announce_wait_timeout:166
> > No conflicts found for 10.101.8.24, announcing address
> > May 12 15:05:02 r2-19006 iwd[475]: [DHCPv4] acd_send_packet:146
> > sending packet with target IP 10.101.8.24
> > May 12 15:05:02 r2-19006 iwd[475]: [DHCPv4] announce_wait_timeout:187
> > Failed to send ACD announcement
> > ```
>
> Yes, I saw that.  Looking at the code, we should fail to start acd if we'=
re
> running out of fds and this logic wouldn't be triggered...
>
> I'm running a full test suite under valgrind with '--track-fds=3Dyes', bu=
t it
> hasn't found anything so far.  You are running a different version than I=
 am
> though...
>
> Regards,
> -Denis
--===============6735772579614389213==--

