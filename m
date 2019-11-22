Content-Type: multipart/mixed; boundary="===============5538804527751082089=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] scan: Parse P2P IEs according to frame type
Date: Thu, 21 Nov 2019 20:52:14 -0600
Message-ID: <280f82a4-c2c5-5fd0-6332-bac5a152d440@gmail.com>
In-Reply-To: <20191121201557.16506-3-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5538804527751082089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/21/19 2:15 PM, Andrew Zaborowski wrote:
> Save the source frame type in struct scan_bss as it may affect how some
> of the data in the struct will be parsed.  Also replace the P2P IE
> payload data in that struct with a union containing pre-parsed p2p
> attributes corresponding to the frame type.
> =

> This means users don't have to call the parsers in p2putil.c on that
> data, which wouldn't have worked anyway because those parsers assume
> input is the raw IE sequence rather than just the "payload".
> ---
>   src/scan.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++-----
>   src/scan.h |  17 +++++++-
>   2 files changed, 128 insertions(+), 12 deletions(-)
> =


Patch 3 & 4 applied, thanks.

Regards,
-Denis

--===============5538804527751082089==--

