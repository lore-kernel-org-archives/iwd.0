Content-Type: multipart/mixed; boundary="===============4808918223495459924=="
MIME-Version: 1.0
From: KeithG <ys3al35l at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd configure location and files
Date: Tue, 30 Nov 2021 16:36:04 -0600
Message-ID: <CAG17S_Pc-j0=CW1yrkbjWibooNYM4ycqKrXfJGAUVxE98QgMQg@mail.gmail.com>
In-Reply-To: d899ecf8-deb2-f526-c20f-0fd80aba9841@gmail.com

--===============4808918223495459924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

My suggestion is along these lines. Shut down connman and run iwd
stand alone. Use iwctl to see if it will connect to the SSID. If this
works, delete the associated SSID files created in /var/lib/iwd. Then
start connman and try to connect using connmanctl. I went through this
a while back, so it does work as long as the kernel is configured for
it and you are using recent iwd and connman. I am using connman 1.40
and iwd 1.20 on Arch Linux Arm (RPi) and am pleased with the
performance.

Keith

On Tue, Nov 30, 2021 at 4:04 PM Denis Kenzior <denkenz(a)gmail.com> wrote:
>
> Hi Jupiter,
>
> >                                 Available networks
> > -----------------------------------------------------------------------=
---------
> >      Network name                    Security          Signal
> > -----------------------------------------------------------------------=
---------
> >      JupiterIoT                      psk               ****
> >
> > # station wlan0 connect JupiterIoT
> > Type the network passphrase for JupiterIoT psk.
> > Passphrase: superpassphrase
> > Operation aborted
> >
>
> Are you running connman + iwd?  Are you sure ConnMan isn't aborting the
> connection?  Have you tried using connmanctl or using iwd + iwctl with co=
nnman
> not running?
>
> We do need iwd logs and preferably iwmon logs.  You may need to build nlm=
on
> support into your kernel if iwmon doesn't start.  e.g. CONFIG_NLMON=3Dm o=
r y
>
> Regards,
> -Denis
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org
--===============4808918223495459924==--

