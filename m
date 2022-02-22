Content-Type: multipart/mixed; boundary="===============5736943781378513143=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v7 1/9] dpp-util: add URI parsing
Date: Tue, 22 Feb 2022 16:26:38 -0600
Message-ID: <22ccb3dd-8272-dff0-4c3f-c7c41f9f8b85@gmail.com>
In-Reply-To: 20220222222847.2480099-1-prestwoj@gmail.com

--===============5736943781378513143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/22/22 16:28, James Prestwood wrote:
> Parses K (key), M (mac), C (class/channels), and V (version) tokens
> into a new structure dpp_uri_info. H/I are not parsed since there
> currently isn't any use for them.
> ---
>   src/dpp-util.c | 250 +++++++++++++++++++++++++++++++++++++++++++++++++
>   src/dpp-util.h |  13 +++
>   2 files changed, 263 insertions(+)
> =


All applied, thanks.

Regards,
-Denis

--===============5736943781378513143==--

