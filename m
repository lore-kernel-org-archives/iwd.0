Content-Type: multipart/mixed; boundary="===============4665640886053486183=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] client: Rewrite workaround for readline
Date: Thu, 09 Apr 2020 15:27:30 +0000
Message-ID: <3f078749-01d0-9a4a-5132-255ab922c828@gmail.com>
In-Reply-To: <20200408231407.11321-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4665640886053486183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 4/8/20 6:14 PM, Tim Kourt wrote:
> Instead of calling display(""), explicitly use the sequence of
> commands to force readline to properly update its internal state
> and re-display the prompt.
> ---
>   client/display.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============4665640886053486183==--

