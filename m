Content-Type: multipart/mixed; boundary="===============0648128032345027626=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/2] ap: Move AP parameters to a struct
Date: Thu, 27 Aug 2020 20:00:20 +0200
Message-ID: <CAOq732+kOPkPm5=dx6NbkvZufp388GeVnj4EjzadTa7E23jnEA@mail.gmail.com>
In-Reply-To: <33efefff-422e-eae1-5584-9d2653fe5e06@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0648128032345027626==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Aug 2020 at 19:37, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Andrew,
>
> >> I do wonder why you decided to make authorized_macs into a double-leve=
l array
> >> instead of just a flat one...  You can always realloc if you need to g=
row it..
> >
> > Right, I thought it's just more natural when you can access n'th
> > element with array[n], or you can iterate like over a list like I did
> > here.
> > And you don't need to make assumptions about the length of the array.
>
> That just seems so wasteful though?  I mean each pointer is 8 bytes on 64=
-bit,
> more than you pay for the mac address itself.  Plus god knows how much yo=
u pay
> in malloc overhead.  No point being wasteful unnecessarily.

In theory that makes sense, so yes, let me switch to an uint8_t array.

In practice there's going to be zero or one address and there can be
only one such array per netdev.

>
> >>
> >> I think eventually we probably want to make this a proper API.  like
> >> ap_config_new, ap_config_set_ssid, ap_config_set_passphrase, etc.
> >
> > Do you mean eventually, or now?  I personally would prefer l_settings
> > over that, once you add accessors it loses the benefit of a nice
> > struct that can be read and written easily.
> >
> But this can be defined inside ap.c.  So opaque only to clients of ap.c.

I still can't see a benefit though (it's more code for the ap.c
developer and more code for the user, possibly more bureaucracy (more
back and forth on the mailing list to add a parameter).  I guess it's
a question of preference, you may like a specific style enough that it
outweights that.

Also l_settings is aonther option.

> Do you
> need to access the struct elsewhere?

I was thinking hypothetically a user could access config->channel
after ap_start to learn what channel has been selected.

> If so, then the whole blurb in the
> documentation about ap_start taking ownership isn't really true...

If your structs aren't opaque then you don't need to own the struct to
access it, you only need to adhere to instructions.  For example,
don't acccess the struct after the owner has been freed.

Best regards
--===============0648128032345027626==--

