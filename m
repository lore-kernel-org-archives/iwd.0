Content-Type: multipart/mixed; boundary="===============3243950918160093967=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v5 1/4] dpp-util: add DPP attribute building APIs
Date: Fri, 17 Dec 2021 14:15:02 -0600
Message-ID: <1c889849-26d3-a031-8137-7cb8f47df055@gmail.com>
In-Reply-To: 20211217191451.179444-1-prestwoj@gmail.com

--===============3243950918160093967==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/17/21 13:14, James Prestwood wrote:
> ---
>   src/dpp-util.c | 143 +++++++++++++++++++++++++++++++++++++++++++++++++
>   src/dpp-util.h |  10 ++++
>   src/dpp.c      |  10 ----
>   3 files changed, 153 insertions(+), 10 deletions(-)
> =

> v5:
>   * Moved these APIs into dpp-util instead of dpp.c so they can be
>     unit tested
>   * Changed so the caller supplies ad0/ad1. This takes the burden off
>     these utilities to sort out what type of frame, and any quirks of
>     how AAD is supposed to be used (see comments in authentication
>     and configuration patches)
> =


Applied, thanks.

Regards,
-Denis

--===============3243950918160093967==--

