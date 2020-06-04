Content-Type: multipart/mixed; boundary="===============2602402622881607080=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] frame-xchg: Fix frame_watch_remove_by_handler for
 group 0
Date: Thu, 04 Jun 2020 09:19:44 -0500
Message-ID: <e3bed893-e1c4-bfbb-9c3d-7a346b604dd3@gmail.com>
In-Reply-To: <20200531005645.257055-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2602402622881607080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 5/30/20 7:56 PM, Andrew Zaborowski wrote:
> Don't match the default group's (group_id 0) wdev_id against the
> provided wdev_id because the default group can be used on all wdevs and
> its wdev_id is 0.  Also match individual item's wdev_id in the group to
> make up for this although it normally wouldn't matter.
> ---
>   src/frame-xchg.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============2602402622881607080==--

