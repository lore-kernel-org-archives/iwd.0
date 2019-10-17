Content-Type: multipart/mixed; boundary="===============6727170098583523004=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] ie: reorder ie_parse_osen to fix uninitialized value
Date: Wed, 16 Oct 2019 21:25:57 -0500
Message-ID: <669ed897-bd80-1286-ed59-3efbb1cf578f@gmail.com>
In-Reply-To: <20191016234304.14716-4-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6727170098583523004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/16/19 6:43 PM, James Prestwood wrote:
> RSNE_ADVANCE could result in a jump to the done label where info would
> be copied without being initialized.
> ---
>   src/ie.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

applied, thanks.

Regards,
-Denis

--===============6727170098583523004==--

