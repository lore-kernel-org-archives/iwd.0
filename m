Content-Type: multipart/mixed; boundary="===============0339319173996638117=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] frame-xchg: fix incorrect length check
Date: Mon, 22 Jun 2020 10:30:32 -0500
Message-ID: <cb35fbd9-cfe2-edb6-2e6b-2d2f50d9fb3e@gmail.com>
In-Reply-To: <20200622152516.22006-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0339319173996638117==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 6/22/20 10:25 AM, James Prestwood wrote:
> frame_xchg_startv was using sizeof(mmpdu) to check the minimum length
> for a frame. Instead mmpdu_header_len should be used since this checks
> fc.order and returns either 24 or 28 bytes, not 28 bytes always.
> =

> This change adds the requirement that the first iovec in the array
> must contain at least the first 2 bytes (mmpdu_fc) of the header.
> This really shouldn't be a problem since all current users of
> frame-xchg put the entire header (or entire frame) into the first
> iovec in the array.
> ---
>   src/frame-xchg.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis
--===============0339319173996638117==--

