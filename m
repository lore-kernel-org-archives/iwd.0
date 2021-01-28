Content-Type: multipart/mixed; boundary="===============4433391402425695480=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] ap: allow no group traffic on GET_KEY error
Date: Thu, 28 Jan 2021 13:42:08 -0600
Message-ID: <d0af9e84-10a3-01e3-db26-d97ee726767a@gmail.com>
In-Reply-To: <20210128183352.1004552-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4433391402425695480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/28/21 12:33 PM, James Prestwood wrote:
> Some fullmac cards were found to be buggy with getting the GTK
> where it returns a BIP key for the GTK index, even after creating
> a GTK with NEW_KEY explicitly. In an effort to get these cards
> semi-working we can treat this just as a warning and continue with
> the handshake without a GTK set which disables group traffic. A
> warning is printed in this case so the user is not completely in
> the dark.
> ---
>   src/ap.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============4433391402425695480==--

