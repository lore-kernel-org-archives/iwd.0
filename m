Content-Type: multipart/mixed; boundary="===============6967521673578837019=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ap: Fix handshake state gtk not being set
Date: Mon, 16 Nov 2020 13:37:08 -0600
Message-ID: <41018348-0df0-85c0-2178-230eadac8431@gmail.com>
In-Reply-To: <20201114142145.661665-1-net147@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6967521673578837019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On 11/14/20 8:21 AM, Jonathan Liu wrote:
> handshake_state_set_authenticator_ie must be called to set group_cipher
> in struct handshake_shake before handshake_set_gtk_state, otherwise
> handshake_set_gtk_state is unable to determine the key length to set
> handshake state gtk.
> =

> Fixes: 4bc20a097965 ("ap: Start EAP-WSC authentication with WSC enrollees=
")
> ---
>   src/ap.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============6967521673578837019==--

