Content-Type: multipart/mixed; boundary="===============2259367446727824404=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] eap-aka: round to nearest word on message buffers
Date: Fri, 30 Jul 2021 10:39:13 -0500
Message-ID: <e4c21f72-4266-eec4-4cba-4b9f12dcbed7@gmail.com>
In-Reply-To: <20210730150727.199809-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2259367446727824404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 7/30/21 10:07 AM, James Prestwood wrote:
> One of these message buffers was overflowing due to padding not
> being taken into account (caught by sanitizers). Wrapped the length
> of all message buffers with EAP_SIM_ROUND as to account for any
> padding that attributes may add.
> ---
>   src/eap-aka.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

Regards,
-Denis

--===============2259367446727824404==--

