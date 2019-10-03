Content-Type: multipart/mixed; boundary="===============4257139977337736303=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] station: don't reset/(re)configure/destroy NULL
 netconfig's
Date: Thu, 03 Oct 2019 12:35:14 -0500
Message-ID: <5095bc23-e236-1646-b9e5-8f87fe471b51@gmail.com>
In-Reply-To: <20191003172409.590-1-w@wdtz.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4257139977337736303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Will,

On 10/3/19 12:24 PM, Will Dietz wrote:
> Fixes crashes when `enable_network_config` is false (default).
> ---
>   src/station.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)

Applied, thanks.

Regards,
-Denis

--===============4257139977337736303==--

