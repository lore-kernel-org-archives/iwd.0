Content-Type: multipart/mixed; boundary="===============4697103565134680806=="
MIME-Version: 1.0
From: Xaver =?unknown-8bit?q?H=C3=B6rl?= <hoe.dom@gmx.de>
Subject: Re: Suggestion: make iwctl follow the XDG Base Directory Specification
Date: Tue, 10 Dec 2019 14:04:20 +0100
Message-ID: <20191210130420.snypbt3q3hgp5nak@blumerang>
In-Reply-To: <B4E8E87E-8EE1-4487-AEFA-59EC699A3FE9@holtmann.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4697103565134680806==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sure I will give it a try. Note though that I don't usually code in C
and have no experience contributing to this sort of stuff.

On Sat, Dec 07, 2019 at 04:47:39PM +0100, Marcel Holtmann wrote:
> Hi,
>
> > Currently iwctl writes its history to a file named .iwctl_history in th=
e users home directory. The XDG Base Directory Specification tries to stand=
ardize these kind of things (see https://specifications.freedesktop.org/bas=
edir-spec/basedir-spec-latest.html for details). The bottom line would prob=
ably be to:
> > * check XDG_DATA_HOME (with fall back to .local/share/) and save the hi=
story in an iwd subfolder of that directory
> > * potentially read (and migrate?) .iwctl_history from the home director=
y for compatibility purposes
>
> I am fine with using $XDG_DATA_HOME/iwctl/history or $HOME/.local/share/i=
wctl/history as fallback if $XDG_DATA_HOME is not provided. Care to send a =
patch for this?
>
> Regards
>
> Marcel
>
--===============4697103565134680806==--

