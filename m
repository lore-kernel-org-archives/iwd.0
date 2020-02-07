Content-Type: multipart/mixed; boundary="===============8888838137390846036=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] frame-xchg: Use both group_id and wdev_id when
 removing group
Date: Fri, 07 Feb 2020 15:42:06 -0600
Message-ID: <8e175401-cce9-0f58-e650-76b9ed961b31@gmail.com>
In-Reply-To: <20200207113914.3869-4-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8888838137390846036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 2/7/20 5:39 AM, Andrew Zaborowski wrote:
> In frame_watch_group_remove I forgot to actually match the group to be
> removed by both wdev_id and group_id.  group_ids are unique only in the
> scope of one wdev.
> ---
>   src/frame-xchg.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============8888838137390846036==--

