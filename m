Content-Type: multipart/mixed; boundary="===============0793922117106772498=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] station: print which BSS is being connected to
Date: Mon, 14 Sep 2020 16:03:26 -0500
Message-ID: <7f74c94b-91cc-e50a-caa9-f1c0809153a7@gmail.com>
In-Reply-To: <20200914210233.428835-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0793922117106772498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/14/20 4:02 PM, James Prestwood wrote:
> For multi-bss networks its nice to know which BSS is being connected
> to. The ranking can hint at it, but blacklisting or network capabilities
> could effect which network is actually chosen. An explicit debug print
> makes debugging much easier.
> ---
>   src/station.c | 2 ++
>   1 file changed, 2 insertions(+)
> =


All applied, thanks.

Regards,
-Denis

--===============0793922117106772498==--

