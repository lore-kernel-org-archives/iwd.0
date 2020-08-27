Content-Type: multipart/mixed; boundary="===============7653144855541522642=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] ap: Move AP parameters to a struct
Date: Thu, 27 Aug 2020 12:26:30 -0500
Message-ID: <33efefff-422e-eae1-5584-9d2653fe5e06@gmail.com>
In-Reply-To: <CAOq732LBD_zppOtfu6iqG06+QcTQfpO8gTJoT-wSe0LaLkaebw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7653144855541522642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> I do wonder why you decided to make authorized_macs into a double-level =
array
>> instead of just a flat one...  You can always realloc if you need to gro=
w it..
> =

> Right, I thought it's just more natural when you can access n'th
> element with array[n], or you can iterate like over a list like I did
> here.
> And you don't need to make assumptions about the length of the array.

That just seems so wasteful though?  I mean each pointer is 8 bytes on 64-b=
it, =

more than you pay for the mac address itself.  Plus god knows how much you =
pay =

in malloc overhead.  No point being wasteful unnecessarily.

>>
>> I think eventually we probably want to make this a proper API.  like
>> ap_config_new, ap_config_set_ssid, ap_config_set_passphrase, etc.
> =

> Do you mean eventually, or now?  I personally would prefer l_settings
> over that, once you add accessors it loses the benefit of a nice
> struct that can be read and written easily.
> =

But this can be defined inside ap.c.  So opaque only to clients of ap.c.  D=
o you =

need to access the struct elsewhere?  If so, then the whole blurb in the =

documentation about ap_start taking ownership isn't really true...

Regards,
-Denis
--===============7653144855541522642==--

