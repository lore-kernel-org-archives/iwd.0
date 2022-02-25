Content-Type: multipart/mixed; boundary="===============0613538123441323828=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel at holtmann.org>
To: iwd at lists.01.org
Subject: Re: lib to iwd
Date: Fri, 25 Feb 2022 10:05:52 +0100
Message-ID: <81ACF348-9B43-4A46-8136-E301BF1CBC0A@holtmann.org>
In-Reply-To: CAELJisxbpVWA-2XLZcTJO7njv23QqVH1CQyQVbkzrZ5tSbE3OA@mail.gmail.com

--===============0613538123441323828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Joakim,

>> so here is the thing; for any C based library, you need to decide on a m=
ainloop since D-Bus calls are inherently async.
>> =

>> While I will applaud anybody doing a GObject based wrapper, it is not so=
mething that fits into iwd.git upstream since it goes against our philosoph=
y of keeping the dependency chain small and making this fly on small and em=
bedded systems. Also I can not agree with all GLib and Object decisions. Th=
ere is a reason why ELL exists in the first place.
>> =

>> I also have no interest in mainloop abstractions. It is pretty much been=
-there-done-that-no-thank-you type of thing.
>> =

>> This would leave us at an ELL based library. Meaning that the applicatio=
n pretty much also have to agree on ELL design choices. Now if that is some=
thing that is interesting, then sure, this could be done. However I have to=
 say, that can only be done if iwctl also utilizes that library. Providing =
a library without any real feedback from actual users is always a mess and =
doomed to fail.
>> =

> =

> A previous mail answer hinted that I might have not been clear enough
> to point out that I am looking for a "third" entity, beside iwd and
> iwctl. Something that would help me get an IoT device configured via a
> side channel (bluetooth). I do not want to change any code in either
> iwd nor iwctl in regards to help with this. I want to use the DBUS API
> in a "standard" and helpful way. The way iwd intended. A lib (or
> perhaps a bunch of examples) to help with "not making common mistakes"
> and getting started.

actually iwctl is just a client of the D-Bus API. That is our way to ensure=
 that we got the D-Bus right. So iwctl really does everything a client woul=
d do.

> For example, if I got it right (please correct me), the passphrase
> must be provided via an agent that is registered. It would be easier
> for code to just configure an SSID+passphrase in one call to have a
> single API for that, not bothering with an agent. Much like the
> --passphrase to iwctl. But that probably needs changes in iwd, which I
> do not want. But a lib/example that does this for you would be nice.

That doesn=E2=80=99t work, because you don=E2=80=99t know what kind of cred=
entials you need or even when you need them. There are such weird condition=
s where it is good that iwd has a callback into the client (via the agent) =
to just ask for input. And with newer WiFi specs there is more to come. Rem=
ember that with iwd, the difference between WPA2 and WPA3 is hidden away fr=
om you. So we were able to support WPA3 without you having to update your c=
lient application.

> I am looking for a "lib" that will help with the DBUS interaction. The
> "iwd"-way of doing it. I got the tip to look at ELL for this and it
> might even be that easy that the "lib" I am looking for is really just
> a bunch of "examples" to get basic operations working/configuring an
> SSID.

If you are in a language with proper object oriented bindings for D-Bus, th=
en everything is dead simple. In C you need a bit more hand holding and wor=
k. It also gives you a lot more flexibility in the data you can share.

You can wrap doc/station-api.txt somehow. My guess is this will take you a =
week with ELL since iwctl is a great source of examples.

Just note, that hidden network handling is fundamentally different.

Regards

Marcel

--===============0613538123441323828==--

