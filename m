Content-Type: multipart/mixed; boundary="===============0617851875961499760=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] unit: test-sae: zero out frame buffers
Date: Mon, 08 Feb 2021 16:25:48 -0600
Message-ID: <99f6e054-e21c-ad94-127b-94971de86ff8@gmail.com>
In-Reply-To: <20210208222314.618508-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0617851875961499760==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/8/21 4:23 PM, James Prestwood wrote:
> Not all the authenticate frame elements are set and were assumed
> to be zero. Since alloca does not memset data it needs to be
> done explicitly.
> ---
>   unit/test-sae.c | 1 +
>   1 file changed, 1 insertion(+)
> =


Applied, thanks.

Regards,
-Denis
--===============0617851875961499760==--

