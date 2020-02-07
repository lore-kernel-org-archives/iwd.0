Content-Type: multipart/mixed; boundary="===============7593548740599119895=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] frame-xchg: Add new groups to watch_groups list
Date: Fri, 07 Feb 2020 15:38:05 -0600
Message-ID: <efdffa8f-b321-7ebf-e206-09eba2a63d9f@gmail.com>
In-Reply-To: <20200207113914.3869-2-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7593548740599119895==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 2/7/20 5:39 AM, Andrew Zaborowski wrote:
> I forgot to actually add new groups being created in
> frame_watch_group_get to the watch_groups queue, meaning that we'd
> re-create the group every time a new watch was added to the group.
> ---
>   src/frame-xchg.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7593548740599119895==--

