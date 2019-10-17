Content-Type: multipart/mixed; boundary="===============7329981775255509631=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] eapol: reorder eapol_sm_free
Date: Wed, 16 Oct 2019 21:18:12 -0500
Message-ID: <944cfab2-5a9a-26c4-3cbb-4b1a152d0923@gmail.com>
In-Reply-To: <20191016234304.14716-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7329981775255509631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hi James,

On 10/16/19 6:43 PM, James Prestwood wrote:
> This was reported by coverity as a use after free. Technically it is
> correct, though this will not pose a problem since l_queue_remove will
> not actually dereference the pointer. Reordering this should fix the
> warning and not change behavior at all.
> ---
>   src/eapol.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7329981775255509631==--

