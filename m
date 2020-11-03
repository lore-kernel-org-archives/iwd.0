Content-Type: multipart/mixed; boundary="===============6423782026115378615=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] ap: make APRanges optional
Date: Tue, 03 Nov 2020 13:59:25 -0600
Message-ID: <5f42c94c-e4e3-d976-e6ea-f1fbc2357327@gmail.com>
In-Reply-To: <20201103190641.2736204-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6423782026115378615==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/3/20 1:06 PM, James Prestwood wrote:
> If EnableNetworkConfiguration was enabled ap.c required that
> APRanges also be set. This prevents IWD from starting which
> effects a perfectly valid station configuration. Instead if
> APRanges is not provided IWD still allows ap_init to pass but
> DHCP just will not be enabled.
> ---
>   src/ap.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============6423782026115378615==--

