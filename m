Content-Type: multipart/mixed; boundary="===============3604116342883397514=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 08/12] watchlist: Allow watch CBs to call watchlist_destroy
Date: Wed, 18 Mar 2020 13:50:51 -0500
Message-ID: <b53d2f4f-fdc5-1aac-d62c-d8a017bac4b7@gmail.com>
In-Reply-To: <20200318144531.30613-8-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3604116342883397514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 3/18/20 9:45 AM, Andrew Zaborowski wrote:
> If during WATCHLIST_NOTIFY{,_MATCHES,_NO_ARGS} one of the watch
> notify callback triggers a call to watchlist_destroy, give up calling
> remaining watches and destroy the watchlist without crashing.  This is
> useful in frame-xchg.c (P2P use case) where a frame watch may trigger
> a move to a new state after receiving a specific frame, and remove one
> group of frame watches (including its watchlist) to create a different
> group.
> ---
>   src/watchlist.c |  5 +++++
>   src/watchlist.h | 22 ++++++++++++++++++----
>   2 files changed, 23 insertions(+), 4 deletions(-)
> =


Patch 8, 9 and 12 applied, thanks.

Regards,
-Denis

--===============3604116342883397514==--

