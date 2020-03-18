Content-Type: multipart/mixed; boundary="===============5947621771050893642=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 03/12] frame-xchg: Handle l_io errors through disconnect
 callback
Date: Wed, 18 Mar 2020 17:05:28 +0100
Message-ID: <CAOq732+5xKaqTwyO=Zx31SYpW5+r8qKhv0STGy7X3aACocSkwA@mail.gmail.com>
In-Reply-To: <d9900749-9708-6a3c-a9b6-d32654e4f893@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5947621771050893642==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 18 Mar 2020 at 16:49, Denis Kenzior <denkenz@gmail.com> wrote:
> On 3/18/20 9:45 AM, Andrew Zaborowski wrote:
> > @@ -234,6 +234,7 @@ static void frame_watch_group_destroy(void *data)
> >               l_genl_remove_unicast_watch(iwd_get_genl(),
> >                                               group->unicast_watch_id);
> >
> > +     l_io_set_disconnect_handler(group->io, NULL, NULL, NULL);
>
> This part shouldn't be necessary?  io_closed clears out the
> disconnect_handler and disconnect_destroy callbacks...

This is meant to handle cases like l_queue_destroy(watch_groups,
frame_watch_group_destroy) where the l_io_destroy() may close the
socket, if not already closed, and call the disconnect handler which
would try to remove the group from watch_groups again, so we probably
do need this.

Best regards
--===============5947621771050893642==--

