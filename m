Content-Type: multipart/mixed; boundary="===============5096447621180285567=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: Re: DHCP renewal stops after disconnect
Date: Mon, 16 May 2022 10:38:34 +0100
Message-ID: <CACsRnHVzAPXVDh2qSgGbpqo_yBAco+UHuehAZCouXbuVN7=zKQ@mail.gmail.com>
In-Reply-To: CACsRnHV6tmVL0051RjrST91qy+YghS0ZSUzhBbr-tdxkr-cpMA@mail.gmail.com

--===============5096447621180285567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

I ran this over the weekend and with the extra logging I can see that
ACD error is "Bad file descriptor". I captured some additional fd info
while iwd was running in the bad state and it looks like timers are
being leaked somewhere.

```
May 14 03:29:00.008410 r2-19101 iwd[477]: [DHCPv4]
announce_wait_timeout:189 Failed to send ACD announcement: Bad file
descriptor

$ cat /proc/477/limits
Limit Soft Limit Hard Limit Units
...
Max open files 1024 524288 files

$ sudo lsof -a -p 477
...
iwd 477 root 1020u a_inode 0,13 0 13445 [timerfd]
iwd 477 root 1021u a_inode 0,13 0 13445 [timerfd]
iwd 477 root 1022u a_inode 0,13 0 13445 [timerfd]
iwd 477 root 1023u a_inode 0,13 0 13445 [timerfd]
```

https://pastebin.com/BHYVTSXT

Regards,
Michael

On Fri, 13 May 2022 at 12:27, Michael Johnson <mjohnson459(a)gmail.com> wro=
te:
>
> Hi Denis,
>
> I've updated some of the clients in my test environment to use your
> latest ell debug logging patch and I'll let you know what error I see.
>
> On Thu, 12 May 2022 at 18:50, Denis Kenzior <denkenz(a)gmail.com> wrote:
> > > May 12 15:05:02 r2-19006 iwd[475]: [DHCPv4] announce_wait_timeout:187
> > > Failed to send ACD announcement
> > > ```
> >
> > Yes, I saw that.  Looking at the code, we should fail to start acd if w=
e're
> > running out of fds and this logic wouldn't be triggered...
>
> I'm not sure this is related but I notice that in normal logging there
> are never any retries of this method as this is never printed:
> ```
> announce_wait_timeout: ACD_DEBUG("Done announcing");
> ```
> which makes sense as the timeout object is NULL when "skip_probes" is tru=
e.
> ```
> l_acd_start: announce_wait_timeout(NULL, acd);
> ```
>
> Regards,
> Michael
--===============5096447621180285567==--

