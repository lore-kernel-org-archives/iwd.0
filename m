Content-Type: multipart/mixed; boundary="===============5292017086969542840=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: Wifi Tethering
Date: Sun, 24 May 2020 18:33:06 +0200
Message-ID: <20200524163306.yyryy3c3fxalnurk@beryllium.lan>
In-Reply-To: <CAG17S_MB31D12d4nmOu6pJd759AoSUjVCPnJiBHPAmh5V7H5qQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5292017086969542840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On Tue, May 05, 2020 at 05:53:40PM -0500, KeithG wrote:
> I am on Arch Linux on my Pi and the latest version of iwd just came out a=
nd
> I tried this again. I get the same response. I cannot make a connection.
> Something tells me that I am doing something very simple wrong.
> Current iwd is 1.7 and connman is 1.38. I have built the kernel with the
> iwmon module and more of the functions of iwd now show up correctly, now.=
 I
> do not know if it is because Arch finally went to 5.4 kernel from 4.19, b=
ut
> anyway it does look different:

After decoding your trace I think you need first to figure out why iwd does=
n't
work for you. You don't need ConnMan to for this. Just you the iwctrl tool
to setup you network and try to get it working without ConnMan.

Thanks,
Daniel
--===============5292017086969542840==--

