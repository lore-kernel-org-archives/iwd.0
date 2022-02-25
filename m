Content-Type: multipart/mixed; boundary="===============8139653069235617999=="
MIME-Version: 1.0
From: =?utf-8?q?Joakim_Lotseng=C3=A5rd_=3Cjoakim=2El_at_orbital-systems=2Ecom?=
 =?utf-8?q?=3E?=
To: iwd at lists.01.org
Subject: Re: lib to iwd
Date: Fri, 25 Feb 2022 09:21:39 +0100
Message-ID: <CAELJisxbpVWA-2XLZcTJO7njv23QqVH1CQyQVbkzrZ5tSbE3OA@mail.gmail.com>
In-Reply-To: AA5E1393-FF23-4F0F-95DF-7B273D9E47A4@holtmann.org

--===============8139653069235617999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel, and thanks for your answer. See below.

On Thu, 24 Feb 2022 at 21:36, Marcel Holtmann <marcel(a)holtmann.org> wrote:
>
> so here is the thing; for any C based library, you need to decide on a ma=
inloop since D-Bus calls are inherently async.
>
> While I will applaud anybody doing a GObject based wrapper, it is not som=
ething that fits into iwd.git upstream since it goes against our philosophy=
 of keeping the dependency chain small and making this fly on small and emb=
edded systems. Also I can not agree with all GLib and Object decisions. The=
re is a reason why ELL exists in the first place.
>
> I also have no interest in mainloop abstractions. It is pretty much been-=
there-done-that-no-thank-you type of thing.
>
> This would leave us at an ELL based library. Meaning that the application=
 pretty much also have to agree on ELL design choices. Now if that is somet=
hing that is interesting, then sure, this could be done. However I have to =
say, that can only be done if iwctl also utilizes that library. Providing a=
 library without any real feedback from actual users is always a mess and d=
oomed to fail.
>

A previous mail answer hinted that I might have not been clear enough
to point out that I am looking for a "third" entity, beside iwd and
iwctl. Something that would help me get an IoT device configured via a
side channel (bluetooth). I do not want to change any code in either
iwd nor iwctl in regards to help with this. I want to use the DBUS API
in a "standard" and helpful way. The way iwd intended. A lib (or
perhaps a bunch of examples) to help with "not making common mistakes"
and getting started.

For example, if I got it right (please correct me), the passphrase
must be provided via an agent that is registered. It would be easier
for code to just configure an SSID+passphrase in one call to have a
single API for that, not bothering with an agent. Much like the
--passphrase to iwctl. But that probably needs changes in iwd, which I
do not want. But a lib/example that does this for you would be nice.

I am looking for a "lib" that will help with the DBUS interaction. The
"iwd"-way of doing it. I got the tip to look at ELL for this and it
might even be that easy that the "lib" I am looking for is really just
a bunch of "examples" to get basic operations working/configuring an
SSID.

I too think that different types of mainloops are really a pain.
Especially if you want to mix libraries and try to bridge things
together. Our legacy code managed to add threading above that. And,
well, a mess. Bluetooth stack (github: gobbledegook, GATT) with libnm,
resulting in several g_main_loops, doesn't really play ball very well.

Thanks for the tip of ELL.

-- =

Best regards,
Joakim Lotseng=C3=A5rd
--===============8139653069235617999==--

