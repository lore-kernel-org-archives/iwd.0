Content-Type: multipart/mixed; boundary="===============6810159465539612473=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 1/7] ie: add ie_parse_owe_transition_from_data
Date: Thu, 16 Sep 2021 12:42:11 -0500
Message-ID: <a33b688c-e04d-db5e-05d1-2734a8c40529@gmail.com>
In-Reply-To: 20210916163046.30817-1-prestwoj@gmail.com

--===============6810159465539612473==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/16/21 11:30 AM, James Prestwood wrote:
> This is a parser for the WFA OWE Transition element. For now the
> optional band/channel bytes will not be parsed as hostapd does not
> yet support these and would also require the 802.11 appendix E-1
> to be added to IWD. Because of this OWE Transition networks are
> assumed to be on the same channel as their open counterpart.
> ---
>   src/ie.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   src/ie.h |  5 +++++
>   2 files changed, 50 insertions(+)
> =

> v3:
>   * Changed to handle non-utf8 SSIDs
> =


Patches 1-4 applied, thanks.

Regards,
-Denis

--===============6810159465539612473==--

