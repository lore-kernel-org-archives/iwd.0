Content-Type: multipart/mixed; boundary="===============8737071594514678225=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/8] netdev: factor out FT handshake preparation
Date: Fri, 16 Apr 2021 11:33:14 -0500
Message-ID: <772963e0-e955-77b8-e852-1ee2ecf0235e@gmail.com>
In-Reply-To: <20210415224508.1823614-5-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8737071594514678225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/15/21 5:45 PM, James Prestwood wrote:
> This isolates the handshake/nhs preparation for
> FT into its own function to be used by both
> FT-over-Air and FT-over-DS after refactoring.
> ---
>   src/netdev.c | 99 +++++++++++++++++++++++++++-------------------------
>   1 file changed, 52 insertions(+), 47 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============8737071594514678225==--

