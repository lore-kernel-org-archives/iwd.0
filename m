Content-Type: multipart/mixed; boundary="===============2542976329439875436=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] eapol: Use constant-time comparison
Date: Mon, 14 Jun 2021 09:10:36 -0500
Message-ID: <942e8121-b467-e769-3354-7ac579f06cbc@gmail.com>
In-Reply-To: <20210613202344.4402-1-joe@benden.us>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2542976329439875436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Joseph,

On 6/13/21 3:23 PM, Joseph Benden wrote:
> This closes the possibility of a timing attack against PMKIDs.
> ---
>   src/eapol.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =


Applied with a minor formatting tweak to the first chunk (>80 chars / line)

Regards,
-Denis
--===============2542976329439875436==--

