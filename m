Content-Type: multipart/mixed; boundary="===============5792677602459078932=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: DHCP renewal stops after disconnect
Date: Thu, 12 May 2022 12:50:29 -0500
Message-ID: <a4b4eb3e-c569-084d-103e-f41ccd451bd2@gmail.com>
In-Reply-To: CACsRnHW67Kv0TRCJaZQUVOWiyprw7Vckx+7jpY1EnJOxOsk_2A@mail.gmail.com

--===============5792677602459078932==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 5/12/22 12:02, Michael Johnson wrote:
> Hi Denis,
> =

> Ok, thanks! I'll try to add more debug logging and get back to you.
> This error might be important if it is related to an fp?
> ```
> May 12 15:05:02 r2-19006 iwd[475]: [DHCPv4] announce_wait_timeout:166
> No conflicts found for 10.101.8.24, announcing address
> May 12 15:05:02 r2-19006 iwd[475]: [DHCPv4] acd_send_packet:146
> sending packet with target IP 10.101.8.24
> May 12 15:05:02 r2-19006 iwd[475]: [DHCPv4] announce_wait_timeout:187
> Failed to send ACD announcement
> ```

Yes, I saw that.  Looking at the code, we should fail to start acd if we're =

running out of fds and this logic wouldn't be triggered...

I'm running a full test suite under valgrind with '--track-fds=3Dyes', but =
it =

hasn't found anything so far.  You are running a different version than I a=
m =

though...

Regards,
-Denis
--===============5792677602459078932==--

