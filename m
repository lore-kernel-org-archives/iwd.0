Content-Type: multipart/mixed; boundary="===============1069276204003140373=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 03/12] frame-xchg: Handle l_io errors through disconnect
 callback
Date: Wed, 18 Mar 2020 15:50:15 +0000
Message-ID: <d9900749-9708-6a3c-a9b6-d32654e4f893@gmail.com>
In-Reply-To: <20200318144531.30613-3-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1069276204003140373==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 3/18/20 9:45 AM, Andrew Zaborowski wrote:
> Don't try to handle l_io read errors in the read handler destroy
> callback.  That cb is called both when the read handler returns false,
> and when poll returns an error.  In neither case the l_io is
> automatically destroyed so we were wrongly setting group->io =3D NULL,
> we need to manually destroy the l_io.  But you can't use l_io_destroy
> safely from inside the read handler destroy callback.  Do this in the
> disconnect callback instead which is safe.
> ---
>   src/frame-xchg.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> =

> diff --git a/src/frame-xchg.c b/src/frame-xchg.c
> index ce69c454..3719ed6c 100644
> --- a/src/frame-xchg.c
> +++ b/src/frame-xchg.c
> @@ -234,6 +234,7 @@ static void frame_watch_group_destroy(void *data)
>   		l_genl_remove_unicast_watch(iwd_get_genl(),
>   						group->unicast_watch_id);
>   =

> +	l_io_set_disconnect_handler(group->io, NULL, NULL, NULL);

This part shouldn't be necessary?  io_closed clears out the =

disconnect_handler and disconnect_destroy callbacks...

Rest looks good.  Let me know if I should just edit out the change above.

Regards,
-Denis
--===============1069276204003140373==--

