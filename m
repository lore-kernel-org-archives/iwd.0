Content-Type: multipart/mixed; boundary="===============2913119504379409702=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] wiphy: add check for CMD_AUTH/CMD_ASSOC support
Date: Mon, 23 Mar 2020 18:00:12 +0000
Message-ID: <a1b10a8c-ff86-80f7-e5a2-27e1ca1bbffa@gmail.com>
In-Reply-To: <20200323161821.12366-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2913119504379409702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/23/20 11:18 AM, James Prestwood wrote:
> If the AP only supports an AKM which requires an auth protocol
> CMD_AUTHENTICATE/CMD_ASSOCIATE must be supported or else the
> auth protocol cannot be run. All the auth protocols are started
> assuming that the card supports these commands, but the support
> was never checked when parsing supported commands.
> =

> This patch will prevent any fullMAC cards from using
> SAE/FILS/OWE. This was the same behavior as before, just an
> earlier failure path.
> ---
>   src/wiphy.c | 48 ++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 38 insertions(+), 10 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============2913119504379409702==--

