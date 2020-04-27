Content-Type: multipart/mixed; boundary="===============3170492712065858907=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] wired: use 802.1X-2001 instead of 802.1X-2004
Date: Mon, 27 Apr 2020 17:26:13 +0000
Message-ID: <148467d6-a6ef-4ff0-55a5-209fbfd60d4c@gmail.com>
In-Reply-To: <20200427171315.9897-1-Diego.SantaCruz@spinetix.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3170492712065858907==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Diego,

On 4/27/20 12:13 PM, Diego Santa Cruz wrote:
> For wired authentication the protocol version used in the EAPOL
> packets sent by ead is fixed to 802.1X-2004 (2) but some switches
> implementing only 802.1X-2001 erroneously ignore these packets.
> =

> As ead only sends EAPOL-Start and EAP-Packet packets and these have
> not changed between 802.1X-2001 and 802.1X-2004 there should be
> no reason to use 802.1X-2004. Hence, this changes ead to always use
> 802.1X-2001 (1) instead.
> =

> Switches implementing newer versions of 802.1X should not have
> problems responding to packets using the original version.
> =

> ---
>   wired/ethdev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============3170492712065858907==--

