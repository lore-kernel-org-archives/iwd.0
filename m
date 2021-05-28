Content-Type: multipart/mixed; boundary="===============3596337971988947995=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: How to NAT when using iwd ap mode?
Date: Thu, 27 May 2021 20:04:55 -0500
Message-ID: <CAG17S_NeXAi1_VHQoDkGfpn+evQFNJ1CsSg3dPJjS+7fS=Fm0A@mail.gmail.com>
In-Reply-To: <9ffb37f4-a363-f2a6-f671-97f3b024be09@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3596337971988947995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2021 at 10:34 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Keith,
>
> >
> > Denis,
> >
> > Thanks, google did not help me find that page. It works for me. The
>
> Of course not, I added it yesterday ;)
>
> > only thing I would ask is: why do we have to set the 'APRanges=3D' in
> > /etc/iwd/main.conf? Can this be set in ssid.ap? This is the only
> > setting that I have found that needs to be set in main.conf for ap
> > mode to work.
>
> There's some flux in iwd in this area as we're still fleshing out AP prof=
iles
> and how they're used.  We're moving to making this setting optional in the
> future.  For now, you can set it to something reasonable; the settings in=
 the AP
> profile take precedence.
>
> Regards,
> -Denis
Denis,

Wow, I feel like I am on the cutting edge. The instructions worked
great. I have even wrapped some php around it to automate it in our
little music player. Thanks for the guidance.

Is there a possibility for ap mode to scan in the near term or is that
a pipe dream? Is this something being worked on? The way I have it
working, now, is: I scan for SSIDs in station mode, save them to redis
then switch to ap mode and then can select one for setup. It would be
nice, though, if we could do a live scan, like we do with hostapd, to
get the list with current signal strength.

Keith
--===============3596337971988947995==--

