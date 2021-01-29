Content-Type: multipart/mixed; boundary="===============1646168853017591114=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ap: add DEL_STATION path to fullmac AP handling
Date: Fri, 29 Jan 2021 11:36:40 -0600
Message-ID: <2b55edc6-da5a-eb4b-2b5b-dcfdd012b7b9@gmail.com>
In-Reply-To: <20210129172818.80132-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1646168853017591114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/29/21 11:28 AM, James Prestwood wrote:
> This is how a fullmac card tells userspace that a station has
> left. This fixes the issue where the same client cannot re-connect
> to the same AP multiple times. ap_new_station was renamed to
> ap_handle_new_station for consistency.
> ---
>   src/ap.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 42 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis
--===============1646168853017591114==--

