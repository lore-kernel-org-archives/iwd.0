Content-Type: multipart/mixed; boundary="===============8324732179423288105=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: ap mode problem
Date: Mon, 10 May 2021 09:10:37 -0700
Message-ID: <9607578469c8a0f5d902c3198a3b75df7b8179a4.camel@gmail.com>
In-Reply-To: <CAG17S_OiVP-8e4PFzSaqzGEQiEKdyg8yv585ch-T1H0p-UkhbA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8324732179423288105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On Mon, 2021-05-10 at 09:47 -0500, KeithG wrote:
> James,
> =

> I am on iwd 1.14, now and still get the same error.

Hmm, I just tried with 1.14 checked out and saw no problems. This was
on a RPi 3 though, not a v1 with wifi dongle. Still, your problem does
seem to be related to what we fixed previously as you're EAPoL frames
look suspiciously similar.

Could you run unit/test-eapol and see if that passes.

Also, I'm guessing your using a packaged version of IWD? I would be
curious to see how exactly this is built (what compile/link options,
gcc version etc. Ill see if I can find this online somewhere). Our
'fix' was a pragma disabling optimization in a specific routine, but
maybe there are compiler options which undo this? I'm not too familiar
with the ins and outs of pragmas.

Another route would be to see if you could build IWD from source
(unless that is what you are doing already).

I've got an old RPi 1 buried somewhere. If I can find it I will give it
a try.

Thanks,
James


--===============8324732179423288105==--

