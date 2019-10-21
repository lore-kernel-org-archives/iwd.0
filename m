Content-Type: multipart/mixed; boundary="===============4871823538839758951=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sae: fix incorrect length adjustment
Date: Mon, 21 Oct 2019 17:12:19 -0500
Message-ID: <dcd703e4-2bb5-f250-0a7e-c6a0e52a8609@gmail.com>
In-Reply-To: <20191021215917.12691-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4871823538839758951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/21/19 4:59 PM, James Prestwood wrote:
> The commit/confirm processing was incorrectly subtracting 2 from
> the length when they should be subtracting 6. As with the other
> similar change, the length is validated with mpdu_validate so
> subtracting 6 will not cause an overflow.
> ---
>   src/sae.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Regards,
-Denis

--===============4871823538839758951==--

