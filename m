Content-Type: multipart/mixed; boundary="===============7419214355497393605=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 1/7] storage: implement network profile encryption
Date: Fri, 04 Feb 2022 15:35:15 -0800
Message-ID: <5aabb67cfec773eafe18d1c37e107f6a5edf1b4d.camel@gmail.com>
In-Reply-To: cfbb2d3a56d271ee240d7e09bb221033a79ec045.camel@gmail.com

--===============7419214355497393605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2022-02-04 at 15:23 -0800, James Prestwood wrote:
> Hi Joseph,
> =

> On Fri, 2022-02-04 at 15:55 -0700, Joseph Benden wrote:
> > Hi!
> > =

> > It is my understanding that all secret data is to be kept as
> > securely
> > as =

> > possible. I'm not really seeing this carried throughout the source
> > code. =

> > Maybe this specific code does not need that level of security?
> =

> Currently any profile (e.g. /var/lib/iwd/foo.psk) containing secret
> data is unencypted, plaintext. We rely on the file system permissions
> to 'secure' this data (which this patch series is 'fixing' for anyone
> who wants these encrypted).
> =

> > =

> > If I'm right, then:
> > =

> > The secret data should be kept in a mmap(), and mlock(), structure.
> > The =

> > prevents secret data from hitting swap memory. After every use of
> > the
> > secret data; it must be explicit_bzero() and then free(). This is
> > so =

> > critical and tedious that it should be a macro or something from
> > libell. =

> > And those are just initial thoughts for the basic safety of the
> > secret data.
> =

> So this is how the systemd feature works: The IWD service is given a
> path to a file. This file is decrypted by systemd and contains the
> 'secret'. IWD then reads this secret in, does some hashing, and
> stores
> the hashed secret in RAM. Once IWD is done it never accesses the file
> again.
> =

> So I don't think its even possible for IWD to do this mmap/mlock
> dance
> you're describing. It really doesn't own this secret file, nor does
> it
> keep the file contents around long. It just derives a fixed length
> key
> and never uses the file again.

Sorry I misunderstood. We could do this (the mmap/mlock part) but as
far as doing it every time we need the secret, I don't see that being
feasible.

> =

> As far as explicit_bzero'ing the hashed secret after every use, then
> reading it back in, and hashing it again when needed... this seems a
> bit crazy :)
> =

> Thanks,
> James
> =

> > =

> > Best regards,
> > -Joe
> > _______________________________________________
> > iwd mailing list -- iwd(a)lists.01.org
> > To unsubscribe send an email to iwd-leave(a)lists.01.org
> =

> =



--===============7419214355497393605==--

