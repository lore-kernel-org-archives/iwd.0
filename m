Content-Type: multipart/mixed; boundary="===============0799844275251560752=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: how to disable colorized/grey output from iwctl commands
Date: Mon, 09 Mar 2020 22:47:08 -0500
Message-ID: <5255da5d-9068-8629-e4b9-2bb74150d8d8@gmail.com>
In-Reply-To: <CAG17S_NQbJEQdv6twFogVoZ7gc__QNQXwy48qjyHMckGPEVjaA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0799844275251560752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On 3/8/20 8:35 AM, KeithG wrote:
> I am trying to move to connman/iwd from netctl on a RPi. It currently =

> has a PHP based UI to display the info and allow connections, etc. =

> Connmanctl commands=C2=A0 respond with text (no control characters, no =

> colorization) iwdctl responds with text with control characters. If I =


connman client does not use special ANSI codes, iwctl does.

> use this command::
> iwctl station wlan0 get-networks
> I get a response which looks like clear txt in my linux terminal =

> connected by ssh, but it has control characters indicating which network =

> is connected and the signal strength stars are all present and are =

> either full brightness of grey depending on the signal. THis makes it =


It should be quite straightforward to filter the ANSI escape sequences =

out.  See https://en.wikipedia.org/wiki/ANSI_escape_code

> challenging to feed this into php to be displayed in a browser... Is =

> there a hidden flag to turn this off? Can this be added? If there are =

> other suggestions on how to best deal with this, I am soliciting =

> advice... What I get is this in php:

Right now there's no flag in iwctl to turn colorization off.  Should be =

straightforward to add though.  Patches are always welcome.

Regards,
-Denis
--===============0799844275251560752==--

