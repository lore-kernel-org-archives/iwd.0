Content-Type: multipart/mixed; boundary="===============8758959315919385353=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] handshake: fix OWE PTK derivation
Date: Tue, 24 Mar 2020 19:10:33 +0000
Message-ID: <03627c20-0cdc-d4ef-6b4b-e85c1395e6a6@gmail.com>
In-Reply-To: <20200324190757.24072-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8758959315919385353==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/24/20 2:07 PM, James Prestwood wrote:
> This bug has been in here since OWE was written, but a similar bug also
> existed in hostapd which allowed the PTK derivation to be identical.
> In January 2020 hostapd fixed this bug, which now makes IWD incompatible
> when using group 20 or 21.
> =

> This patch fixes the bug for IWD, so now OWE should be compatible with
> recent hostapd version. This will break compatibility with old hostapd
> versions which still have this bug.
> ---
>   src/handshake.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============8758959315919385353==--

