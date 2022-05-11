Content-Type: multipart/mixed; boundary="===============3196655718216989996=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: Connecting to 802.1X ethernet?
Date: Wed, 11 May 2022 09:44:57 -0500
Message-ID: <0f1c7c28-bc38-2b55-8e0f-3a1d4afb1f92@gmail.com>
In-Reply-To: CAGTBY+uzUrPaTE7-46RQaKf1W_6Fab6eowrhknut0LC06F280w@mail.gmail.com

--===============3196655718216989996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rhys,

On 5/11/22 06:17, Rhys Perry wrote:
> Hi,
> =

> My school uses PEAP-MSCHAPV2 8021X authentication for both it's
> wireless and wired networks. I can successfully connect to the network
> wirelessly using iwd, so all is good there.
> =

> I was wondering if it is possible to also use iwd to connect to
> ethernet (and possible handle dhcp too?). I have heard that ead might

Not with iwd, it only manages wireless interfaces.

> be able to help with that, but am not too sure about how to get that
> working. I found the ead executable, but I'm not sure how exactly it
> needs to be configured.

Should be as simple as putting your .8021x file into ead's storage director=
y as =

'default.8021x'.  ead storage directory is usually /var/lib/ead, so =

'/var/lib/ead/default.8021x'.  The settings file syntax is identical to iwd.

Note that ead doesn't support dhcp just yet, so you will need to run an ext=
ernal =

dhcp client on the ethernet device.

Once we finish some refactoring of ell's netconfig code we plan to teach ea=
d to =

manage dhcp/dhcpv6 as well.

Hope this helps.

Regards,
-Denis
--===============3196655718216989996==--

